import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'generated/l10n.dart';
import 'airplane_form_page.dart';
import 'models/airplane.dart';

class AirplaneListPage extends StatefulWidget {
  @override
  _AirplaneListPageState createState() => _AirplaneListPageState();
}

class _AirplaneListPageState extends State<AirplaneListPage> {
  List<Airplane> _airplanes = [];
  Airplane? _selectedAirplane;
  bool _isAddingAirplane = false;
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadAirplanes();
  }

  Future<void> _loadAirplanes() async {
    List<Airplane> airplanes = await _databaseHelper.getAirplanes();
    setState(() {
      _airplanes = airplanes;
    });
  }

  void _navigateToAddAirplane() {
    setState(() {
      _isAddingAirplane = true;
      _selectedAirplane = null;
    });

    if (MediaQuery.of(context).size.width <= 600) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AirplaneFormPage(
            airplane: null,
            onSave: _handleFormSave,
          ),
        ),
      ).then((value) {
        if (value == true) {
          _loadAirplanes();
        }
      });
    }
  }

  void _navigateToEditAirplane(Airplane airplane) {
    setState(() {
      _isAddingAirplane = false;
      _selectedAirplane = airplane;
    });

    if (MediaQuery.of(context).size.width <= 600) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AirplaneFormPage(
            airplane: airplane,
            onSave: _handleFormSave,
          ),
        ),
      ).then((value) {
        if (value == true) {
          _loadAirplanes();
        }
      });
    }
  }

  void _handleFormSave() {
    _loadAirplanes();
    setState(() {
      _isAddingAirplane = false;
      _selectedAirplane = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Tablet/Desktop Layout
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(S.of(context).airplaneList),
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: _airplanes.isEmpty
                            ? Center(child: Text(S.of(context).noAirplanesFound))
                            : ListView.builder(
                          itemCount: _airplanes.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_airplanes[index].type),
                              subtitle: Text(S.of(context).passengers(_airplanes[index].numberOfPassengers)),
                              onTap: () {
                                setState(() {
                                  _selectedAirplane = _airplanes[index];
                                  _isAddingAirplane = false;
                                });
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: _navigateToAddAirplane,
                          child: Text(S.of(context).addAirplane),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: _isAddingAirplane || _selectedAirplane != null
                    ? AirplaneFormPage(
                  airplane: _selectedAirplane,
                  onSave: _handleFormSave,
                )
                    : Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Center(
                    child: Text(
                      S.of(context).selectAirplaneDetails,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          // Phone Layout
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).airplaneList),
            ),
            body: Column(
              children: [
                Expanded(
                  child: _airplanes.isEmpty
                      ? Center(child: Text(S.of(context).noAirplanesFound))
                      : ListView.builder(
                    itemCount: _airplanes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_airplanes[index].type),
                        subtitle: Text(S.of(context).passengers(_airplanes[index].numberOfPassengers)),
                        onTap: () => _navigateToEditAirplane(_airplanes[index]),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _navigateToAddAirplane,
                    child: Text(S.of(context).addAirplane),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

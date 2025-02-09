import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'generated/l10n.dart';
import 'airplane_form_page.dart';
import 'models/airplane.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';  // Import the secure storage package

class AirplaneListPage extends StatefulWidget {
  @override
  _AirplaneListPageState createState() => _AirplaneListPageState();
}

class _AirplaneListPageState extends State<AirplaneListPage> {
  List<Airplane> _airplanes = [];
  Airplane? _selectedAirplane;
  bool _isAddingAirplane = false;
  DatabaseHelper _databaseHelper = DatabaseHelper();
  final _storage = FlutterSecureStorage();  // Instance of the secure storage

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
    if (_airplanes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).noAirplanesFound)),
      );
    }
  }

  void _navigateToAddAirplane() {
    if (MediaQuery.of(context).size.width > 600) {
      setState(() {
        _isAddingAirplane = true;
        _selectedAirplane = null;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AirplaneFormPage(
            airplane: null,
            onSave: _handleFormSave,
            onCancel: _handleFormCancel,
          ),
        ),
      ).then((value) {
        if (value == true) {
          _loadAirplanes();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).airplaneAdded)),
          );
        }
      });
    }
  }

  void _navigateToEditAirplane(Airplane airplane) {
    if (MediaQuery.of(context).size.width > 600) {
      setState(() {
        _isAddingAirplane = false;
        _selectedAirplane = airplane;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AirplaneFormPage(
            airplane: airplane,
            onSave: _handleFormSave,
            onCancel: _handleFormCancel,
          ),
        ),
      ).then((value) {
        if (value == true) {
          _loadAirplanes();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).airplaneEdited)),
          );
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

  void _handleFormCancel() {
    setState(() {
      _isAddingAirplane = false;
      _selectedAirplane = null;
    });
  }

  Future<void> _handleAirplaneDelete(Airplane airplane) async {
    await _databaseHelper.deleteAirplane(airplane.id!);
    _loadAirplanes();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).airplaneDeleted)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Tablet/Desktop Layout
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).airplanes),
            ),
            body: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: _airplanes.length,
                    itemBuilder: (context, index) {
                      final airplane = _airplanes[index];
                      return ListTile(
                        title: Text(airplane.type),
                        subtitle: Text('${airplane.numberOfPassengers} ${S.of(context).passengers}'),
                        onTap: () => _navigateToEditAirplane(airplane),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            final confirmed = await _showAlertDialog(
                              S.of(context).deleteAirplane,
                              S.of(context).confirmDelete,
                            );
                            if (confirmed == true) {
                              _handleAirplaneDelete(airplane);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
                if (_isAddingAirplane || _selectedAirplane != null)
                  Expanded(
                    flex: 3,
                    child: AirplaneFormPage(
                      airplane: _selectedAirplane,
                      onSave: _handleFormSave,
                      onCancel: _handleFormCancel,
                    ),
                  ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _navigateToAddAirplane,
              child: Icon(Icons.add),
            ),
          );
        } else {
          // Mobile Layout
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).airplanes),
            ),
            body: ListView.builder(
              itemCount: _airplanes.length,
              itemBuilder: (context, index) {
                final airplane = _airplanes[index];
                return ListTile(
                  title: Text(airplane.type),
                  subtitle: Text('${airplane.numberOfPassengers} passengers'),
                  onTap: () => _navigateToEditAirplane(airplane),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      final confirmed = await _showAlertDialog(
                        S.of(context).deleteAirplane,
                        S.of(context).confirmDelete,
                      );
                      if (confirmed == true) {
                        _handleAirplaneDelete(airplane);
                      }
                    },
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _navigateToAddAirplane,
              child: Icon(Icons.add),
            ),
          );
        }
      },
    );
  }

  Future<bool?> _showAlertDialog(String title, String message) async {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text(S.of(context).cancel),
              onPressed: () {
                Navigator.of(context).pop(false); // User pressed cancel
              },
            ),
            TextButton(
              child: Text(S.of(context).confirm),
              onPressed: () {
                Navigator.of(context).pop(true); // User pressed confirm
              },
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'generated/l10n.dart';
import 'add_airplane_page.dart';
import 'airplane_detail_page.dart';

class AirplaneListPage extends StatefulWidget {
  @override
  _AirplaneListPageState createState() => _AirplaneListPageState();
}

class _AirplaneListPageState extends State<AirplaneListPage> {
  List<Airplane> _airplanes = [];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).airplaneList),
      ),
      body: _airplanes.isEmpty
          ? Center(child: Text('No airplanes found'))
          : ListView.builder(
        itemCount: _airplanes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_airplanes[index].type),
            subtitle: Text(S.of(context).passengers(_airplanes[index].numberOfPassengers.toString())),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AirplaneDetailPage(airplane: _airplanes[index]),
                ),
              ).then((value) {
                if (value == true) {
                  _loadAirplanes(); // Reload the list after updating or deleting an airplane
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAirplanePage()),
          ).then((value) {
            if (value == true) {
              _loadAirplanes(); // Reload the list after adding a new airplane
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

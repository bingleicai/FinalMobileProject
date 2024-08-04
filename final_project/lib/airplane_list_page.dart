import 'package:flutter/material.dart';
import 'database_helper.dart';
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
    print('Loaded Airplanes: $airplanes'); // Debugging statement
    setState(() {
      _airplanes = airplanes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airplane List'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: _showInstructions,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _airplanes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_airplanes[index].type),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AirplaneDetailPage(airplane: _airplanes[index]),
                      ),
                    ).then((_) {
                      _loadAirplanes();
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddAirplanePage()),
                ).then((_) {
                  _loadAirplanes();
                });
              },
              child: Text('Add Airplane'),
            ),
          ),
        ],
      ),
    );
  }

  void _showInstructions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Instructions'),
          content: Text('Instructions on how to use the interface.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
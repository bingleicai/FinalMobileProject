import 'package:flutter/material.dart';
import 'database_helper.dart';

class AirplaneDetailPage extends StatefulWidget {
  final Airplane airplane;

  AirplaneDetailPage({required this.airplane});

  @override
  _AirplaneDetailPageState createState() => _AirplaneDetailPageState();
}

class _AirplaneDetailPageState extends State<AirplaneDetailPage> {
  final _formKey = GlobalKey<FormState>();
  late String _type;
  late int _numberOfPassengers;
  late double _maxSpeed;
  late double _range;
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _type = widget.airplane.type;
    _numberOfPassengers = widget.airplane.numberOfPassengers;
    _maxSpeed = widget.airplane.maxSpeed;
    _range = widget.airplane.range;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airplane Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _type,
                decoration: InputDecoration(labelText: 'Airplane Type'),
                onSaved: (value) => _type = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter airplane type';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _numberOfPassengers.toString(),
                decoration: InputDecoration(labelText: 'Number of Passengers'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _numberOfPassengers = int.parse(value!),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter number of passengers';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _maxSpeed.toString(),
                decoration: InputDecoration(labelText: 'Max Speed'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _maxSpeed = double.parse(value!),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter max speed';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _range.toString(),
                decoration: InputDecoration(labelText: 'Range'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _range = double.parse(value!),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter range';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _updateAirplane,
                    child: Text('Update'),
                  ),
                  ElevatedButton(
                    onPressed: _deleteAirplane,
                    child: Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateAirplane() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _databaseHelper.updateAirplane(
        Airplane(
          id: widget.airplane.id,
          type: _type,
          numberOfPassengers: _numberOfPassengers,
          maxSpeed: _maxSpeed,
          range: _range,
        ),
      ).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Airplane updated successfully')),
        );
        Navigator.pop(context, true);
      });
    }
  }

  void _deleteAirplane() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Airplane'),
        content: Text('Are you sure you want to delete this airplane?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _databaseHelper.deleteAirplane(widget.airplane.id!).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Airplane deleted successfully')),
                );
                Navigator.pop(context, true);
              });
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
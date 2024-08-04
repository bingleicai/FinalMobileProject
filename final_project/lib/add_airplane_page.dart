import 'package:flutter/material.dart';
import 'database_helper.dart';

class AddAirplanePage extends StatefulWidget {
  @override
  _AddAirplanePageState createState() => _AddAirplanePageState();
}

class _AddAirplanePageState extends State<AddAirplanePage> {
  final _formKey = GlobalKey<FormState>();
  String _type = '';
  int _numberOfPassengers = 0;
  double _maxSpeed = 0.0;
  double _range = 0.0;
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Airplane'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
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
              ElevatedButton(
                onPressed: _addAirplane,
                child: Text('Add Airplane'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addAirplane() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Airplane newAirplane = Airplane(
        type: _type,
        numberOfPassengers: _numberOfPassengers,
        maxSpeed: _maxSpeed,
        range: _range,
      );
      print('Adding Airplane: $newAirplane'); // Debugging statement
      _databaseHelper.insertAirplane(newAirplane).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Airplane added successfully')),
        );
        Navigator.pop(context);
      });
    }
  }
}
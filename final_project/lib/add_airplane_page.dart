import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'generated/l10n.dart';

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
        title: Text(S.of(context).addAirplane),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: S.of(context).airplaneType),
                onSaved: (value) => _type = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).airplaneType;
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: S.of(context).numberOfPassengers),
                keyboardType: TextInputType.number,
                onSaved: (value) => _numberOfPassengers = int.parse(value!),
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).numberOfPassengers;
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: S.of(context).maxSpeed),
                keyboardType: TextInputType.number,
                onSaved: (value) => _maxSpeed = double.parse(value!),
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).maxSpeed;
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: S.of(context).range),
                keyboardType: TextInputType.number,
                onSaved: (value) => _range = double.parse(value!),
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).range;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addAirplane,
                child: Text(S.of(context).addAirplane),
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
      _databaseHelper.insertAirplane(newAirplane).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).addAirplane)),
        );
        Navigator.pop(context, true); // Return true to indicate success
      });
    }
  }
}
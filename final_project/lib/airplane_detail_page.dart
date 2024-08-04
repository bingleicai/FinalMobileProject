import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'generated/l10n.dart';

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

  void _updateAirplane() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Airplane updatedAirplane = Airplane(
        id: widget.airplane.id,
        type: _type,
        numberOfPassengers: _numberOfPassengers,
        maxSpeed: _maxSpeed,
        range: _range,
      );
      _databaseHelper.updateAirplane(updatedAirplane).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).update)),
        );
        Navigator.pop(context, true); // Return true to indicate success
      });
    }
  }

  void _deleteAirplane() {
    _databaseHelper.deleteAirplane(widget.airplane.id!).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).delete)),
      );
      Navigator.pop(context, true); // Return true to indicate success
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).airplaneType),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _type,
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
                initialValue: _numberOfPassengers.toString(),
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
                initialValue: _maxSpeed.toString(),
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
                initialValue: _range.toString(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _updateAirplane,
                    child: Text(S.of(context).update),
                  ),
                  ElevatedButton(
                    onPressed: _deleteAirplane,
                    child: Text(S.of(context).delete),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
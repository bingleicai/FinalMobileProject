import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models/airplane.dart';
import 'generated/l10n.dart';

class AirplaneFormPage extends StatefulWidget {
  final Airplane? airplane;

  AirplaneFormPage({this.airplane});

  @override
  _AirplaneFormPageState createState() => _AirplaneFormPageState();
}

class _AirplaneFormPageState extends State<AirplaneFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _type;
  late int _numberOfPassengers;
  late double _maxSpeed;
  late double _range;
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    if (widget.airplane != null) {
      _type = widget.airplane!.type;
      _numberOfPassengers = widget.airplane!.numberOfPassengers;
      _maxSpeed = widget.airplane!.maxSpeed;
      _range = widget.airplane!.range;
    }
  }

  Future<void> _saveAirplane() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Airplane airplane = Airplane(
        id: widget.airplane?.id,
        type: _type,
        numberOfPassengers: _numberOfPassengers,
        maxSpeed: _maxSpeed,
        range: _range,
      );
      if (widget.airplane == null) {
        await _databaseHelper.insertAirplane(airplane);
      } else {
        await _databaseHelper.updateAirplane(airplane);
      }
      Navigator.pop(context, true);
    } else {
      _showAlertDialog(S.of(context).error, S.of(context).fillAllFields);
    }
  }

  Future<void> _deleteAirplane() async {
    if (widget.airplane != null) {
      await _databaseHelper.deleteAirplane(widget.airplane!.id!);
      Navigator.pop(context, true);
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(S.of(context).ok),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.airplane == null ? S.of(context).addAirplane : S.of(context).airplaneType),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.airplane?.type ?? '',
                decoration: InputDecoration(labelText: S.of(context).airplaneType),
                onSaved: (value) => _type = value!,
                validator: (value) => value!.isEmpty ? S.of(context).fillAllFields : null,
              ),
              TextFormField(
                initialValue: widget.airplane?.numberOfPassengers.toString() ?? '',
                decoration: InputDecoration(labelText: S.of(context).numberOfPassengers),
                keyboardType: TextInputType.number,
                onSaved: (value) => _numberOfPassengers = int.parse(value!),
                validator: (value) => value!.isEmpty ? S.of(context).fillAllFields : null,
              ),
              TextFormField(
                initialValue: widget.airplane?.maxSpeed.toString() ?? '',
                decoration: InputDecoration(labelText: S.of(context).maxSpeed),
                keyboardType: TextInputType.number,
                onSaved: (value) => _maxSpeed = double.parse(value!),
                validator: (value) => value!.isEmpty ? S.of(context).fillAllFields : null,
              ),
              TextFormField(
                initialValue: widget.airplane?.range.toString() ?? '',
                decoration: InputDecoration(labelText: S.of(context).range),
                keyboardType: TextInputType.number,
                onSaved: (value) => _range = double.parse(value!),
                validator: (value) => value!.isEmpty ? S.of(context).fillAllFields : null,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _saveAirplane,
                    child: Text(widget.airplane == null ? S.of(context).addAirplane : S.of(context).update),
                  ),
                  if (widget.airplane != null)
                    ElevatedButton(
                      onPressed: _deleteAirplane,
                      child: Text(S.of(context).delete),
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
}

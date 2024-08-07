import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models/airplane.dart';
import 'generated/l10n.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';  // Import the secure storage package

class AirplaneFormPage extends StatefulWidget {
  final Airplane? airplane;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  AirplaneFormPage({this.airplane, required this.onSave, required this.onCancel});

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
  final _storage = FlutterSecureStorage();  // Instance of the secure storage

  @override
  void initState() {
    super.initState();
    _type = widget.airplane?.type ?? '';
    _numberOfPassengers = widget.airplane?.numberOfPassengers ?? 0;
    _maxSpeed = widget.airplane?.maxSpeed ?? 0.0;
    _range = widget.airplane?.range ?? 0.0;
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
      bool isNew = widget.airplane == null;
      if (isNew) {
        await _databaseHelper.insertAirplane(airplane);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).airplaneAdded)),
        );
      } else {
        await _databaseHelper.updateAirplane(airplane);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).airplaneUpdated)),
        );
      }
      widget.onSave();
      if (MediaQuery.of(context).size.width <= 600) {
        Navigator.pop(context, true); // Navigate back to AirplaneListPage on mobile
      }
    } else {
      _showAlertDialog(S.of(context).error, S.of(context).fillAllFields);
    }
  }

  Future<void> _deleteAirplane() async {
    if (widget.airplane != null) {
      await _databaseHelper.deleteAirplane(widget.airplane!.id!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).airplaneDeleted)),
      );
      widget.onSave();
      if (MediaQuery.of(context).size.width <= 600) {
        Navigator.pop(context, true); // Navigate back to AirplaneListPage on mobile
      }
    }
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
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(S.of(context).confirm),
              onPressed: () {
                Navigator.of(context).pop(true);
              }
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.airplane == null
            ? S.of(context).addAirplane
            : S.of(context).editAirplane),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _type,
                decoration: InputDecoration(labelText: S.of(context).type),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).fieldRequired;
                  }
                  return null;
                },
                onSaved: (value) {
                  _type = value!;
                },
              ),
              TextFormField(
                initialValue: _numberOfPassengers.toString(),
                decoration: InputDecoration(labelText: S.of(context).numberOfPassengers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).fieldRequired;
                  }
                  return null;
                },
                onSaved: (value) {
                  _numberOfPassengers = int.parse(value!);
                },
              ),
              TextFormField(
                initialValue: _maxSpeed.toString(),
                decoration: InputDecoration(labelText: S.of(context).maxSpeed),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).fieldRequired;
                  }
                  return null;
                },
                onSaved: (value) {
                  _maxSpeed = double.parse(value!);
                },
              ),
              TextFormField(
                initialValue: _range.toString(),
                decoration: InputDecoration(labelText: S.of(context).range),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).fieldRequired;
                  }
                  return null;
                },
                onSaved: (value) {
                  _range = double.parse(value!);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _saveAirplane,
                    child: Text(S.of(context).save),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      widget.onCancel();
                      if (MediaQuery.of(context).size.width <= 600) {
                        Navigator.pop(context); // Navigate back to AirplaneListPage on mobile
                      }
                    },
                    child: Text(S.of(context).cancel),
                  ),
                  if (widget.airplane != null) ...[
                    SizedBox(width: 8),
                    ElevatedButton(
                      child: Text(S.of(context).delete),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () async {
                        final confirmed = await _showAlertDialog(
                          S.of(context).deleteFlight,
                          S.of(context).confirmDelete,
                        );
                        if (confirmed == true) {
                          await _deleteAirplane();
                        }
                      },
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

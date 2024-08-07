import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models/flight.dart';
import 'models/airplane.dart';
import 'generated/l10n.dart';

class FlightFormPage extends StatefulWidget {
  final Flight? flight;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  FlightFormPage({this.flight, required this.onSave, required this.onCancel});

  @override
  _FlightFormPageState createState() => _FlightFormPageState();
}

class _FlightFormPageState extends State<FlightFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _departureCity;
  late String _destinationCity;
  late String _departureTime;
  late String _arrivalTime;
  late int _selectedAirplaneId;
  List<Airplane> _airplanes = [];
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _departureCity = widget.flight?.departureCity ?? '';
    _destinationCity = widget.flight?.destinationCity ?? '';
    _departureTime = widget.flight?.departureTime ?? '';
    _arrivalTime = widget.flight?.arrivalTime ?? '';
    _selectedAirplaneId = widget.flight?.airplaneId ?? 0;
    _loadAirplanes();
  }

  Future<void> _loadAirplanes() async {
    List<Airplane> airplanes = await _databaseHelper.getAirplanes();
    setState(() {
      _airplanes = airplanes;
      if (_airplanes.isNotEmpty && _selectedAirplaneId == 0) {
        _selectedAirplaneId = _airplanes.first.id!;
      }
    });
  }

  Future<void> _saveFlight() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Flight flight = Flight(
        id: widget.flight?.id ?? 0,
        departureCity: _departureCity,
        destinationCity: _destinationCity,
        departureTime: _departureTime,
        arrivalTime: _arrivalTime,
        airplaneId: _selectedAirplaneId,
      );
      bool isNew = widget.flight == null;
      if (isNew) {
        await _databaseHelper.insertFlight(flight.toJsonWithoutId());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).flightAdded)),
        );
      } else {
        await _databaseHelper.updateFlight(flight.toJson());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).flightUpdated)),
        );
      }
      widget.onSave();
      if (MediaQuery.of(context).size.width <= 600) {
        Navigator.pop(context, true); // Navigate back to FlightListPage on mobile
      }
    } else {
      _showAlertDialog(S.of(context).error, S.of(context).fillAllFields);
    }
  }

  Future<void> _deleteFlight() async {
    if (widget.flight != null) {
      await _databaseHelper.deleteFlight(widget.flight!.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).flightDeleted)),
      );
      widget.onSave();
      if (MediaQuery.of(context).size.width <= 600) {
        Navigator.pop(context, true); // Navigate back to FlightListPage on mobile
      }
    }
  }

  Future<void> _showAlertDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text(S.of(context).ok),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
        title: Text(widget.flight == null
            ? S.of(context).addFlight
            : S.of(context).editFlight),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _departureCity,
                decoration: InputDecoration(labelText: S.of(context).departureCity),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).fieldRequired;
                  }
                  return null;
                },
                onSaved: (value) {
                  _departureCity = value!;
                },
              ),
              TextFormField(
                initialValue: _destinationCity,
                decoration: InputDecoration(labelText: S.of(context).destinationCity),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).fieldRequired;
                  }
                  return null;
                },
                onSaved: (value) {
                  _destinationCity = value!;
                },
              ),
              TextFormField(
                initialValue: _departureTime,
                decoration: InputDecoration(labelText: S.of(context).departureTime),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).fieldRequired;
                  }
                  return null;
                },
                onSaved: (value) {
                  _departureTime = value!;
                },
              ),
              TextFormField(
                initialValue: _arrivalTime,
                decoration: InputDecoration(labelText: S.of(context).arrivalTime),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).fieldRequired;
                  }
                  return null;
                },
                onSaved: (value) {
                  _arrivalTime = value!;
                },
              ),
              DropdownButtonFormField<int>(
                value: _selectedAirplaneId != 0 ? _selectedAirplaneId : null,
                decoration: InputDecoration(labelText: S.of(context).selectAirplane),
                items: _airplanes.map((airplane) {
                  return DropdownMenuItem<int>(
                    value: airplane.id!,
                    child: Text(airplane.type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAirplaneId = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return S.of(context).fieldRequired;
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _saveFlight,
                    child: Text(S.of(context).save),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      widget.onCancel();
                      if (MediaQuery.of(context).size.width <= 600) {
                        Navigator.pop(context); // Navigate back to FlightListPage on mobile
                      }
                    },
                    child: Text(S.of(context).cancel),
                  ),
                  if (widget.flight != null) ...[
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _deleteFlight,
                      child: Text(S.of(context).delete),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
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

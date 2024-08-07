import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';
import 'models/airplane.dart';
import 'generated/l10n.dart';

class AddFlightPage extends StatefulWidget {
  @override
  _AddFlightPageState createState() => _AddFlightPageState();
}

class _AddFlightPageState extends State<AddFlightPage> {
  final _formKey = GlobalKey<FormState>();
  String _departureCity = '';
  String _destinationCity = '';
  DateTime _departureTime = DateTime.now();
  DateTime _arrivalTime = DateTime.now().add(Duration(hours: 2));
  int? _selectedAirplaneId;
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Airplane> _airplanes = [];

  @override
  void initState() {
    super.initState();
    _loadAirplanes();
  }

  Future<void> _loadAirplanes() async {
    _airplanes = await _databaseHelper.getAirplanes();
    setState(() {});
  }

  Future<void> _selectDateTime(BuildContext context, bool isDeparture) async {
    DateTime initialDate = isDeparture ? _departureTime : _arrivalTime;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != initialDate) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if (time != null) {
        setState(() {
          if (isDeparture) {
            _departureTime = DateTime(picked.year, picked.month, picked.day, time.hour, time.minute);
          } else {
            _arrivalTime = DateTime(picked.year, picked.month, picked.day, time.hour, time.minute);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).addFlight),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: S.of(context).departureCity),
                onSaved: (value) => _departureCity = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).pleaseEnterDepartureCity;
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: S.of(context).destinationCity),
                onSaved: (value) => _destinationCity = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).pleaseEnterDestinationCity;
                  }
                  return null;
                },
              ),
              ListTile(
                title: Text('${S.of(context).departureTime}: ${DateFormat.yMd().add_jm().format(_departureTime)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selectDateTime(context, true),
              ),
              ListTile(
                title: Text('${S.of(context).arrivalTime}: ${DateFormat.yMd().add_jm().format(_arrivalTime)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selectDateTime(context, false),
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: S.of(context).selectAirplaneDetails),
                items: _airplanes.map((airplane) {
                  return DropdownMenuItem<int>(
                    value: airplane.id,
                    child: Text(airplane.type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAirplaneId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return S.of(context).selectAirplaneDetails;
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save the flight to the database
                    _databaseHelper.insertFlight({
                      'departureCity': _departureCity,
                      'destinationCity': _destinationCity,
                      'departureTime': _departureTime.toIso8601String(),
                      'arrivalTime': _arrivalTime.toIso8601String(),
                      'airplaneId': _selectedAirplaneId,
                    });
                    Navigator.pop(context, true);
                  }
                },
                child: Text(S.of(context).addFlight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
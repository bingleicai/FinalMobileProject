import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models/flight.dart';
import 'models/airplane.dart';
import 'generated/l10n.dart';

class FlightDetailPage extends StatefulWidget {
  final Flight flight;

  FlightDetailPage({required this.flight});

  @override
  _FlightDetailPageState createState() => _FlightDetailPageState();
}

class _FlightDetailPageState extends State<FlightDetailPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _departureCityController;
  late TextEditingController _destinationCityController;
  late TextEditingController _departureTimeController;
  late TextEditingController _arrivalTimeController;
  int? _selectedAirplaneId;
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Airplane> _airplanes = [];

  @override
  void initState() {
    super.initState();
    _departureCityController = TextEditingController(text: widget.flight.departureCity);
    _destinationCityController = TextEditingController(text: widget.flight.destinationCity);
    _departureTimeController = TextEditingController(text: widget.flight.departureTime);
    _arrivalTimeController = TextEditingController(text: widget.flight.arrivalTime);
    _selectedAirplaneId = widget.flight.airplaneId;
    _loadAirplanes();
  }

  Future<void> _loadAirplanes() async {
    _airplanes = await _databaseHelper.getAirplanes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).flightDetails),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await _databaseHelper.deleteFlight(widget.flight.id);
              Navigator.pop(context, true); // Return to the previous screen with a success flag
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _departureCityController,
                decoration: InputDecoration(labelText: S.of(context).departureCity),
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).pleaseEnterDepartureCity;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _destinationCityController,
                decoration: InputDecoration(labelText: S.of(context).destinationCity),
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).pleaseEnterDestinationCity;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _departureTimeController,
                decoration: InputDecoration(labelText: S.of(context).departureTime),
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).pleaseEnterDepartureTime;
                  }
                  try {
                    DateTime.parse(value);
                  } catch (_) {
                    return S.of(context).invalidDateFormat;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _arrivalTimeController,
                decoration: InputDecoration(labelText: S.of(context).arrivalTime),
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).pleaseEnterArrivalTime;
                  }
                  try {
                    DateTime.parse(value);
                  } catch (_) {
                    return S.of(context).invalidDateFormat;
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: S.of(context).selectAirplaneDetails),
                value: _selectedAirplaneId,
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Flight updatedFlight = Flight(
                      id: widget.flight.id,
                      departureCity: _departureCityController.text,
                      destinationCity: _destinationCityController.text,
                      departureTime: _departureTimeController.text,
                      arrivalTime: _arrivalTimeController.text,
                      airplaneId: _selectedAirplaneId!,
                    );
                    await _databaseHelper.updateFlight(updatedFlight.toJson());
                    Navigator.pop(context, true); // Return to the previous screen with a success flag
                  }
                },
                child: Text(S.of(context).updateFlight),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _departureCityController.dispose();
    _destinationCityController.dispose();
    _departureTimeController.dispose();
    _arrivalTimeController.dispose();
    super.dispose();
  }
}
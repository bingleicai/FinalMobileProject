import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';
import 'models/flight.dart';
import 'add_flight_page.dart';
import 'flight_detail_page.dart';
import 'generated/l10n.dart';

class FlightListPage extends StatefulWidget {
  @override
  _FlightListPageState createState() => _FlightListPageState();
}

class _FlightListPageState extends State<FlightListPage> {
  List<Flight> flights = [];
  DatabaseHelper databaseHelper = DatabaseHelper();
  String? selectedFlightId;

  @override
  void initState() {
    super.initState();
    _loadFlights();
  }

  Future<void> _loadFlights() async {
    final data = await databaseHelper.getFlights();
    setState(() {
      flights = data.map((item) => Flight.fromJson(item)).toList();
      if (flights.isNotEmpty) {
        selectedFlightId = flights.first.id.toString(); // Set an initial value
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).flightList),
      ),
      body: flights.isEmpty
          ? Center(child: Text(S.of(context).noFlightsFound))
          : Column(
        children: [
          if (selectedFlightId != null)
            DropdownButton<String>(
              value: selectedFlightId,
              onChanged: (newValue) {
                setState(() {
                  selectedFlightId = newValue;
                });
              },
              items: flights.map<DropdownMenuItem<String>>((Flight flight) {
                return DropdownMenuItem<String>(
                  value: flight.id.toString(),
                  child: Text('${flight.departureCity} -> ${flight.destinationCity}'),
                );
              }).toList(),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: flights.length,
              itemBuilder: (context, index) {
                final flight = flights[index];
                return ListTile(
                  title: Text('${flight.departureCity} -> ${flight.destinationCity}'),
                  subtitle: Text(
                    '${DateFormat.yMd().add_jm().format(DateTime.parse(flight.departureTime))} - ${DateFormat.yMd().add_jm().format(DateTime.parse(flight.arrivalTime))}',
                  ),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FlightDetailPage(flight: flight)),
                    );
                    if (result == true) {
                      _loadFlights(); // Refresh the list if the flight was updated or deleted
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFlightPage()), // Navigate to AddFlightPage
          );
          if (result == true) {
            _loadFlights(); // Refresh the list if a new flight was added
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models/flight.dart';
import 'flight_form_page.dart';
import 'generated/l10n.dart';

class FlightListPage extends StatefulWidget {
  @override
  _FlightListPageState createState() => _FlightListPageState();
}

class _FlightListPageState extends State<FlightListPage> {
  List<Flight> _flights = [];
  Flight? _selectedFlight;
  bool _isAddingFlight = false;
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadFlights();
  }

  Future<void> _loadFlights() async {
    List<Map<String, dynamic>> flightMaps = await _databaseHelper.getFlights();
    setState(() {
      _flights = flightMaps.map((map) => Flight.fromJson(map)).toList();
    });
    if (_flights.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).noFlightsFound)),
      );
    }
  }

  void _navigateToAddFlight() {
    if (MediaQuery.of(context).size.width > 600) {
      setState(() {
        _isAddingFlight = true;
        _selectedFlight = null;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FlightFormPage(
            flight: null,
            onSave: _handleFormSave,
            onCancel: _handleFormCancel,
          ),
        ),
      ).then((value) {
        if (value == true) {
          _loadFlights();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).flightAdded)),
          );
        }
      });
    }
  }

  void _navigateToEditFlight(Flight flight) {
    if (MediaQuery.of(context).size.width > 600) {
      setState(() {
        _isAddingFlight = false;
        _selectedFlight = flight;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FlightFormPage(
            flight: flight,
            onSave: _handleFormSave,
            onCancel: _handleFormCancel,
          ),
        ),
      ).then((value) {
        if (value == true) {
          _loadFlights();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).flightEdited)),
          );
        }
      });
    }
  }

  void _handleFormSave() {
    setState(() {
      _isAddingFlight = false;
      _selectedFlight = null;
    });
    _loadFlights();
  }

  void _handleFormCancel() {
    setState(() {
      _isAddingFlight = false;
      _selectedFlight = null;
    });
  }

  Future<void> _handleFlightDelete(Flight flight) async {
    await _databaseHelper.deleteFlight(flight.id);
    _loadFlights();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).flightDeleted)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Tablet/Desktop Layout
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).flights),
            ),
            body: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: _flights.length,
                    itemBuilder: (context, index) {
                      final flight = _flights[index];
                      return ListTile(
                        title: Text('${flight.departureCity} to ${flight.destinationCity}'),
                        subtitle: Text('${flight.departureTime} - ${flight.arrivalTime}'),
                        onTap: () => _navigateToEditFlight(flight),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            final confirmed = await _showAlertDialog(
                              S.of(context).deleteFlight,
                              S.of(context).confirmDelete,
                            );
                            if (confirmed == true) {
                              _handleFlightDelete(flight);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
                if (_isAddingFlight || _selectedFlight != null)
                  Expanded(
                    flex: 3,
                    child: FlightFormPage(
                      flight: _selectedFlight,
                      onSave: _handleFormSave,
                      onCancel: _handleFormCancel,
                    ),
                  ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _navigateToAddFlight,
              child: Icon(Icons.add),
            ),
          );
        } else {
          // Mobile Layout
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).flights),
            ),
            body: ListView.builder(
              itemCount: _flights.length,
              itemBuilder: (context, index) {
                final flight = _flights[index];
                return ListTile(
                  title: Text('${flight.departureCity} to ${flight.destinationCity}'),
                  subtitle: Text('${flight.departureTime} - ${flight.arrivalTime}'),
                  onTap: () => _navigateToEditFlight(flight),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      final confirmed = await _showAlertDialog(
                        S.of(context).deleteFlight,
                        S.of(context).confirmDelete,
                      );
                      if (confirmed == true) {
                        _handleFlightDelete(flight);
                      }
                    },
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _navigateToAddFlight,
              child: Icon(Icons.add),
            ),
          );
        }
      },
    );
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
                Navigator.of(context).pop(false); // User pressed cancel
              },
            ),
            TextButton(
              child: Text(S.of(context).confirm),
              onPressed: () {
                Navigator.of(context).pop(true); // User pressed confirm
              },
            ),
          ],
        );
      },
    );
  }
}

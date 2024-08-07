import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models/reservation.dart';
import 'models/customer.dart';
import 'models/flight.dart';
import 'generated/l10n.dart';

class ReservationFormPage extends StatefulWidget {
  final Reservation? reservation;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  ReservationFormPage({this.reservation, required this.onSave, required this.onCancel});

  @override
  _ReservationFormPageState createState() => _ReservationFormPageState();
}

class _ReservationFormPageState extends State<ReservationFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _reservationName;
  late int _selectedCustomerId;
  late int _selectedFlightId;
  List<Customer> _customers = [];
  List<Flight> _flights = [];
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _reservationName = widget.reservation?.reservationName ?? '';
    _selectedCustomerId = widget.reservation?.customerId ?? 0;
    _selectedFlightId = widget.reservation?.flightId ?? 0;
    _loadCustomers();
    _loadFlights();
  }

  Future<void> _loadCustomers() async {
    List<Customer> customers = await _databaseHelper.getCustomers();
    setState(() {
      _customers = customers;
      if (_customers.isNotEmpty && _selectedCustomerId == 0) {
        _selectedCustomerId = _customers.first.id!;
      }
    });
  }

  Future<void> _loadFlights() async {
    List<Flight> flights = await _databaseHelper.getFlights().then((maps) =>
        maps.map((flightMap) => Flight.fromJson(flightMap)).toList());
    setState(() {
      _flights = flights;
      if (_flights.isNotEmpty && _selectedFlightId == 0) {
        _selectedFlightId = _flights.first.id;
      }
    });
  }

  Future<void> _saveReservation() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Reservation reservation = Reservation(
        id: widget.reservation?.id ?? 0,
        reservationName: _reservationName,
        customerId: _selectedCustomerId,
        flightId: _selectedFlightId,
      );
      bool isNew = widget.reservation == null;
      if (isNew) {
        await _databaseHelper.insertReservation(reservation.toJsonWithoutId());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).reservationAdded)),
        );
      } else {
        await _databaseHelper.updateReservation(reservation.toJson());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).reservationUpdated)),
        );
      }
      widget.onSave();
      if (MediaQuery.of(context).size.width <= 600) {
        Navigator.pop(context, true); // Navigate back to ReservationListPage on mobile
      }
    } else {
      _showAlertDialog(S.of(context).error, S.of(context).fillAllFields);
    }
  }

  Future<void> _deleteReservation() async {
    if (widget.reservation != null) {
      await _databaseHelper.deleteReservation(widget.reservation!.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).reservationDeleted)),
      );
      widget.onSave();
      if (MediaQuery.of(context).size.width <= 600) {
        Navigator.pop(context, true); // Navigate back to ReservationListPage on mobile
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
        title: Text(widget.reservation == null
            ? S.of(context).addReservation
            : S.of(context).editReservation),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _reservationName,
                decoration: InputDecoration(labelText: S.of(context).reservationName),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).fieldRequired;
                  }
                  return null;
                },
                onSaved: (value) {
                  _reservationName = value!;
                },
              ),
              DropdownButtonFormField<int>(
                value: _selectedCustomerId,
                decoration: InputDecoration(labelText: S.of(context).selectCustomer),
                items: _customers.map((customer) {
                  return DropdownMenuItem<int>(
                    value: customer.id!,
                    child: Text('${customer.firstName} ${customer.lastName}'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCustomerId = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return S.of(context).fieldRequired;
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<int>(
                value: _selectedFlightId,
                decoration: InputDecoration(labelText: S.of(context).selectFlight),
                items: _flights.map((flight) {
                  return DropdownMenuItem<int>(
                    value: flight.id,
                    child: Text('${flight.departureCity} to ${flight.destinationCity}'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFlightId = value!;
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
                    onPressed: _saveReservation,
                    child: Text(S.of(context).save),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      widget.onCancel();
                      if (MediaQuery.of(context).size.width <= 600) {
                        Navigator.pop(context); // Navigate back to ReservationListPage on mobile
                      }
                    },
                    child: Text(S.of(context).cancel),
                  ),
                  if (widget.reservation != null) ...[
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _deleteReservation,
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

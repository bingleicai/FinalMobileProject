import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models/reservation.dart';
import 'reservation_form_page.dart';
import 'generated/l10n.dart';

class ReservationListPage extends StatefulWidget {
  @override
  _ReservationListPageState createState() => _ReservationListPageState();
}

class _ReservationListPageState extends State<ReservationListPage> {
  List<Reservation> _reservations = [];
  Reservation? _selectedReservation;
  bool _isAddingReservation = false;
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadReservations();
  }

  Future<void> _loadReservations() async {
    List<Reservation> reservations = await _databaseHelper.getReservations().then((maps) =>
        maps.map((reservationMap) => Reservation.fromJson(reservationMap)).toList());
    setState(() {
      _reservations = reservations;
    });
    if (_reservations.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).noReservationsFound)),
      );
    }
  }

  void _navigateToAddReservation() {
    if (MediaQuery.of(context).size.width > 600) {
      setState(() {
        _isAddingReservation = true;
        _selectedReservation = null;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReservationFormPage(
            reservation: null,
            onSave: _handleFormSave,
            onCancel: _handleFormCancel,
          ),
        ),
      ).then((value) {
        if (value == true) {
          _loadReservations();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).reservationAdded)),
          );
        }
      });
    }
  }

  void _navigateToEditReservation(Reservation reservation) {
    if (MediaQuery.of(context).size.width > 600) {
      setState(() {
        _isAddingReservation = false;
        _selectedReservation = reservation;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReservationFormPage(
            reservation: reservation,
            onSave: _handleFormSave,
            onCancel: _handleFormCancel,
          ),
        ),
      ).then((value) {
        if (value == true) {
          _loadReservations();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).reservationUpdated)),
          );
        }
      });
    }
  }

  void _handleFormSave() {
    _loadReservations();
    setState(() {
      _isAddingReservation = false;
      _selectedReservation = null;
    });
  }

  void _handleFormCancel() {
    setState(() {
      _isAddingReservation = false;
      _selectedReservation = null;
    });
  }

  Future<void> _handleReservationDelete(Reservation reservation) async {
    await _databaseHelper.deleteReservation(reservation.id);
    _loadReservations();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).reservationDeleted)),
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Tablet/Desktop Layout
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).reservations),
            ),
            body: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: _reservations.length,
                    itemBuilder: (context, index) {
                      final reservation = _reservations[index];
                      return ListTile(
                        title: Text(reservation.reservationName),
                        onTap: () => _navigateToEditReservation(reservation),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            final confirmed = await _showAlertDialog(
                              S.of(context).deleteReservation,
                              S.of(context).confirmDelete,
                            );
                            if (confirmed == true) {
                              _handleReservationDelete(reservation);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
                if (_isAddingReservation || _selectedReservation != null)
                  Expanded(
                    flex: 3,
                    child: ReservationFormPage(
                      reservation: _selectedReservation,
                      onSave: _handleFormSave,
                      onCancel: _handleFormCancel,
                    ),
                  )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _navigateToAddReservation,
              child: Icon(Icons.add),
            ),
          );
        } else {
          // Mobile Layout
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).reservations),
            ),
            body: ListView.builder(
              itemCount: _reservations.length,
              itemBuilder: (context, index) {
                final reservation = _reservations[index];
                return ListTile(
                  title: Text(reservation.reservationName),
                  onTap: () => _navigateToEditReservation(reservation),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      final confirmed = await _showAlertDialog(
                        S.of(context).deleteReservation,
                        S.of(context).confirmDelete,
                      );
                      if (confirmed == true) {
                        _handleReservationDelete(reservation);
                      }
                    },
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _navigateToAddReservation,
              child: Icon(Icons.add),
            ),
          );
        }
      },
    );
  }
}

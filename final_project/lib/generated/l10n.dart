// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Airplane App`
  String get appTitle {
    return Intl.message(
      'Airplane App',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Airplane List`
  String get airplaneList {
    return Intl.message(
      'Airplane List',
      name: 'airplaneList',
      desc: '',
      args: [],
    );
  }

  /// `Add Airplane`
  String get addAirplane {
    return Intl.message(
      'Add Airplane',
      name: 'addAirplane',
      desc: '',
      args: [],
    );
  }

  /// `Airplane Type`
  String get airplaneType {
    return Intl.message(
      'Airplane Type',
      name: 'airplaneType',
      desc: '',
      args: [],
    );
  }

  /// `Number of Passengers`
  String get numberOfPassengers {
    return Intl.message(
      'Number of Passengers',
      name: 'numberOfPassengers',
      desc: '',
      args: [],
    );
  }

  /// `passengers`
  String get passengers {
    return Intl.message(
      'passengers',
      name: 'passengers',
      desc: '',
      args: [],
    );
  }

  /// `Max Speed`
  String get maxSpeed {
    return Intl.message(
      'Max Speed',
      name: 'maxSpeed',
      desc: '',
      args: [],
    );
  }

  /// `Range`
  String get range {
    return Intl.message(
      'Range',
      name: 'range',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Select an airplane to view details`
  String get selectAirplaneDetails {
    return Intl.message(
      'Select an airplane to view details',
      name: 'selectAirplaneDetails',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all fields`
  String get fillAllFields {
    return Intl.message(
      'Please fill all fields',
      name: 'fillAllFields',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `No airplanes found`
  String get noAirplanesFound {
    return Intl.message(
      'No airplanes found',
      name: 'noAirplanesFound',
      desc: '',
      args: [],
    );
  }

  /// `Update Flight`
  String get updateFlight {
    return Intl.message(
      'Update Flight',
      name: 'updateFlight',
      desc: '',
      args: [],
    );
  }

  /// `Flight List`
  String get flightList {
    return Intl.message(
      'Flight List',
      name: 'flightList',
      desc: '',
      args: [],
    );
  }

  /// `Flight Details`
  String get flightDetails {
    return Intl.message(
      'Flight Details',
      name: 'flightDetails',
      desc: '',
      args: [],
    );
  }

  /// `Departure City`
  String get departureCity {
    return Intl.message(
      'Departure City',
      name: 'departureCity',
      desc: '',
      args: [],
    );
  }

  /// `Destination City`
  String get destinationCity {
    return Intl.message(
      'Destination City',
      name: 'destinationCity',
      desc: '',
      args: [],
    );
  }

  /// `Departure Time`
  String get departureTime {
    return Intl.message(
      'Departure Time',
      name: 'departureTime',
      desc: '',
      args: [],
    );
  }

  /// `Arrival Time`
  String get arrivalTime {
    return Intl.message(
      'Arrival Time',
      name: 'arrivalTime',
      desc: '',
      args: [],
    );
  }

  /// `Add Flight`
  String get addFlight {
    return Intl.message(
      'Add Flight',
      name: 'addFlight',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the departure city`
  String get pleaseEnterDepartureCity {
    return Intl.message(
      'Please enter the departure city',
      name: 'pleaseEnterDepartureCity',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the destination city`
  String get pleaseEnterDestinationCity {
    return Intl.message(
      'Please enter the destination city',
      name: 'pleaseEnterDestinationCity',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the departure time`
  String get pleaseEnterDepartureTime {
    return Intl.message(
      'Please enter the departure time',
      name: 'pleaseEnterDepartureTime',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the arrival time`
  String get pleaseEnterArrivalTime {
    return Intl.message(
      'Please enter the arrival time',
      name: 'pleaseEnterArrivalTime',
      desc: '',
      args: [],
    );
  }

  /// `Invalid date format`
  String get invalidDateFormat {
    return Intl.message(
      'Invalid date format',
      name: 'invalidDateFormat',
      desc: '',
      args: [],
    );
  }

  /// `Go to Flight List`
  String get goToFlightList {
    return Intl.message(
      'Go to Flight List',
      name: 'goToFlightList',
      desc: '',
      args: [],
    );
  }

  /// `No flights found`
  String get noFlightsFound {
    return Intl.message(
      'No flights found',
      name: 'noFlightsFound',
      desc: '',
      args: [],
    );
  }

  /// `Actions`
  String get actions {
    return Intl.message(
      'Actions',
      name: 'actions',
      desc: '',
      args: [],
    );
  }

  /// `Choose an action`
  String get chooseAction {
    return Intl.message(
      'Choose an action',
      name: 'chooseAction',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Delete`
  String get confirmDelete {
    return Intl.message(
      'Confirm Delete',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this record?`
  String get areYouSureDelete {
    return Intl.message(
      'Are you sure you want to delete this record?',
      name: 'areYouSureDelete',
      desc: '',
      args: [],
    );
  }

  /// `Copy Fields`
  String get copyFields {
    return Intl.message(
      'Copy Fields',
      name: 'copyFields',
      desc: '',
      args: [],
    );
  }

  /// `Add New Customer`
  String get addNewCustomer {
    return Intl.message(
      'Add New Customer',
      name: 'addNewCustomer',
      desc: '',
      args: [],
    );
  }

  /// `New Fields`
  String get newFields {
    return Intl.message(
      'New Fields',
      name: 'newFields',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Copy Fields or Add New`
  String get copyFieldsOrNew {
    return Intl.message(
      'Copy Fields or Add New',
      name: 'copyFieldsOrNew',
      desc: '',
      args: [],
    );
  }

  /// `Customer List`
  String get customerList {
    return Intl.message(
      'Customer List',
      name: 'customerList',
      desc: '',
      args: [],
    );
  }

  /// `No customers found`
  String get noCustomersFound {
    return Intl.message(
      'No customers found',
      name: 'noCustomersFound',
      desc: '',
      args: [],
    );
  }

  /// `Please select a customer from the list.`
  String get selectCustomer {
    return Intl.message(
      'Please select a customer from the list.',
      name: 'selectCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Airplane saved successfully.`
  String get airplaneSaved {
    return Intl.message(
      'Airplane saved successfully.',
      name: 'airplaneSaved',
      desc: '',
      args: [],
    );
  }

  /// `Airplane deleted successfully.`
  String get airplaneDeleted {
    return Intl.message(
      'Airplane deleted successfully.',
      name: 'airplaneDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Edit Airplane`
  String get editAirplane {
    return Intl.message(
      'Edit Airplane',
      name: 'editAirplane',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `This field is required.`
  String get requiredField {
    return Intl.message(
      'This field is required.',
      name: 'requiredField',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Delete Airplane`
  String get deleteAirplane {
    return Intl.message(
      'Delete Airplane',
      name: 'deleteAirplane',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Airplanes loaded successfully.`
  String get airplanesLoaded {
    return Intl.message(
      'Airplanes loaded successfully.',
      name: 'airplanesLoaded',
      desc: '',
      args: [],
    );
  }

  /// `Operation was canceled.`
  String get operationCanceled {
    return Intl.message(
      'Operation was canceled.',
      name: 'operationCanceled',
      desc: '',
      args: [],
    );
  }

  /// `Airplanes`
  String get airplanes {
    return Intl.message(
      'Airplanes',
      name: 'airplanes',
      desc: '',
      args: [],
    );
  }

  /// `Airplane added successfully`
  String get airplaneAdded {
    return Intl.message(
      'Airplane added successfully',
      name: 'airplaneAdded',
      desc: '',
      args: [],
    );
  }

  /// `Airplane updated successfully.`
  String get airplaneUpdated {
    return Intl.message(
      'Airplane updated successfully.',
      name: 'airplaneUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Airplane edited successfully.`
  String get airplaneEdited {
    return Intl.message(
      'Airplane edited successfully.',
      name: 'airplaneEdited',
      desc: '',
      args: [],
    );
  }

  /// `Field Required`
  String get fieldRequired {
    return Intl.message(
      'Field Required',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Customer added successfully.`
  String get customerAdded {
    return Intl.message(
      'Customer added successfully.',
      name: 'customerAdded',
      desc: '',
      args: [],
    );
  }

  /// `Customer updated successfully.`
  String get customerUpdated {
    return Intl.message(
      'Customer updated successfully.',
      name: 'customerUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Customer deleted successfully.`
  String get customerDeleted {
    return Intl.message(
      'Customer deleted successfully.',
      name: 'customerDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Add Customer`
  String get addCustomer {
    return Intl.message(
      'Add Customer',
      name: 'addCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Edit Customer`
  String get editCustomer {
    return Intl.message(
      'Edit Customer',
      name: 'editCustomer',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get birthday {
    return Intl.message(
      'Birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `Customers`
  String get customers {
    return Intl.message(
      'Customers',
      name: 'customers',
      desc: '',
      args: [],
    );
  }

  /// `Customer edited successfully.`
  String get customerEdited {
    return Intl.message(
      'Customer edited successfully.',
      name: 'customerEdited',
      desc: '',
      args: [],
    );
  }

  /// `Delete Customer`
  String get deleteCustomer {
    return Intl.message(
      'Delete Customer',
      name: 'deleteCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Flight added successfully.`
  String get flightAdded {
    return Intl.message(
      'Flight added successfully.',
      name: 'flightAdded',
      desc: '',
      args: [],
    );
  }

  /// `Flight edited successfully.`
  String get flightEdited {
    return Intl.message(
      'Flight edited successfully.',
      name: 'flightEdited',
      desc: '',
      args: [],
    );
  }

  /// `Flight deleted successfully.`
  String get flightDeleted {
    return Intl.message(
      'Flight deleted successfully.',
      name: 'flightDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Flights`
  String get flights {
    return Intl.message(
      'Flights',
      name: 'flights',
      desc: '',
      args: [],
    );
  }

  /// `Delete Flight`
  String get deleteFlight {
    return Intl.message(
      'Delete Flight',
      name: 'deleteFlight',
      desc: '',
      args: [],
    );
  }

  /// `Flight updated successfully.`
  String get flightUpdated {
    return Intl.message(
      'Flight updated successfully.',
      name: 'flightUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Edit Flight`
  String get editFlight {
    return Intl.message(
      'Edit Flight',
      name: 'editFlight',
      desc: '',
      args: [],
    );
  }

  /// `Select Airplane`
  String get selectAirplane {
    return Intl.message(
      'Select Airplane',
      name: 'selectAirplane',
      desc: '',
      args: [],
    );
  }

  /// `No Reservation Found.`
  String get noReservationsFound {
    return Intl.message(
      'No Reservation Found.',
      name: 'noReservationsFound',
      desc: '',
      args: [],
    );
  }

  /// `Reservation added successfully.`
  String get reservationAdded {
    return Intl.message(
      'Reservation added successfully.',
      name: 'reservationAdded',
      desc: '',
      args: [],
    );
  }

  /// `Reservation updated successfully.`
  String get reservationUpdated {
    return Intl.message(
      'Reservation updated successfully.',
      name: 'reservationUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Reservation deleted successfully.`
  String get reservationDeleted {
    return Intl.message(
      'Reservation deleted successfully.',
      name: 'reservationDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Reservation`
  String get reservations {
    return Intl.message(
      'Reservation',
      name: 'reservations',
      desc: '',
      args: [],
    );
  }

  /// `Delete Reservation`
  String get deleteReservation {
    return Intl.message(
      'Delete Reservation',
      name: 'deleteReservation',
      desc: '',
      args: [],
    );
  }

  /// `Add Reservation`
  String get addReservation {
    return Intl.message(
      'Add Reservation',
      name: 'addReservation',
      desc: '',
      args: [],
    );
  }

  /// `Edit Reservation`
  String get editReservation {
    return Intl.message(
      'Edit Reservation',
      name: 'editReservation',
      desc: '',
      args: [],
    );
  }

  /// `Reservation Name`
  String get reservationName {
    return Intl.message(
      'Reservation Name',
      name: 'reservationName',
      desc: '',
      args: [],
    );
  }

  /// `Select Flight`
  String get selectFlight {
    return Intl.message(
      'Select Flight',
      name: 'selectFlight',
      desc: '',
      args: [],
    );
  }

  /// `Reservation List`
  String get reservationList {
    return Intl.message(
      'Reservation List',
      name: 'reservationList',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

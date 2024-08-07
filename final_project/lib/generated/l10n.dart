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

  /// `{count} Passengers`
  String passengers(Object count) {
    return Intl.message(
      '$count Passengers',
      name: 'passengers',
      desc: '',
      args: [count],
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

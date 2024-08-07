// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) => "${count} Passengers";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addAirplane": MessageLookupByLibrary.simpleMessage("Add Airplane"),
        "addFlight": MessageLookupByLibrary.simpleMessage("Add Flight"),
        "airplaneList": MessageLookupByLibrary.simpleMessage("Airplane List"),
        "airplaneType": MessageLookupByLibrary.simpleMessage("Airplane Type"),
        "appTitle": MessageLookupByLibrary.simpleMessage("Airplane App"),
        "arrivalTime": MessageLookupByLibrary.simpleMessage("Arrival Time"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "departureCity": MessageLookupByLibrary.simpleMessage("Departure City"),
        "departureTime": MessageLookupByLibrary.simpleMessage("Departure Time"),
        "destinationCity":
            MessageLookupByLibrary.simpleMessage("Destination City"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "fillAllFields":
            MessageLookupByLibrary.simpleMessage("Please fill all fields"),
        "flightDetails": MessageLookupByLibrary.simpleMessage("Flight Details"),
        "flightList": MessageLookupByLibrary.simpleMessage("Flight List"),
        "goToFlightList":
            MessageLookupByLibrary.simpleMessage("Go to Flight List"),
        "invalidDateFormat":
            MessageLookupByLibrary.simpleMessage("Invalid date format"),
        "maxSpeed": MessageLookupByLibrary.simpleMessage("Max Speed"),
        "noAirplanesFound":
            MessageLookupByLibrary.simpleMessage("No airplanes found"),
        "noFlightsFound":
            MessageLookupByLibrary.simpleMessage("No flights found"),
        "numberOfPassengers":
            MessageLookupByLibrary.simpleMessage("Number of Passengers"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "passengers": m0,
        "pleaseEnterArrivalTime": MessageLookupByLibrary.simpleMessage(
            "Please enter the arrival time"),
        "pleaseEnterDepartureCity": MessageLookupByLibrary.simpleMessage(
            "Please enter the departure city"),
        "pleaseEnterDepartureTime": MessageLookupByLibrary.simpleMessage(
            "Please enter the departure time"),
        "pleaseEnterDestinationCity": MessageLookupByLibrary.simpleMessage(
            "Please enter the destination city"),
        "range": MessageLookupByLibrary.simpleMessage("Range"),
        "selectAirplaneDetails": MessageLookupByLibrary.simpleMessage(
            "Select an airplane to view details"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "updateFlight": MessageLookupByLibrary.simpleMessage("Update Flight")
      };
}

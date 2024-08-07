// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static String m0(count) => "${count} 乘客";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addAirplane": MessageLookupByLibrary.simpleMessage("添加飞机"),
        "addFlight": MessageLookupByLibrary.simpleMessage("添加航班"),
        "airplaneList": MessageLookupByLibrary.simpleMessage("飞机列表"),
        "airplaneType": MessageLookupByLibrary.simpleMessage("飞机类型"),
        "appTitle": MessageLookupByLibrary.simpleMessage("飞机应用"),
        "arrivalTime": MessageLookupByLibrary.simpleMessage("到达时间"),
        "delete": MessageLookupByLibrary.simpleMessage("删除"),
        "departureCity": MessageLookupByLibrary.simpleMessage("出发城市"),
        "departureTime": MessageLookupByLibrary.simpleMessage("出发时间"),
        "destinationCity": MessageLookupByLibrary.simpleMessage("目的地城市"),
        "error": MessageLookupByLibrary.simpleMessage("错误"),
        "fillAllFields": MessageLookupByLibrary.simpleMessage("请填写所有字段"),
        "flightDetails": MessageLookupByLibrary.simpleMessage("航班详情"),
        "flightList": MessageLookupByLibrary.simpleMessage("航班列表"),
        "goToFlightList": MessageLookupByLibrary.simpleMessage("转到航班列表"),
        "invalidDateFormat": MessageLookupByLibrary.simpleMessage("无效的日期格式"),
        "maxSpeed": MessageLookupByLibrary.simpleMessage("最大速度"),
        "noAirplanesFound": MessageLookupByLibrary.simpleMessage("未找到飞机"),
        "noFlightsFound": MessageLookupByLibrary.simpleMessage("未找到航班"),
        "numberOfPassengers": MessageLookupByLibrary.simpleMessage("乘客人数"),
        "ok": MessageLookupByLibrary.simpleMessage("确定"),
        "passengers": m0,
        "pleaseEnterArrivalTime":
            MessageLookupByLibrary.simpleMessage("请输入到达时间"),
        "pleaseEnterDepartureCity":
            MessageLookupByLibrary.simpleMessage("请输入出发城市"),
        "pleaseEnterDepartureTime":
            MessageLookupByLibrary.simpleMessage("请输入出发时间"),
        "pleaseEnterDestinationCity":
            MessageLookupByLibrary.simpleMessage("请输入目的地城市"),
        "range": MessageLookupByLibrary.simpleMessage("范围"),
        "selectAirplaneDetails":
            MessageLookupByLibrary.simpleMessage("选择飞机查看详情"),
        "update": MessageLookupByLibrary.simpleMessage("更新"),
        "updateFlight": MessageLookupByLibrary.simpleMessage("更新航班")
      };
}

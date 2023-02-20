import 'dart:io';
import 'package:flutter/foundation.dart';

class VendorModelMessageData {
  String eventName;
  Uint8List message;

  VendorModelMessageData(this.eventName, this.message);

  VendorModelMessageData.fromJson(Map<String, dynamic> json)
      : eventName = json['eventName'],
        message = Platform.isIOS ? Uint8List.fromList(json['message'].cast<int>().toList()) : json['message'];

  Map<String, dynamic> toJson() => {
        'eventName': eventName,
        'data': message,
      };

  VendorModelMessageData copyWith({
    String? eventName,
    Uint8List? message,
  }) {
    return VendorModelMessageData(
      eventName ?? this.eventName,
      message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'VendorModelMessageData{eventName: $eventName, data: $message}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VendorModelMessageData &&
          runtimeType == other.runtimeType &&
          eventName == other.eventName &&
          message == other.message;

  @override
  int get hashCode => eventName.hashCode ^ message.hashCode;
}

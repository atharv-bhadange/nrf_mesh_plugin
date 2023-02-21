import 'dart:io';
import 'dart:developer';
import 'package:flutter/foundation.dart';

/// `VendorModelMessageStatus` is a data class that contains the status of a message sent to a vendor model.
/// It is used in the `VendorModelMessageStatusEvent` event.
/// The `VendorModelMessageStatus` is received from the `VendorModelMessageStatusEvent` event.
class VendorModelMessageData {
  /// EventName is required to identify the event channel callback.
  String eventName;

  /// Message is the protobuf message that is received to the device.
  /// The message is a `Uint8List`
  Uint8List message;

  /// Source is the source of the message.
  /// Getting from the native side to filter the source message
  int? source;

  /// Constructor requires the `eventName` and the `message`.
  VendorModelMessageData(this.eventName, this.message, this.source);

  /// This is required to convert the data to a map, from the event channel.
  /// Data comes as string from the iOS side, so we need to convert it to Uint8List.
  VendorModelMessageData.fromJson(Map<String, dynamic> json)
      : eventName = json['eventName'],
        message = Platform.isIOS ? Uint8List.fromList(json['message'].cast<int>().toList()) : json['message'],
        source = json['source'];

  Map<String, dynamic> toJson() => {
        'eventName': eventName,
        'message': message,
        'source': source,
      };

  VendorModelMessageData copyWith({
    String? eventName,
    Uint8List? message,
    int? source,
  }) {
    return VendorModelMessageData(
      eventName ?? this.eventName,
      message ?? this.message,
      source ?? this.source,
    );
  }

  @override
  String toString() {
    return 'VendorModelMessageData{eventName: $eventName, data: $message, source: $source}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VendorModelMessageData &&
          runtimeType == other.runtimeType &&
          eventName == other.eventName &&
          message == other.message &&
          source == other.source;

  @override
  int get hashCode => eventName.hashCode ^ message.hashCode ^ source.hashCode;
}

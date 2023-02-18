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

  /// Constructor requires the `eventName` and the `message`.
  VendorModelMessageData(this.eventName, this.message);

  // This is required to convert the data to a map, from the event channel.
  VendorModelMessageData.fromJson(Map<String, dynamic> json)
      : eventName = json['eventName'],
        message = json['message'];

  Map<String, dynamic> toJson() => {
        'eventName': eventName,
        'message': message,
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

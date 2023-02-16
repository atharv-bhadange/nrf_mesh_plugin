import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';

import '../../../protobufs/rgb_on_off/rgb_on_off.pb.dart';

Uint8List encodeMessage(message) {
  return message.writeToBuffer();
}

class RGBProtobuf extends StatefulWidget {
  final MeshManagerApi meshManagerApi;
  final int selectedElementAddress;
  final int opCode;

  const RGBProtobuf(
      {Key? key, required this.meshManagerApi, required this.selectedElementAddress, required this.opCode})
      : super(key: key);
  @override
  State<RGBProtobuf> createState() => _RGBProtobufState();
}

class _RGBProtobufState extends State<RGBProtobuf> {
  Color currentColor = Colors.blue;

  void changeColor(Color color) {
    setState(() {
      currentColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('ON-OFF'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var status = Status.ON;
                    final message = RGB()..status = status;
                    final buffer = message.writeToBuffer();

                    final scaffoldMessenger = ScaffoldMessenger.of(context);
                  try {
                    final vendorModelMessage = await widget.meshManagerApi
                        .golainVendorModelSend(widget.selectedElementAddress, widget.opCode, buffer)
                        .timeout(const Duration(seconds: 10));
                    // Creating a string message from the vendor model message for now
                    String receivedMessage = String.fromCharCodes(vendorModelMessage.message);
                    log("Decoded Message $receivedMessage");
                    scaffoldMessenger
                        .showSnackBar(SnackBar(content: Text('Vendor Model Received Data: $receivedMessage')));
                  } on TimeoutException catch (_) {
                    scaffoldMessenger.showSnackBar(const SnackBar(content: Text('Board didn\'t respond')));
                  } on PlatformException catch (e) {
                    scaffoldMessenger.showSnackBar(SnackBar(content: Text('${e.message}')));
                  } catch (e) {
                    scaffoldMessenger.showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                  },
                  child: const Text('ON'),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var status = Status.OFF;
                    final message = RGB()..status = status;
                    final buffer = message.writeToBuffer();

                    final scaffoldMessenger = ScaffoldMessenger.of(context);
                  try {
                    final vendorModelMessage = await widget.meshManagerApi
                        .golainVendorModelSend(widget.selectedElementAddress, widget.opCode, buffer)
                        .timeout(const Duration(seconds: 10));
                    // Creating a string message from the vendor model message for now
                    String receivedMessage = String.fromCharCodes(vendorModelMessage.message);
                    log("Decoded Message $receivedMessage");
                    scaffoldMessenger
                        .showSnackBar(SnackBar(content: Text('Vendor Model Received Data: $receivedMessage')));
                  } on TimeoutException catch (_) {
                    scaffoldMessenger.showSnackBar(const SnackBar(content: Text('Board didn\'t respond')));
                  } on PlatformException catch (e) {
                    scaffoldMessenger.showSnackBar(SnackBar(content: Text('${e.message}')));
                  } catch (e) {
                    scaffoldMessenger.showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                  },
                  child: const Text('OFF'),
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
              thickness: 2,
            ),
            Slider(
                activeColor: Colors.red,
                value: currentColor.red.toDouble(),
                min: 0,
                max: 255,
                onChanged: (value) {
                  changeColor(Color.fromARGB(currentColor.alpha, value.toInt(), currentColor.green, currentColor.blue));
                }),
            Slider(
                activeColor: Colors.green,
                value: currentColor.green.toDouble(),
                min: 0,
                max: 255,
                onChanged: (value) {
                  changeColor(Color.fromARGB(currentColor.alpha, currentColor.red, value.toInt(), currentColor.blue));
                }),
            Slider(
                activeColor: Colors.blue,
                value: currentColor.blue.toDouble(),
                min: 0,
                max: 255,
                onChanged: (value) {
                  changeColor(Color.fromARGB(currentColor.alpha, currentColor.red, currentColor.green, value.toInt()));
                }),
            ColorPicker(
              pickerColor: currentColor,
              onColorChanged: changeColor,
              pickerAreaHeightPercent: 0.8,
            ),
            ElevatedButton(
                onPressed: () async {
                  final message = RGB()
                    ..red = currentColor.red
                    ..green = currentColor.green
                    ..blue = currentColor.blue;

                  final buffer = message.writeToBuffer();
                  log(buffer.toString());

                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  try {
                    final vendorModelMessage = await widget.meshManagerApi
                        .golainVendorModelSend(widget.selectedElementAddress, widget.opCode, buffer)
                        .timeout(const Duration(seconds: 10));
                    // Creating a string message from the vendor model message for now
                    String receivedMessage = String.fromCharCodes(vendorModelMessage.message);
                    log("Decoded Message $receivedMessage");
                    scaffoldMessenger
                        .showSnackBar(SnackBar(content: Text('Vendor Model Received Data: $receivedMessage')));
                  } on TimeoutException catch (_) {
                    scaffoldMessenger.showSnackBar(const SnackBar(content: Text('Board didn\'t respond')));
                  } on PlatformException catch (e) {
                    scaffoldMessenger.showSnackBar(SnackBar(content: Text('${e.message}')));
                  } catch (e) {
                    scaffoldMessenger.showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: const Text('Get RGB')),
          ],
        ),
      ),
    );
  }
}

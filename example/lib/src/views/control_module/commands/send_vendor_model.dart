import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';

import '../../vendor_models_ui/rgb_on_off/rgb_on_off_ui.dart';

class SendGolainVendorModel extends StatefulWidget {
  final MeshManagerApi meshManagerApi;

  const SendGolainVendorModel({Key? key, required this.meshManagerApi}) : super(key: key);

  @override
  State<SendGolainVendorModel> createState() => _SendGolainVendorModelState();
}

class _SendGolainVendorModelState extends State<SendGolainVendorModel> {
  int? selectedElementAddress;
  int? opCode;
  Uint8List? byteData;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: const ValueKey('module-send-golain-vendor-model'),
      title: const Text('Send a Vendor Model'),
      children: <Widget>[
        TextField(
          key: const ValueKey('module-send-generic-level-address'),
          decoration: const InputDecoration(hintText: 'Element Address'),
          onChanged: (text) {
            selectedElementAddress = int.parse(text);
            setState(() {});
          },
        ),
        TextField(
          decoration: const InputDecoration(hintText: 'opCode'),
          onChanged: (text) {
            opCode = int.parse(text, radix: 16);
            setState(() {});
          },
        ),
        // TextField(
        //   decoration: const InputDecoration(hintText: 'byteData'),
        //   onChanged: (text) {
        //     byteData = Uint8List.fromList(text.codeUnits);
        //     setState(() {});
        //   },
        // ),
        TextButton(
          onPressed: selectedElementAddress != null && opCode != null
              ? () async {
                  // final scaffoldMessenger = ScaffoldMessenger.of(context);
                  // debugPrint('Vendor Model to $selectedElementAddress');
                  // try {
                  //   final vendorModelMessage = await widget.meshManagerApi
                  //       .golainVendorModelSend(selectedElementAddress!, opCode!, byteData!)
                  //       .timeout(const Duration(seconds: 10));
                  //   // Creating a string message from the vendor model message for now
                  //   String receivedMessage = String.fromCharCodes(vendorModelMessage.message);
                  //   log("Decoded Message $receivedMessage");
                  //   scaffoldMessenger
                  //       .showSnackBar(SnackBar(content: Text('Vendor Model Received Data: $receivedMessage')));
                  // } on TimeoutException catch (_) {
                  //   scaffoldMessenger.showSnackBar(const SnackBar(content: Text('Board didn\'t respond')));
                  // } on PlatformException catch (e) {
                  //   scaffoldMessenger.showSnackBar(SnackBar(content: Text('${e.message}')));
                  // } catch (e) {
                  //   scaffoldMessenger.showSnackBar(SnackBar(content: Text(e.toString())));
                  // }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RGBProtobuf(
                        meshManagerApi: widget.meshManagerApi,
                        opCode: opCode!,
                        selectedElementAddress: selectedElementAddress!,
                      ),
                    ),
                  );
                }
              : null,
          child: const Text('Send Vendor Model'),
        )
      ],
    );
  }
}

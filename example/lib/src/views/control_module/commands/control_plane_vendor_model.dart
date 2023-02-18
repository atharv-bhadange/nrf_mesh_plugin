import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:nordic_nrf_mesh_example/env/config.dart';
import 'package:nordic_nrf_mesh_example/src/protobufs/rgb_on_off/rgb_on_off.pbserver.dart';

import '../../vendor_models_ui/rgb_on_off/rgb_on_off_ui.dart';

class ControlPlaneVendorModel extends StatefulWidget {
  final MeshManagerApi meshManagerApi;
  final int modelId;

  const ControlPlaneVendorModel({Key? key, required this.meshManagerApi, required this.modelId}) : super(key: key);

  @override
  State<ControlPlaneVendorModel> createState() => _ControlPlaneVendorModelState();
}

class _ControlPlaneVendorModelState extends State<ControlPlaneVendorModel> {
  int? selectedElementAddress;
  int? opCode;
  Uint8List? byteData;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: const ValueKey('module-send-golain-vendor-model'),
      title: Text('Control Plane Vendor Model: ${widget.modelId.toRadixString(16)}'),
      children: <Widget>[
        TextField(
          key: const ValueKey('module-send-generic-level-address'),
          decoration: const InputDecoration(hintText: 'Element Address'),
          onChanged: (text) {
            selectedElementAddress = int.parse(text);
            setState(() {});
          },
        ),
        TextButton(
          onPressed: selectedElementAddress != null
              ? () async {
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  try {
                    // OPCODE is defined in the config file
                    opCode = controlGetOpCode;
                    final vendorModelMessage = await widget.meshManagerApi
                        .golainVendorModelSend(selectedElementAddress!, opCode!, Uint8List(0));
                    log(vendorModelMessage.message.toString());
                    // Recieve the message from the protobuf from the device
                    final message = shadow.fromBuffer(vendorModelMessage.message.toList());
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('Vendor Model Message: ${message}'),
                      ),
                    );
                  } on PlatformException catch (e) {
                    log(e.toString());
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('Failed to send vendor model message: ${e.message}'),
                      ),
                    );
                  }
                }
              : null,
          child: const Text('GET'),
        ),
        TextButton(
          onPressed: selectedElementAddress != null
              ? () async {
                  // OPCODE is defined in the config file
                  opCode = controlSetOpCode;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RGBProtobuf(
                        meshManagerApi: widget.meshManagerApi,
                        opCode: opCode!,
                        selectedElementAddress: selectedElementAddress!,
                        modelId: widget.modelId,
                      ),
                    ),
                  );
                }
              : null,
          child: const Text('SET'),
        )
      ],
    );
  }
}

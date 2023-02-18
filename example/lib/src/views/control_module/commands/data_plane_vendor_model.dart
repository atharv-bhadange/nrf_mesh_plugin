import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';

import '../../../../env/config.dart';

class DataPlaneVendorModel extends StatefulWidget {
  final MeshManagerApi meshManagerApi;
  final int modelId;

  const DataPlaneVendorModel({Key? key, required this.meshManagerApi, required this.modelId}) : super(key: key);

  @override
  State<DataPlaneVendorModel> createState() => _DataPlaneVendorModelState();
}

class _DataPlaneVendorModelState extends State<DataPlaneVendorModel> {
  int? selectedElementAddress;
  int? opCode;
  String? dataType;
  Uint8List? byteData;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: const ValueKey('module-send-golain-vendor-model'),
      title: Text('Data Plane Vendor Model: ${widget.modelId.toRadixString(16)}'),
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
          decoration: const InputDecoration(hintText: 'Data Request Type'),
          onChanged: (text) {
            dataType = text;
            setState(() {});
          },
        ),
        TextButton(
          onPressed: selectedElementAddress != null
              ? () async {
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  try {
                    // OPCODE is defined in the config file
                    opCode = dataGetOpCode;
                    final vendorModelMessage = await widget.meshManagerApi.golainVendorModelSend(
                        selectedElementAddress!, opCode!, Uint8List.fromList(dataType!.codeUnits),
                        modelId: widget.modelId);
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('Vendor Model Message: ${vendorModelMessage.message}'),
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
      ],
    );
  }
}

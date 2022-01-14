import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nordic_nrf_mesh/src/contants.dart';

part 'provisioned_mesh_node.g.dart';

@JsonSerializable(anyMap: true)
class ModelData {
  final int key;
  final int modelId;
  final List<int> subscribedAddresses;
  final List<int> boundAppKey;

  ModelData(this.key, this.modelId, this.subscribedAddresses, this.boundAppKey);

  factory ModelData.fromJson(Map json) => _$ModelDataFromJson(json);

  Map<String, dynamic> toJson() => _$ModelDataToJson(this);

  @override
  String toString() => 'ModelData ${toJson()}';
}

@JsonSerializable(anyMap: true)
class ElementData {
  final int key;
  final int address;
  final String name;
  final int locationDescriptor;
  final List<ModelData> models;

  ElementData(this.key, this.name, this.address, this.locationDescriptor, this.models);

  factory ElementData.fromJson(Map json) => _$ElementDataFromJson(json.cast<String, dynamic>());

  Map<String, dynamic> toJson() => _$ElementDataToJson(this);

  @override
  String toString() => 'ElementData ${toJson()}';
}

class ProvisionedMeshNode {
  final MethodChannel _methodChannel;
  final String uuid;

  ProvisionedMeshNode(this.uuid) : _methodChannel = MethodChannel('$namespace/provisioned_mesh_node/$uuid/methods');

  Future<int> get unicastAddress async => (await _methodChannel.invokeMethod<int>('unicastAddress'))!;

  set nodeName(String name) => _methodChannel.invokeMethod('nodeName', {'name': name});

  Future<String> get name async => (await _methodChannel.invokeMethod<String>('name'))!;

  Future<List<ElementData>> get elements async {
    final _elements = await _methodChannel.invokeMethod<List>('elements');
    return _elements!.map((e) => ElementData.fromJson(e)).toList();
  }
}
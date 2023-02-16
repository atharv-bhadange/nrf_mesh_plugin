///
//  Generated code. Do not modify.
//  source: rgb_on_off.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use statusDescriptor instead')
const Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'ON', '2': 0},
    const {'1': 'OFF', '2': 1},
  ],
};

/// Descriptor for `Status`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List statusDescriptor = $convert.base64Decode('CgZTdGF0dXMSBgoCT04QABIHCgNPRkYQAQ==');
@$core.Deprecated('Use rGBDescriptor instead')
const RGB$json = const {
  '1': 'RGB',
  '2': const [
    const {'1': 'red', '3': 1, '4': 1, '5': 5, '10': 'red'},
    const {'1': 'green', '3': 2, '4': 1, '5': 5, '10': 'green'},
    const {'1': 'blue', '3': 3, '4': 1, '5': 5, '10': 'blue'},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.Status', '10': 'status'},
  ],
};

/// Descriptor for `RGB`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rGBDescriptor = $convert.base64Decode('CgNSR0ISEAoDcmVkGAEgASgFUgNyZWQSFAoFZ3JlZW4YAiABKAVSBWdyZWVuEhIKBGJsdWUYAyABKAVSBGJsdWUSHwoGc3RhdHVzGAQgASgOMgcuU3RhdHVzUgZzdGF0dXM=');

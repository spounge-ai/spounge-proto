# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# NO CHECKED-IN PROTOBUF GENCODE
# source: nodus/v1/common/v1/errors.proto
# Protobuf Python Version: 6.31.1
"""Generated protocol buffer code."""
from google.protobuf import descriptor as _descriptor
from google.protobuf import descriptor_pool as _descriptor_pool
from google.protobuf import runtime_version as _runtime_version
from google.protobuf import symbol_database as _symbol_database
from google.protobuf.internal import builder as _builder
_runtime_version.ValidateProtobufRuntimeVersion(
    _runtime_version.Domain.PUBLIC,
    6,
    31,
    1,
    '',
    'nodus/v1/common/v1/errors.proto'
)
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()


from google.protobuf import timestamp_pb2 as google_dot_protobuf_dot_timestamp__pb2


DESCRIPTOR = _descriptor_pool.Default().AddSerializedFile(b'\n\x1fnodus/v1/common/v1/errors.proto\x12\x12nodus.v1.common.v1\x1a\x1fgoogle/protobuf/timestamp.proto\"\xf8\x02\n\x0e\x45xecutionError\x12<\n\nerror_type\x18\x01 \x01(\x0e\x32\x1d.nodus.v1.common.v1.ErrorTypeR\terrorType\x12\x1d\n\nerror_code\x18\x02 \x01(\tR\terrorCode\x12#\n\rerror_message\x18\x03 \x01(\tR\x0c\x65rrorMessage\x12\x1f\n\x0bstack_trace\x18\x04 \x01(\tR\nstackTrace\x12:\n\x07\x63ontext\x18\x05 \x01(\x0b\x32 .nodus.v1.common.v1.ErrorContextR\x07\x63ontext\x12\x39\n\x07\x64\x65tails\x18\x06 \x03(\x0b\x32\x1f.nodus.v1.common.v1.ErrorDetailR\x07\x64\x65tails\x12\x1c\n\tretryable\x18\x07 \x01(\x08R\tretryable\x12.\n\x13retry_after_seconds\x18\x08 \x01(\x05R\x11retryAfterSeconds\"\xb0\x02\n\x0c\x45rrorContext\x12\x1c\n\tcomponent\x18\x01 \x01(\tR\tcomponent\x12\x1c\n\toperation\x18\x02 \x01(\tR\toperation\x12P\n\nparameters\x18\x03 \x03(\x0b\x32\x30.nodus.v1.common.v1.ErrorContext.ParametersEntryR\nparameters\x12\x38\n\ttimestamp\x18\x04 \x01(\x0b\x32\x1a.google.protobuf.TimestampR\ttimestamp\x12\x19\n\x08trace_id\x18\x05 \x01(\tR\x07traceId\x1a=\n\x0fParametersEntry\x12\x10\n\x03key\x18\x01 \x01(\tR\x03key\x12\x14\n\x05value\x18\x02 \x01(\tR\x05value:\x02\x38\x01\"\x8d\x01\n\x0b\x45rrorDetail\x12\x14\n\x05\x66ield\x18\x01 \x01(\tR\x05\x66ield\x12\x1e\n\nconstraint\x18\x02 \x01(\tR\nconstraint\x12!\n\x0c\x61\x63tual_value\x18\x03 \x01(\tR\x0b\x61\x63tualValue\x12%\n\x0e\x65xpected_value\x18\x04 \x01(\tR\rexpectedValue*\xc8\x02\n\tErrorType\x12\x1a\n\x16\x45RROR_TYPE_UNSPECIFIED\x10\x00\x12\x19\n\x15\x45RROR_TYPE_VALIDATION\x10\x01\x12\x16\n\x12\x45RROR_TYPE_TIMEOUT\x10\x02\x12\"\n\x1e\x45RROR_TYPE_RESOURCE_EXHAUSTION\x10\x03\x12\x1f\n\x1b\x45RROR_TYPE_EXTERNAL_SERVICE\x10\x04\x12\x1b\n\x17\x45RROR_TYPE_LLM_PROVIDER\x10\x05\x12\x19\n\x15\x45RROR_TYPE_MCP_SERVER\x10\x06\x12\x17\n\x13\x45RROR_TYPE_DATABASE\x10\x07\x12\x1e\n\x1a\x45RROR_TYPE_API_INTEGRATION\x10\x08\x12\x1d\n\x19\x45RROR_TYPE_AUTHENTICATION\x10\t\x12\x17\n\x13\x45RROR_TYPE_INTERNAL\x10\nB\xd9\x01\n\x16\x63om.nodus.v1.common.v1B\x0b\x45rrorsProtoP\x01ZGgithub.com/spounge-ai/spounge-protos/gen/go/nodus/v1/common/v1;commonv1\xa2\x02\x03NVC\xaa\x02\x12Nodus.V1.Common.V1\xca\x02\x12Nodus\\V1\\Common\\V1\xe2\x02\x1eNodus\\V1\\Common\\V1\\GPBMetadata\xea\x02\x15Nodus::V1::Common::V1b\x06proto3')

_globals = globals()
_builder.BuildMessageAndEnumDescriptors(DESCRIPTOR, _globals)
_builder.BuildTopDescriptorsAndMessages(DESCRIPTOR, 'nodus.v1.common.v1.errors_pb2', _globals)
if not _descriptor._USE_C_DESCRIPTORS:
  _globals['DESCRIPTOR']._loaded_options = None
  _globals['DESCRIPTOR']._serialized_options = b'\n\026com.nodus.v1.common.v1B\013ErrorsProtoP\001ZGgithub.com/spounge-ai/spounge-protos/gen/go/nodus/v1/common/v1;commonv1\242\002\003NVC\252\002\022Nodus.V1.Common.V1\312\002\022Nodus\\V1\\Common\\V1\342\002\036Nodus\\V1\\Common\\V1\\GPBMetadata\352\002\025Nodus::V1::Common::V1'
  _globals['_ERRORCONTEXT_PARAMETERSENTRY']._loaded_options = None
  _globals['_ERRORCONTEXT_PARAMETERSENTRY']._serialized_options = b'8\001'
  _globals['_ERRORTYPE']._serialized_start=919
  _globals['_ERRORTYPE']._serialized_end=1247
  _globals['_EXECUTIONERROR']._serialized_start=89
  _globals['_EXECUTIONERROR']._serialized_end=465
  _globals['_ERRORCONTEXT']._serialized_start=468
  _globals['_ERRORCONTEXT']._serialized_end=772
  _globals['_ERRORCONTEXT_PARAMETERSENTRY']._serialized_start=711
  _globals['_ERRORCONTEXT_PARAMETERSENTRY']._serialized_end=772
  _globals['_ERRORDETAIL']._serialized_start=775
  _globals['_ERRORDETAIL']._serialized_end=916
# @@protoc_insertion_point(module_scope)

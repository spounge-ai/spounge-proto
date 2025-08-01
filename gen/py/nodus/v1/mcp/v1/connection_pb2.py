# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# NO CHECKED-IN PROTOBUF GENCODE
# source: nodus/v1/mcp/v1/connection.proto
# Protobuf Python Version: 6.31.1
"""Generated protocol buffer code."""

from google.protobuf import descriptor as _descriptor
from google.protobuf import descriptor_pool as _descriptor_pool
from google.protobuf import runtime_version as _runtime_version
from google.protobuf import symbol_database as _symbol_database
from google.protobuf.internal import builder as _builder

_runtime_version.ValidateProtobufRuntimeVersion(
    _runtime_version.Domain.PUBLIC, 6, 31, 1, "", "nodus/v1/mcp/v1/connection.proto"
)
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()




DESCRIPTOR = _descriptor_pool.Default().AddSerializedFile(
    b'\n nodus/v1/mcp/v1/connection.proto\x12\x0fnodus.v1.mcp.v1\x1a\x1cgoogle/protobuf/struct.proto\x1a\x1egoogle/protobuf/duration.proto\x1a\x1cnodus/v1/mcp/v1/server.proto\x1a\x1anodus/v1/mcp/v1/tool.proto\x1a\x1fnodus/v1/common/v1/errors.proto"\xf9\x02\n\x18RegisterMCPServerRequest\x12\x1b\n\tserver_id\x18\x01 \x01(\tR\x08serverId\x12\x1a\n\x08\x65ndpoint\x18\x02 \x01(\tR\x08\x65ndpoint\x12?\n\x0bserver_type\x18\x03 \x01(\x0e\x32\x1e.nodus.v1.mcp.v1.MCPServerTypeR\nserverType\x12Q\n\x11\x63onnection_config\x18\x04 \x01(\x0b\x32$.nodus.v1.mcp.v1.MCPConnectionConfigR\x10\x63onnectionConfig\x12S\n\x08metadata\x18\x05 \x03(\x0b\x32\x37.nodus.v1.mcp.v1.RegisterMCPServerRequest.MetadataEntryR\x08metadata\x1a;\n\rMetadataEntry\x12\x10\n\x03key\x18\x01 \x01(\tR\x03key\x12\x14\n\x05value\x18\x02 \x01(\tR\x05value:\x02\x38\x01"\x9b\x02\n\x19RegisterMCPServerResponse\x12\x18\n\x07success\x18\x01 \x01(\x08R\x07success\x12\x1b\n\tserver_id\x18\x02 \x01(\tR\x08serverId\x12J\n\x0c\x63\x61pabilities\x18\x03 \x01(\x0b\x32&.nodus.v1.mcp.v1.MCPServerCapabilitiesR\x0c\x63\x61pabilities\x12\x41\n\x0f\x61vailable_tools\x18\x04 \x03(\x0b\x32\x18.nodus.v1.mcp.v1.MCPToolR\x0e\x61vailableTools\x12\x38\n\x05\x65rror\x18\x05 \x01(\x0b\x32".nodus.v1.common.v1.ExecutionErrorR\x05\x65rror"\xa2\x01\n\x15ListMCPServersRequest\x12\x1d\n\nserver_ids\x18\x01 \x03(\tR\tserverIds\x12\x45\n\rstatus_filter\x18\x02 \x01(\x0e\x32 .nodus.v1.mcp.v1.MCPServerStatusR\x0cstatusFilter\x12#\n\rinclude_tools\x18\x03 \x01(\x08R\x0cincludeTools"w\n\x16ListMCPServersResponse\x12\x38\n\x07servers\x18\x01 \x03(\x0b\x32\x1e.nodus.v1.mcp.v1.MCPServerInfoR\x07servers\x12#\n\rtotal_servers\x18\x02 \x01(\x05R\x0ctotalServers"\xaf\x01\n\x14QueryMCPToolsRequest\x12\x1d\n\nserver_ids\x18\x01 \x03(\tR\tserverIds\x12\x33\n\x06\x66ilter\x18\x02 \x01(\x0b\x32\x1b.nodus.v1.mcp.v1.ToolFilterR\x06\x66ilter\x12\x14\n\x05limit\x18\x03 \x01(\x05R\x05limit\x12-\n\x12\x63ontinuation_token\x18\x04 \x01(\tR\x11\x63ontinuationToken"\xa4\x01\n\x15QueryMCPToolsResponse\x12.\n\x05tools\x18\x01 \x03(\x0b\x32\x18.nodus.v1.mcp.v1.MCPToolR\x05tools\x12\x36\n\x17next_continuation_token\x18\x02 \x01(\tR\x15nextContinuationToken\x12#\n\rtotal_matches\x18\x03 \x01(\x05R\x0ctotalMatches"\xb1\x01\n\nToolFilter\x12=\n\ncategories\x18\x01 \x03(\x0e\x32\x1d.nodus.v1.mcp.v1.ToolCategoryR\ncategories\x12\x12\n\x04tags\x18\x02 \x03(\tR\x04tags\x12!\n\x0cname_pattern\x18\x03 \x01(\tR\x0bnamePattern\x12-\n\x12supports_streaming\x18\x04 \x01(\x08R\x11supportsStreaming"\xc4\x01\n\x11MCPToolInvocation\x12\x17\n\x07tool_id\x18\x01 \x01(\tR\x06toolId\x12\x1b\n\tserver_id\x18\x02 \x01(\tR\x08serverId\x12\x37\n\nparameters\x18\x03 \x01(\x0b\x32\x17.google.protobuf.StructR\nparameters\x12@\n\x07options\x18\x04 \x01(\x0b\x32&.nodus.v1.mcp.v1.ToolInvocationOptionsR\x07options"\xbb\x02\n\x15ToolInvocationOptions\x12/\n\x13validate_parameters\x18\x01 \x01(\x08R\x12validateParameters\x12\x31\n\x14require_confirmation\x18\x02 \x01(\x08R\x13requireConfirmation\x12\x33\n\x07timeout\x18\x03 \x01(\x0b\x32\x19.google.protobuf.DurationR\x07timeout\x12M\n\x07\x63ontext\x18\x04 \x03(\x0b\x32\x33.nodus.v1.mcp.v1.ToolInvocationOptions.ContextEntryR\x07\x63ontext\x1a:\n\x0c\x43ontextEntry\x12\x10\n\x03key\x18\x01 \x01(\tR\x03key\x12\x14\n\x05value\x18\x02 \x01(\tR\x05value:\x02\x38\x01"\x8f\x02\n\rMCPToolResult\x12\x18\n\x07success\x18\x01 \x01(\x08R\x07success\x12\x38\n\x0bresult_data\x18\x02 \x01(\x0b\x32\x17.google.protobuf.StructR\nresultData\x12#\n\rerror_message\x18\x03 \x01(\tR\x0c\x65rrorMessage\x12H\n\x08metadata\x18\x04 \x03(\x0b\x32,.nodus.v1.mcp.v1.MCPToolResult.MetadataEntryR\x08metadata\x1a;\n\rMetadataEntry\x12\x10\n\x03key\x18\x01 \x01(\tR\x03key\x12\x14\n\x05value\x18\x02 \x01(\tR\x05value:\x02\x38\x01\x42\xc8\x01\n\x13\x63om.nodus.v1.mcp.v1B\x0f\x43onnectionProtoP\x01ZAgithub.com/spounge-ai/spounge-protos/gen/go/nodus/v1/mcp/v1;mcpv1\xa2\x02\x03NVM\xaa\x02\x0fNodus.V1.Mcp.V1\xca\x02\x0fNodus\\V1\\Mcp\\V1\xe2\x02\x1bNodus\\V1\\Mcp\\V1\\GPBMetadata\xea\x02\x12Nodus::V1::Mcp::V1b\x06proto3'
)

_globals = globals()
_builder.BuildMessageAndEnumDescriptors(DESCRIPTOR, _globals)
_builder.BuildTopDescriptorsAndMessages(
    DESCRIPTOR, "nodus.v1.mcp.v1.connection_pb2", _globals
)
if not _descriptor._USE_C_DESCRIPTORS:
    _globals["DESCRIPTOR"]._loaded_options = None
    _globals[
        "DESCRIPTOR"
    ]._serialized_options = b"\n\023com.nodus.v1.mcp.v1B\017ConnectionProtoP\001ZAgithub.com/spounge-ai/spounge-protos/gen/go/nodus/v1/mcp/v1;mcpv1\242\002\003NVM\252\002\017Nodus.V1.Mcp.V1\312\002\017Nodus\\V1\\Mcp\\V1\342\002\033Nodus\\V1\\Mcp\\V1\\GPBMetadata\352\002\022Nodus::V1::Mcp::V1"
    _globals["_REGISTERMCPSERVERREQUEST_METADATAENTRY"]._loaded_options = None
    _globals["_REGISTERMCPSERVERREQUEST_METADATAENTRY"]._serialized_options = b"8\001"
    _globals["_TOOLINVOCATIONOPTIONS_CONTEXTENTRY"]._loaded_options = None
    _globals["_TOOLINVOCATIONOPTIONS_CONTEXTENTRY"]._serialized_options = b"8\001"
    _globals["_MCPTOOLRESULT_METADATAENTRY"]._loaded_options = None
    _globals["_MCPTOOLRESULT_METADATAENTRY"]._serialized_options = b"8\001"
    _globals["_REGISTERMCPSERVERREQUEST"]._serialized_start = 207
    _globals["_REGISTERMCPSERVERREQUEST"]._serialized_end = 584
    _globals["_REGISTERMCPSERVERREQUEST_METADATAENTRY"]._serialized_start = 525
    _globals["_REGISTERMCPSERVERREQUEST_METADATAENTRY"]._serialized_end = 584
    _globals["_REGISTERMCPSERVERRESPONSE"]._serialized_start = 587
    _globals["_REGISTERMCPSERVERRESPONSE"]._serialized_end = 870
    _globals["_LISTMCPSERVERSREQUEST"]._serialized_start = 873
    _globals["_LISTMCPSERVERSREQUEST"]._serialized_end = 1035
    _globals["_LISTMCPSERVERSRESPONSE"]._serialized_start = 1037
    _globals["_LISTMCPSERVERSRESPONSE"]._serialized_end = 1156
    _globals["_QUERYMCPTOOLSREQUEST"]._serialized_start = 1159
    _globals["_QUERYMCPTOOLSREQUEST"]._serialized_end = 1334
    _globals["_QUERYMCPTOOLSRESPONSE"]._serialized_start = 1337
    _globals["_QUERYMCPTOOLSRESPONSE"]._serialized_end = 1501
    _globals["_TOOLFILTER"]._serialized_start = 1504
    _globals["_TOOLFILTER"]._serialized_end = 1681
    _globals["_MCPTOOLINVOCATION"]._serialized_start = 1684
    _globals["_MCPTOOLINVOCATION"]._serialized_end = 1880
    _globals["_TOOLINVOCATIONOPTIONS"]._serialized_start = 1883
    _globals["_TOOLINVOCATIONOPTIONS"]._serialized_end = 2198
    _globals["_TOOLINVOCATIONOPTIONS_CONTEXTENTRY"]._serialized_start = 2140
    _globals["_TOOLINVOCATIONOPTIONS_CONTEXTENTRY"]._serialized_end = 2198
    _globals["_MCPTOOLRESULT"]._serialized_start = 2201
    _globals["_MCPTOOLRESULT"]._serialized_end = 2472
    _globals["_MCPTOOLRESULT_METADATAENTRY"]._serialized_start = 525
    _globals["_MCPTOOLRESULT_METADATAENTRY"]._serialized_end = 584
# @@protoc_insertion_point(module_scope)

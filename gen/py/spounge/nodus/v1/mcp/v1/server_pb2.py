# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# NO CHECKED-IN PROTOBUF GENCODE
# source: nodus/v1/mcp/v1/server.proto
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
    'nodus/v1/mcp/v1/server.proto'
)
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()


from google.protobuf import duration_pb2 as google_dot_protobuf_dot_duration__pb2
from google.protobuf import timestamp_pb2 as google_dot_protobuf_dot_timestamp__pb2
from spounge.nodus.v1.common.v1 import auth_pb2 as nodus_dot_v1_dot_common_dot_v1_dot_auth__pb2


DESCRIPTOR = _descriptor_pool.Default().AddSerializedFile(b'\n\x1cnodus/v1/mcp/v1/server.proto\x12\x0fnodus.v1.mcp.v1\x1a\x1egoogle/protobuf/duration.proto\x1a\x1fgoogle/protobuf/timestamp.proto\x1a\x1dnodus/v1/common/v1/auth.proto\"\xf7\x04\n\rMCPServerInfo\x12\x1b\n\tserver_id\x18\x01 \x01(\tR\x08serverId\x12\x12\n\x04name\x18\x02 \x01(\tR\x04name\x12\x1a\n\x08\x65ndpoint\x18\x03 \x01(\tR\x08\x65ndpoint\x12?\n\x0bserver_type\x18\x04 \x01(\x0e\x32\x1e.nodus.v1.mcp.v1.MCPServerTypeR\nserverType\x12\x38\n\x06status\x18\x05 \x01(\x0e\x32 .nodus.v1.mcp.v1.MCPServerStatusR\x06status\x12J\n\x0c\x63\x61pabilities\x18\x06 \x01(\x0b\x32&.nodus.v1.mcp.v1.MCPServerCapabilitiesR\x0c\x63\x61pabilities\x12Q\n\x11\x63onnection_config\x18\x07 \x01(\x0b\x32$.nodus.v1.mcp.v1.MCPConnectionConfigR\x10\x63onnectionConfig\x12H\n\x08metadata\x18\x08 \x03(\x0b\x32,.nodus.v1.mcp.v1.MCPServerInfo.MetadataEntryR\x08metadata\x12?\n\rregistered_at\x18\t \x01(\x0b\x32\x1a.google.protobuf.TimestampR\x0cregisteredAt\x12\x37\n\tlast_ping\x18\n \x01(\x0b\x32\x1a.google.protobuf.TimestampR\x08lastPing\x1a;\n\rMetadataEntry\x12\x10\n\x03key\x18\x01 \x01(\tR\x03key\x12\x14\n\x05value\x18\x02 \x01(\tR\x05value:\x02\x38\x01\"\xce\x02\n\x15MCPServerCapabilities\x12)\n\x10protocol_version\x18\x01 \x01(\tR\x0fprotocolVersion\x12-\n\x12supported_features\x18\x02 \x03(\tR\x11supportedFeatures\x12\x36\n\x17max_concurrent_requests\x18\x03 \x01(\x05R\x15maxConcurrentRequests\x12:\n\x19supported_tool_categories\x18\x04 \x03(\tR\x17supportedToolCategories\x12-\n\x12supports_streaming\x18\x05 \x01(\x08R\x11supportsStreaming\x12\x38\n\x18supports_file_operations\x18\x06 \x01(\x08R\x16supportsFileOperations\"\xcf\x04\n\x13MCPConnectionConfig\x12H\n\x12\x63onnection_timeout\x18\x01 \x01(\x0b\x32\x19.google.protobuf.DurationR\x11\x63onnectionTimeout\x12\x42\n\x0frequest_timeout\x18\x02 \x01(\x0b\x32\x19.google.protobuf.DurationR\x0erequestTimeout\x12\x1f\n\x0bmax_retries\x18\x03 \x01(\x05R\nmaxRetries\x12>\n\rretry_backoff\x18\x04 \x01(\x0b\x32\x19.google.protobuf.DurationR\x0cretryBackoff\x12*\n\x11\x65nable_keep_alive\x18\x05 \x01(\x08R\x0f\x65nableKeepAlive\x12I\n\x13keep_alive_interval\x18\x06 \x01(\x0b\x32\x19.google.protobuf.DurationR\x11keepAliveInterval\x12K\n\x07headers\x18\x07 \x03(\x0b\x32\x31.nodus.v1.mcp.v1.MCPConnectionConfig.HeadersEntryR\x07headers\x12I\n\x0b\x61uth_config\x18\x08 \x01(\x0b\x32(.nodus.v1.common.v1.AuthenticationConfigR\nauthConfig\x1a:\n\x0cHeadersEntry\x12\x10\n\x03key\x18\x01 \x01(\tR\x03key\x12\x14\n\x05value\x18\x02 \x01(\tR\x05value:\x02\x38\x01*\xb7\x01\n\rMCPServerType\x12\x1f\n\x1bMCP_SERVER_TYPE_UNSPECIFIED\x10\x00\x12\x18\n\x14MCP_SERVER_TYPE_HTTP\x10\x01\x12\x1d\n\x19MCP_SERVER_TYPE_WEBSOCKET\x10\x02\x12\x18\n\x14MCP_SERVER_TYPE_GRPC\x10\x03\x12\x19\n\x15MCP_SERVER_TYPE_STDIO\x10\x04\x12\x17\n\x13MCP_SERVER_TYPE_TCP\x10\x05*\xdd\x01\n\x0fMCPServerStatus\x12!\n\x1dMCP_SERVER_STATUS_UNSPECIFIED\x10\x00\x12\x1d\n\x19MCP_SERVER_STATUS_HEALTHY\x10\x01\x12\x1f\n\x1bMCP_SERVER_STATUS_UNHEALTHY\x10\x02\x12 \n\x1cMCP_SERVER_STATUS_CONNECTING\x10\x03\x12\"\n\x1eMCP_SERVER_STATUS_DISCONNECTED\x10\x04\x12!\n\x1dMCP_SERVER_STATUS_MAINTENANCE\x10\x05\x42\xc4\x01\n\x13\x63om.nodus.v1.mcp.v1B\x0bServerProtoP\x01ZAgithub.com/spounge-ai/spounge-protos/gen/go/nodus/v1/mcp/v1;mcpv1\xa2\x02\x03NVM\xaa\x02\x0fNodus.V1.Mcp.V1\xca\x02\x0fNodus\\V1\\Mcp\\V1\xe2\x02\x1bNodus\\V1\\Mcp\\V1\\GPBMetadata\xea\x02\x12Nodus::V1::Mcp::V1b\x06proto3')

_globals = globals()
_builder.BuildMessageAndEnumDescriptors(DESCRIPTOR, _globals)
_builder.BuildTopDescriptorsAndMessages(DESCRIPTOR, 'nodus.v1.mcp.v1.server_pb2', _globals)
if not _descriptor._USE_C_DESCRIPTORS:
  _globals['DESCRIPTOR']._loaded_options = None
  _globals['DESCRIPTOR']._serialized_options = b'\n\023com.nodus.v1.mcp.v1B\013ServerProtoP\001ZAgithub.com/spounge-ai/spounge-protos/gen/go/nodus/v1/mcp/v1;mcpv1\242\002\003NVM\252\002\017Nodus.V1.Mcp.V1\312\002\017Nodus\\V1\\Mcp\\V1\342\002\033Nodus\\V1\\Mcp\\V1\\GPBMetadata\352\002\022Nodus::V1::Mcp::V1'
  _globals['_MCPSERVERINFO_METADATAENTRY']._loaded_options = None
  _globals['_MCPSERVERINFO_METADATAENTRY']._serialized_options = b'8\001'
  _globals['_MCPCONNECTIONCONFIG_HEADERSENTRY']._loaded_options = None
  _globals['_MCPCONNECTIONCONFIG_HEADERSENTRY']._serialized_options = b'8\001'
  _globals['_MCPSERVERTYPE']._serialized_start=1711
  _globals['_MCPSERVERTYPE']._serialized_end=1894
  _globals['_MCPSERVERSTATUS']._serialized_start=1897
  _globals['_MCPSERVERSTATUS']._serialized_end=2118
  _globals['_MCPSERVERINFO']._serialized_start=146
  _globals['_MCPSERVERINFO']._serialized_end=777
  _globals['_MCPSERVERINFO_METADATAENTRY']._serialized_start=718
  _globals['_MCPSERVERINFO_METADATAENTRY']._serialized_end=777
  _globals['_MCPSERVERCAPABILITIES']._serialized_start=780
  _globals['_MCPSERVERCAPABILITIES']._serialized_end=1114
  _globals['_MCPCONNECTIONCONFIG']._serialized_start=1117
  _globals['_MCPCONNECTIONCONFIG']._serialized_end=1708
  _globals['_MCPCONNECTIONCONFIG_HEADERSENTRY']._serialized_start=1650
  _globals['_MCPCONNECTIONCONFIG_HEADERSENTRY']._serialized_end=1708
# @@protoc_insertion_point(module_scope)

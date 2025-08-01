// @generated by protoc-gen-es v2.6.2 with parameter "target=ts,import_extension=none"
// @generated from file nodus/v1/mcp/v1/connection.proto (package nodus.v1.mcp.v1, syntax proto3)
/* eslint-disable */

import type { GenFile, GenMessage } from "@bufbuild/protobuf/codegenv2";
import { fileDesc, messageDesc } from "@bufbuild/protobuf/codegenv2";
import type { Duration } from "@bufbuild/protobuf/wkt";
import { file_google_protobuf_duration, file_google_protobuf_struct } from "@bufbuild/protobuf/wkt";
import type { MCPConnectionConfig, MCPServerCapabilities, MCPServerInfo, MCPServerStatus, MCPServerType } from "./server_pb";
import { file_nodus_v1_mcp_v1_server } from "./server_pb";
import type { MCPTool, ToolCategory } from "./tool_pb";
import { file_nodus_v1_mcp_v1_tool } from "./tool_pb";
import type { ExecutionError } from "../../common/v1/errors_pb";
import { file_nodus_v1_common_v1_errors } from "../../common/v1/errors_pb";
import type { JsonObject, Message } from "@bufbuild/protobuf";

/**
 * Describes the file nodus/v1/mcp/v1/connection.proto.
 */
export const file_nodus_v1_mcp_v1_connection: GenFile = /*@__PURE__*/
  fileDesc("CiBub2R1cy92MS9tY3AvdjEvY29ubmVjdGlvbi5wcm90bxIPbm9kdXMudjEubWNwLnYxIrECChhSZWdpc3Rlck1DUFNlcnZlclJlcXVlc3QSEQoJc2VydmVyX2lkGAEgASgJEhAKCGVuZHBvaW50GAIgASgJEjMKC3NlcnZlcl90eXBlGAMgASgOMh4ubm9kdXMudjEubWNwLnYxLk1DUFNlcnZlclR5cGUSPwoRY29ubmVjdGlvbl9jb25maWcYBCABKAsyJC5ub2R1cy52MS5tY3AudjEuTUNQQ29ubmVjdGlvbkNvbmZpZxJJCghtZXRhZGF0YRgFIAMoCzI3Lm5vZHVzLnYxLm1jcC52MS5SZWdpc3Rlck1DUFNlcnZlclJlcXVlc3QuTWV0YWRhdGFFbnRyeRovCg1NZXRhZGF0YUVudHJ5EgsKA2tleRgBIAEoCRINCgV2YWx1ZRgCIAEoCToCOAEi4wEKGVJlZ2lzdGVyTUNQU2VydmVyUmVzcG9uc2USDwoHc3VjY2VzcxgBIAEoCBIRCglzZXJ2ZXJfaWQYAiABKAkSPAoMY2FwYWJpbGl0aWVzGAMgASgLMiYubm9kdXMudjEubWNwLnYxLk1DUFNlcnZlckNhcGFiaWxpdGllcxIxCg9hdmFpbGFibGVfdG9vbHMYBCADKAsyGC5ub2R1cy52MS5tY3AudjEuTUNQVG9vbBIxCgVlcnJvchgFIAEoCzIiLm5vZHVzLnYxLmNvbW1vbi52MS5FeGVjdXRpb25FcnJvciJ7ChVMaXN0TUNQU2VydmVyc1JlcXVlc3QSEgoKc2VydmVyX2lkcxgBIAMoCRI3Cg1zdGF0dXNfZmlsdGVyGAIgASgOMiAubm9kdXMudjEubWNwLnYxLk1DUFNlcnZlclN0YXR1cxIVCg1pbmNsdWRlX3Rvb2xzGAMgASgIImAKFkxpc3RNQ1BTZXJ2ZXJzUmVzcG9uc2USLwoHc2VydmVycxgBIAMoCzIeLm5vZHVzLnYxLm1jcC52MS5NQ1BTZXJ2ZXJJbmZvEhUKDXRvdGFsX3NlcnZlcnMYAiABKAUiggEKFFF1ZXJ5TUNQVG9vbHNSZXF1ZXN0EhIKCnNlcnZlcl9pZHMYASADKAkSKwoGZmlsdGVyGAIgASgLMhsubm9kdXMudjEubWNwLnYxLlRvb2xGaWx0ZXISDQoFbGltaXQYAyABKAUSGgoSY29udGludWF0aW9uX3Rva2VuGAQgASgJIngKFVF1ZXJ5TUNQVG9vbHNSZXNwb25zZRInCgV0b29scxgBIAMoCzIYLm5vZHVzLnYxLm1jcC52MS5NQ1BUb29sEh8KF25leHRfY29udGludWF0aW9uX3Rva2VuGAIgASgJEhUKDXRvdGFsX21hdGNoZXMYAyABKAUifwoKVG9vbEZpbHRlchIxCgpjYXRlZ29yaWVzGAEgAygOMh0ubm9kdXMudjEubWNwLnYxLlRvb2xDYXRlZ29yeRIMCgR0YWdzGAIgAygJEhQKDG5hbWVfcGF0dGVybhgDIAEoCRIaChJzdXBwb3J0c19zdHJlYW1pbmcYBCABKAginQEKEU1DUFRvb2xJbnZvY2F0aW9uEg8KB3Rvb2xfaWQYASABKAkSEQoJc2VydmVyX2lkGAIgASgJEisKCnBhcmFtZXRlcnMYAyABKAsyFy5nb29nbGUucHJvdG9idWYuU3RydWN0EjcKB29wdGlvbnMYBCABKAsyJi5ub2R1cy52MS5tY3AudjEuVG9vbEludm9jYXRpb25PcHRpb25zIvQBChVUb29sSW52b2NhdGlvbk9wdGlvbnMSGwoTdmFsaWRhdGVfcGFyYW1ldGVycxgBIAEoCBIcChRyZXF1aXJlX2NvbmZpcm1hdGlvbhgCIAEoCBIqCgd0aW1lb3V0GAMgASgLMhkuZ29vZ2xlLnByb3RvYnVmLkR1cmF0aW9uEkQKB2NvbnRleHQYBCADKAsyMy5ub2R1cy52MS5tY3AudjEuVG9vbEludm9jYXRpb25PcHRpb25zLkNvbnRleHRFbnRyeRouCgxDb250ZXh0RW50cnkSCwoDa2V5GAEgASgJEg0KBXZhbHVlGAIgASgJOgI4ASLWAQoNTUNQVG9vbFJlc3VsdBIPCgdzdWNjZXNzGAEgASgIEiwKC3Jlc3VsdF9kYXRhGAIgASgLMhcuZ29vZ2xlLnByb3RvYnVmLlN0cnVjdBIVCg1lcnJvcl9tZXNzYWdlGAMgASgJEj4KCG1ldGFkYXRhGAQgAygLMiwubm9kdXMudjEubWNwLnYxLk1DUFRvb2xSZXN1bHQuTWV0YWRhdGFFbnRyeRovCg1NZXRhZGF0YUVudHJ5EgsKA2tleRgBIAEoCRINCgV2YWx1ZRgCIAEoCToCOAFCyAEKE2NvbS5ub2R1cy52MS5tY3AudjFCD0Nvbm5lY3Rpb25Qcm90b1ABWkFnaXRodWIuY29tL3Nwb3VuZ2UtYWkvc3BvdW5nZS1wcm90b3MvZ2VuL2dvL25vZHVzL3YxL21jcC92MTttY3B2MaICA05WTaoCD05vZHVzLlYxLk1jcC5WMcoCD05vZHVzXFYxXE1jcFxWMeICG05vZHVzXFYxXE1jcFxWMVxHUEJNZXRhZGF0YeoCEk5vZHVzOjpWMTo6TWNwOjpWMWIGcHJvdG8z", [file_google_protobuf_struct, file_google_protobuf_duration, file_nodus_v1_mcp_v1_server, file_nodus_v1_mcp_v1_tool, file_nodus_v1_common_v1_errors]);

/**
 * @generated from message nodus.v1.mcp.v1.RegisterMCPServerRequest
 */
export type RegisterMCPServerRequest = Message<"nodus.v1.mcp.v1.RegisterMCPServerRequest"> & {
  /**
   * @generated from field: string server_id = 1;
   */
  serverId: string;

  /**
   * @generated from field: string endpoint = 2;
   */
  endpoint: string;

  /**
   * @generated from field: nodus.v1.mcp.v1.MCPServerType server_type = 3;
   */
  serverType: MCPServerType;

  /**
   * @generated from field: nodus.v1.mcp.v1.MCPConnectionConfig connection_config = 4;
   */
  connectionConfig?: MCPConnectionConfig;

  /**
   * @generated from field: map<string, string> metadata = 5;
   */
  metadata: { [key: string]: string };
};

/**
 * Describes the message nodus.v1.mcp.v1.RegisterMCPServerRequest.
 * Use `create(RegisterMCPServerRequestSchema)` to create a new message.
 */
export const RegisterMCPServerRequestSchema: GenMessage<RegisterMCPServerRequest> = /*@__PURE__*/
  messageDesc(file_nodus_v1_mcp_v1_connection, 0);

/**
 * @generated from message nodus.v1.mcp.v1.RegisterMCPServerResponse
 */
export type RegisterMCPServerResponse = Message<"nodus.v1.mcp.v1.RegisterMCPServerResponse"> & {
  /**
   * @generated from field: bool success = 1;
   */
  success: boolean;

  /**
   * @generated from field: string server_id = 2;
   */
  serverId: string;

  /**
   * @generated from field: nodus.v1.mcp.v1.MCPServerCapabilities capabilities = 3;
   */
  capabilities?: MCPServerCapabilities;

  /**
   * @generated from field: repeated nodus.v1.mcp.v1.MCPTool available_tools = 4;
   */
  availableTools: MCPTool[];

  /**
   * @generated from field: nodus.v1.common.v1.ExecutionError error = 5;
   */
  error?: ExecutionError;
};

/**
 * Describes the message nodus.v1.mcp.v1.RegisterMCPServerResponse.
 * Use `create(RegisterMCPServerResponseSchema)` to create a new message.
 */
export const RegisterMCPServerResponseSchema: GenMessage<RegisterMCPServerResponse> = /*@__PURE__*/
  messageDesc(file_nodus_v1_mcp_v1_connection, 1);

/**
 * @generated from message nodus.v1.mcp.v1.ListMCPServersRequest
 */
export type ListMCPServersRequest = Message<"nodus.v1.mcp.v1.ListMCPServersRequest"> & {
  /**
   * @generated from field: repeated string server_ids = 1;
   */
  serverIds: string[];

  /**
   * @generated from field: nodus.v1.mcp.v1.MCPServerStatus status_filter = 2;
   */
  statusFilter: MCPServerStatus;

  /**
   * @generated from field: bool include_tools = 3;
   */
  includeTools: boolean;
};

/**
 * Describes the message nodus.v1.mcp.v1.ListMCPServersRequest.
 * Use `create(ListMCPServersRequestSchema)` to create a new message.
 */
export const ListMCPServersRequestSchema: GenMessage<ListMCPServersRequest> = /*@__PURE__*/
  messageDesc(file_nodus_v1_mcp_v1_connection, 2);

/**
 * @generated from message nodus.v1.mcp.v1.ListMCPServersResponse
 */
export type ListMCPServersResponse = Message<"nodus.v1.mcp.v1.ListMCPServersResponse"> & {
  /**
   * @generated from field: repeated nodus.v1.mcp.v1.MCPServerInfo servers = 1;
   */
  servers: MCPServerInfo[];

  /**
   * @generated from field: int32 total_servers = 2;
   */
  totalServers: number;
};

/**
 * Describes the message nodus.v1.mcp.v1.ListMCPServersResponse.
 * Use `create(ListMCPServersResponseSchema)` to create a new message.
 */
export const ListMCPServersResponseSchema: GenMessage<ListMCPServersResponse> = /*@__PURE__*/
  messageDesc(file_nodus_v1_mcp_v1_connection, 3);

/**
 * @generated from message nodus.v1.mcp.v1.QueryMCPToolsRequest
 */
export type QueryMCPToolsRequest = Message<"nodus.v1.mcp.v1.QueryMCPToolsRequest"> & {
  /**
   * @generated from field: repeated string server_ids = 1;
   */
  serverIds: string[];

  /**
   * @generated from field: nodus.v1.mcp.v1.ToolFilter filter = 2;
   */
  filter?: ToolFilter;

  /**
   * @generated from field: int32 limit = 3;
   */
  limit: number;

  /**
   * @generated from field: string continuation_token = 4;
   */
  continuationToken: string;
};

/**
 * Describes the message nodus.v1.mcp.v1.QueryMCPToolsRequest.
 * Use `create(QueryMCPToolsRequestSchema)` to create a new message.
 */
export const QueryMCPToolsRequestSchema: GenMessage<QueryMCPToolsRequest> = /*@__PURE__*/
  messageDesc(file_nodus_v1_mcp_v1_connection, 4);

/**
 * @generated from message nodus.v1.mcp.v1.QueryMCPToolsResponse
 */
export type QueryMCPToolsResponse = Message<"nodus.v1.mcp.v1.QueryMCPToolsResponse"> & {
  /**
   * @generated from field: repeated nodus.v1.mcp.v1.MCPTool tools = 1;
   */
  tools: MCPTool[];

  /**
   * @generated from field: string next_continuation_token = 2;
   */
  nextContinuationToken: string;

  /**
   * @generated from field: int32 total_matches = 3;
   */
  totalMatches: number;
};

/**
 * Describes the message nodus.v1.mcp.v1.QueryMCPToolsResponse.
 * Use `create(QueryMCPToolsResponseSchema)` to create a new message.
 */
export const QueryMCPToolsResponseSchema: GenMessage<QueryMCPToolsResponse> = /*@__PURE__*/
  messageDesc(file_nodus_v1_mcp_v1_connection, 5);

/**
 * @generated from message nodus.v1.mcp.v1.ToolFilter
 */
export type ToolFilter = Message<"nodus.v1.mcp.v1.ToolFilter"> & {
  /**
   * @generated from field: repeated nodus.v1.mcp.v1.ToolCategory categories = 1;
   */
  categories: ToolCategory[];

  /**
   * @generated from field: repeated string tags = 2;
   */
  tags: string[];

  /**
   * @generated from field: string name_pattern = 3;
   */
  namePattern: string;

  /**
   * @generated from field: bool supports_streaming = 4;
   */
  supportsStreaming: boolean;
};

/**
 * Describes the message nodus.v1.mcp.v1.ToolFilter.
 * Use `create(ToolFilterSchema)` to create a new message.
 */
export const ToolFilterSchema: GenMessage<ToolFilter> = /*@__PURE__*/
  messageDesc(file_nodus_v1_mcp_v1_connection, 6);

/**
 * @generated from message nodus.v1.mcp.v1.MCPToolInvocation
 */
export type MCPToolInvocation = Message<"nodus.v1.mcp.v1.MCPToolInvocation"> & {
  /**
   * @generated from field: string tool_id = 1;
   */
  toolId: string;

  /**
   * @generated from field: string server_id = 2;
   */
  serverId: string;

  /**
   * @generated from field: google.protobuf.Struct parameters = 3;
   */
  parameters?: JsonObject;

  /**
   * @generated from field: nodus.v1.mcp.v1.ToolInvocationOptions options = 4;
   */
  options?: ToolInvocationOptions;
};

/**
 * Describes the message nodus.v1.mcp.v1.MCPToolInvocation.
 * Use `create(MCPToolInvocationSchema)` to create a new message.
 */
export const MCPToolInvocationSchema: GenMessage<MCPToolInvocation> = /*@__PURE__*/
  messageDesc(file_nodus_v1_mcp_v1_connection, 7);

/**
 * @generated from message nodus.v1.mcp.v1.ToolInvocationOptions
 */
export type ToolInvocationOptions = Message<"nodus.v1.mcp.v1.ToolInvocationOptions"> & {
  /**
   * @generated from field: bool validate_parameters = 1;
   */
  validateParameters: boolean;

  /**
   * @generated from field: bool require_confirmation = 2;
   */
  requireConfirmation: boolean;

  /**
   * @generated from field: google.protobuf.Duration timeout = 3;
   */
  timeout?: Duration;

  /**
   * @generated from field: map<string, string> context = 4;
   */
  context: { [key: string]: string };
};

/**
 * Describes the message nodus.v1.mcp.v1.ToolInvocationOptions.
 * Use `create(ToolInvocationOptionsSchema)` to create a new message.
 */
export const ToolInvocationOptionsSchema: GenMessage<ToolInvocationOptions> = /*@__PURE__*/
  messageDesc(file_nodus_v1_mcp_v1_connection, 8);

/**
 * @generated from message nodus.v1.mcp.v1.MCPToolResult
 */
export type MCPToolResult = Message<"nodus.v1.mcp.v1.MCPToolResult"> & {
  /**
   * @generated from field: bool success = 1;
   */
  success: boolean;

  /**
   * @generated from field: google.protobuf.Struct result_data = 2;
   */
  resultData?: JsonObject;

  /**
   * @generated from field: string error_message = 3;
   */
  errorMessage: string;

  /**
   * @generated from field: map<string, string> metadata = 4;
   */
  metadata: { [key: string]: string };
};

/**
 * Describes the message nodus.v1.mcp.v1.MCPToolResult.
 * Use `create(MCPToolResultSchema)` to create a new message.
 */
export const MCPToolResultSchema: GenMessage<MCPToolResult> = /*@__PURE__*/
  messageDesc(file_nodus_v1_mcp_v1_connection, 9);


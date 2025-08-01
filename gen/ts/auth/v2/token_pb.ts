// @generated by protoc-gen-es v2.6.2 with parameter "target=ts,import_extension=none"
// @generated from file auth/v2/token.proto (package auth.v2, syntax proto3)
/* eslint-disable */

import type { GenEnum, GenFile, GenMessage } from "@bufbuild/protobuf/codegenv2";
import { enumDesc, fileDesc, messageDesc } from "@bufbuild/protobuf/codegenv2";
import type { Timestamp } from "@bufbuild/protobuf/wkt";
import { file_google_protobuf_timestamp } from "@bufbuild/protobuf/wkt";
import type { Message } from "@bufbuild/protobuf";

/**
 * Describes the file auth/v2/token.proto.
 */
export const file_auth_v2_token: GenFile = /*@__PURE__*/
  fileDesc("ChNhdXRoL3YyL3Rva2VuLnByb3RvEgdhdXRoLnYyIqQBCglBdXRoVG9rZW4SFAoMYWNjZXNzX3Rva2VuGAEgASgJEhUKDXJlZnJlc2hfdG9rZW4YAiABKAkSLgoKZXhwaXJlc19hdBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXASJgoKdG9rZW5fdHlwZRgEIAEoDjISLmF1dGgudjIuVG9rZW5UeXBlEhIKCnNlc3Npb25faWQYBSABKAkqPgoJVG9rZW5UeXBlEhoKFlRPS0VOX1RZUEVfVU5TUEVDSUZJRUQQABIVChFUT0tFTl9UWVBFX0JFQVJFUhABQpIBCgtjb20uYXV0aC52MkIKVG9rZW5Qcm90b1ABWjpnaXRodWIuY29tL3Nwb3VuZ2UtYWkvc3BvdW5nZS1wcm90b3MvZ2VuL2dvL2F1dGgvdjI7YXV0aHYyogIDQVhYqgIHQXV0aC5WMsoCB0F1dGhcVjLiAhNBdXRoXFYyXEdQQk1ldGFkYXRh6gIIQXV0aDo6VjJiBnByb3RvMw", [file_google_protobuf_timestamp]);

/**
 * @generated from message auth.v2.AuthToken
 */
export type AuthToken = Message<"auth.v2.AuthToken"> & {
  /**
   * @generated from field: string access_token = 1;
   */
  accessToken: string;

  /**
   * @generated from field: string refresh_token = 2;
   */
  refreshToken: string;

  /**
   * @generated from field: google.protobuf.Timestamp expires_at = 3;
   */
  expiresAt?: Timestamp;

  /**
   * @generated from field: auth.v2.TokenType token_type = 4;
   */
  tokenType: TokenType;

  /**
   * @generated from field: string session_id = 5;
   */
  sessionId: string;
};

/**
 * Describes the message auth.v2.AuthToken.
 * Use `create(AuthTokenSchema)` to create a new message.
 */
export const AuthTokenSchema: GenMessage<AuthToken> = /*@__PURE__*/
  messageDesc(file_auth_v2_token, 0);

/**
 * @generated from enum auth.v2.TokenType
 */
export enum TokenType {
  /**
   * @generated from enum value: TOKEN_TYPE_UNSPECIFIED = 0;
   */
  UNSPECIFIED = 0,

  /**
   * @generated from enum value: TOKEN_TYPE_BEARER = 1;
   */
  BEARER = 1,
}

/**
 * Describes the enum auth.v2.TokenType.
 */
export const TokenTypeSchema: GenEnum<TokenType> = /*@__PURE__*/
  enumDesc(file_auth_v2_token, 0);


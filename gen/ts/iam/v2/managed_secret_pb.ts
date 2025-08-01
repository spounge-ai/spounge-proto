// @generated by protoc-gen-es v2.6.2 with parameter "target=ts,import_extension=none"
// @generated from file iam/v2/managed_secret.proto (package iam.v2, syntax proto3)
/* eslint-disable */

import type { GenEnum, GenFile, GenMessage } from "@bufbuild/protobuf/codegenv2";
import { enumDesc, fileDesc, messageDesc } from "@bufbuild/protobuf/codegenv2";
import type { Timestamp } from "@bufbuild/protobuf/wkt";
import { file_google_protobuf_struct, file_google_protobuf_timestamp } from "@bufbuild/protobuf/wkt";
import type { JsonObject, Message } from "@bufbuild/protobuf";

/**
 * Describes the file iam/v2/managed_secret.proto.
 */
export const file_iam_v2_managed_secret: GenFile = /*@__PURE__*/
  fileDesc("ChtpYW0vdjIvbWFuYWdlZF9zZWNyZXQucHJvdG8SBmlhbS52MiK0AgoNTWFuYWdlZFNlY3JldBIKCgJpZBgBIAEoCRIPCgd1c2VyX2lkGAIgASgJEgwKBG5hbWUYAyABKAkSJwoEdHlwZRgEIAEoDjIZLmlhbS52Mi5NYW5hZ2VkU2VjcmV0VHlwZRIuCgpjcmVhdGVkX2F0GAUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcBIuCgp1cGRhdGVkX2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcBIyCg9jb2xsZWN0aW9uX2RhdGEYByABKAsyFy5nb29nbGUucHJvdG9idWYuU3RydWN0SAASLAoJaXRlbV9kYXRhGAggASgLMhcuZ29vZ2xlLnByb3RvYnVmLlN0cnVjdEgAQg0KC3NlY3JldF9kYXRhKpoBChFNYW5hZ2VkU2VjcmV0VHlwZRIjCh9NQU5BR0VEX1NFQ1JFVF9UWVBFX1VOU1BFQ0lGSUVEEAASHgoaTUFOQUdFRF9TRUNSRVRfVFlQRV9DVVNUT00QARIcChhNQU5BR0VEX1NFQ1JFVF9UWVBFX0lURU0QAhIiCh5NQU5BR0VEX1NFQ1JFVF9UWVBFX0NPTExFQ1RJT04QA0KTAQoKY29tLmlhbS52MkISTWFuYWdlZFNlY3JldFByb3RvUAFaOGdpdGh1Yi5jb20vc3BvdW5nZS1haS9zcG91bmdlLXByb3Rvcy9nZW4vZ28vaWFtL3YyO2lhbXYyogIDSVhYqgIGSWFtLlYyygIGSWFtXFYy4gISSWFtXFYyXEdQQk1ldGFkYXRh6gIHSWFtOjpWMmIGcHJvdG8z", [file_google_protobuf_timestamp, file_google_protobuf_struct]);

/**
 * @generated from message iam.v2.ManagedSecret
 */
export type ManagedSecret = Message<"iam.v2.ManagedSecret"> & {
  /**
   * @generated from field: string id = 1;
   */
  id: string;

  /**
   * @generated from field: string user_id = 2;
   */
  userId: string;

  /**
   * @generated from field: string name = 3;
   */
  name: string;

  /**
   * @generated from field: iam.v2.ManagedSecretType type = 4;
   */
  type: ManagedSecretType;

  /**
   * @generated from field: google.protobuf.Timestamp created_at = 5;
   */
  createdAt?: Timestamp;

  /**
   * @generated from field: google.protobuf.Timestamp updated_at = 6;
   */
  updatedAt?: Timestamp;

  /**
   * @generated from oneof iam.v2.ManagedSecret.secret_data
   */
  secretData: {
    /**
     * @generated from field: google.protobuf.Struct collection_data = 7;
     */
    value: JsonObject;
    case: "collectionData";
  } | {
    /**
     * @generated from field: google.protobuf.Struct item_data = 8;
     */
    value: JsonObject;
    case: "itemData";
  } | { case: undefined; value?: undefined };
};

/**
 * Describes the message iam.v2.ManagedSecret.
 * Use `create(ManagedSecretSchema)` to create a new message.
 */
export const ManagedSecretSchema: GenMessage<ManagedSecret> = /*@__PURE__*/
  messageDesc(file_iam_v2_managed_secret, 0);

/**
 * @generated from enum iam.v2.ManagedSecretType
 */
export enum ManagedSecretType {
  /**
   * @generated from enum value: MANAGED_SECRET_TYPE_UNSPECIFIED = 0;
   */
  UNSPECIFIED = 0,

  /**
   * @generated from enum value: MANAGED_SECRET_TYPE_CUSTOM = 1;
   */
  CUSTOM = 1,

  /**
   * @generated from enum value: MANAGED_SECRET_TYPE_ITEM = 2;
   */
  ITEM = 2,

  /**
   * @generated from enum value: MANAGED_SECRET_TYPE_COLLECTION = 3;
   */
  COLLECTION = 3,
}

/**
 * Describes the enum iam.v2.ManagedSecretType.
 */
export const ManagedSecretTypeSchema: GenEnum<ManagedSecretType> = /*@__PURE__*/
  enumDesc(file_iam_v2_managed_secret, 0);


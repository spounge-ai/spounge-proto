# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# NO CHECKED-IN PROTOBUF GENCODE
# source: vector_db/v2/vector_db.proto
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
    'vector_db/v2/vector_db.proto'
)
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()


from spounge.common.v2 import common_pb2 as common_dot_v2_dot_common__pb2
from google.protobuf import struct_pb2 as google_dot_protobuf_dot_struct__pb2


DESCRIPTOR = _descriptor_pool.Default().AddSerializedFile(b'\n\x1cvector_db/v2/vector_db.proto\x12\x0cvector_db.v2\x1a\x16\x63ommon/v2/common.proto\x1a\x1cgoogle/protobuf/struct.proto\"e\n\x06Vector\x12\x0e\n\x02id\x18\x01 \x01(\tR\x02id\x12\x16\n\x06values\x18\x02 \x03(\x02R\x06values\x12\x33\n\x08metadata\x18\x03 \x01(\x0b\x32\x17.google.protobuf.StructR\x08metadata\"h\n\x0bQueryResult\x12\x0e\n\x02id\x18\x01 \x01(\tR\x02id\x12\x14\n\x05score\x18\x02 \x01(\x02R\x05score\x12\x33\n\x08metadata\x18\x03 \x01(\x0b\x32\x17.google.protobuf.StructR\x08metadata\"h\n\rUpsertRequest\x12\'\n\x0f\x63ollection_name\x18\x01 \x01(\tR\x0e\x63ollectionName\x12.\n\x07vectors\x18\x02 \x03(\x0b\x32\x14.vector_db.v2.VectorR\x07vectors\"b\n\x0eUpsertResponse\x12)\n\x06status\x18\x01 \x01(\x0b\x32\x11.common.v2.StatusR\x06status\x12%\n\x0eupserted_count\x18\x02 \x01(\x05R\rupsertedCount\"\xb0\x01\n\x0cQueryRequest\x12\'\n\x0f\x63ollection_name\x18\x01 \x01(\tR\x0e\x63ollectionName\x12!\n\x0cquery_vector\x18\x02 \x03(\x02R\x0bqueryVector\x12\x13\n\x05top_k\x18\x03 \x01(\x05R\x04topK\x12\x34\n\x06\x66ilter\x18\x04 \x01(\x0b\x32\x17.google.protobuf.StructH\x00R\x06\x66ilter\x88\x01\x01\x42\t\n\x07_filter\"o\n\rQueryResponse\x12)\n\x06status\x18\x01 \x01(\x0b\x32\x11.common.v2.StatusR\x06status\x12\x33\n\x07results\x18\x02 \x03(\x0b\x32\x19.vector_db.v2.QueryResultR\x07results2\x9c\x01\n\x0fVectorDBService\x12\x45\n\x06Upsert\x12\x1b.vector_db.v2.UpsertRequest\x1a\x1c.vector_db.v2.UpsertResponse\"\x00\x12\x42\n\x05Query\x12\x1a.vector_db.v2.QueryRequest\x1a\x1b.vector_db.v2.QueryResponse\"\x00\x42\xb3\x01\n\x10\x63om.vector_db.v2B\rVectorDbProtoP\x01ZCgithub.com/spounge-ai/spounge-protos/gen/go/vector_db/v2;vectordbv2\xa2\x02\x03VXX\xaa\x02\x0bVectorDb.V2\xca\x02\x0bVectorDb\\V2\xe2\x02\x17VectorDb\\V2\\GPBMetadata\xea\x02\x0cVectorDb::V2b\x06proto3')

_globals = globals()
_builder.BuildMessageAndEnumDescriptors(DESCRIPTOR, _globals)
_builder.BuildTopDescriptorsAndMessages(DESCRIPTOR, 'vector_db.v2.vector_db_pb2', _globals)
if not _descriptor._USE_C_DESCRIPTORS:
  _globals['DESCRIPTOR']._loaded_options = None
  _globals['DESCRIPTOR']._serialized_options = b'\n\020com.vector_db.v2B\rVectorDbProtoP\001ZCgithub.com/spounge-ai/spounge-protos/gen/go/vector_db/v2;vectordbv2\242\002\003VXX\252\002\013VectorDb.V2\312\002\013VectorDb\\V2\342\002\027VectorDb\\V2\\GPBMetadata\352\002\014VectorDb::V2'
  _globals['_VECTOR']._serialized_start=100
  _globals['_VECTOR']._serialized_end=201
  _globals['_QUERYRESULT']._serialized_start=203
  _globals['_QUERYRESULT']._serialized_end=307
  _globals['_UPSERTREQUEST']._serialized_start=309
  _globals['_UPSERTREQUEST']._serialized_end=413
  _globals['_UPSERTRESPONSE']._serialized_start=415
  _globals['_UPSERTRESPONSE']._serialized_end=513
  _globals['_QUERYREQUEST']._serialized_start=516
  _globals['_QUERYREQUEST']._serialized_end=692
  _globals['_QUERYRESPONSE']._serialized_start=694
  _globals['_QUERYRESPONSE']._serialized_end=805
  _globals['_VECTORDBSERVICE']._serialized_start=808
  _globals['_VECTORDBSERVICE']._serialized_end=964
# @@protoc_insertion_point(module_scope)

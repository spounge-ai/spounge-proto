// Copyright 2025 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.36.6
// 	protoc        (unknown)
// source: google/api/expr/v1beta1/source.proto

package exprv1beta1

import (
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	reflect "reflect"
	sync "sync"
	unsafe "unsafe"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

// Source information collected at parse time.
type SourceInfo struct {
	state protoimpl.MessageState `protogen:"open.v1"`
	// The location name. All position information attached to an expression is
	// relative to this location.
	//
	// The location could be a file, UI element, or similar. For example,
	// `acme/app/AnvilPolicy.cel`.
	Location string `protobuf:"bytes,2,opt,name=location,proto3" json:"location,omitempty"`
	// Monotonically increasing list of character offsets where newlines appear.
	//
	// The line number of a given position is the index `i` where for a given
	// `id` the `line_offsets[i] < id_positions[id] < line_offsets[i+1]`. The
	// column may be derivd from `id_positions[id] - line_offsets[i]`.
	LineOffsets []int32 `protobuf:"varint,3,rep,packed,name=line_offsets,json=lineOffsets,proto3" json:"line_offsets,omitempty"`
	// A map from the parse node id (e.g. `Expr.id`) to the character offset
	// within source.
	Positions     map[int32]int32 `protobuf:"bytes,4,rep,name=positions,proto3" json:"positions,omitempty" protobuf_key:"varint,1,opt,name=key" protobuf_val:"varint,2,opt,name=value"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *SourceInfo) Reset() {
	*x = SourceInfo{}
	mi := &file_google_api_expr_v1beta1_source_proto_msgTypes[0]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *SourceInfo) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*SourceInfo) ProtoMessage() {}

func (x *SourceInfo) ProtoReflect() protoreflect.Message {
	mi := &file_google_api_expr_v1beta1_source_proto_msgTypes[0]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use SourceInfo.ProtoReflect.Descriptor instead.
func (*SourceInfo) Descriptor() ([]byte, []int) {
	return file_google_api_expr_v1beta1_source_proto_rawDescGZIP(), []int{0}
}

func (x *SourceInfo) GetLocation() string {
	if x != nil {
		return x.Location
	}
	return ""
}

func (x *SourceInfo) GetLineOffsets() []int32 {
	if x != nil {
		return x.LineOffsets
	}
	return nil
}

func (x *SourceInfo) GetPositions() map[int32]int32 {
	if x != nil {
		return x.Positions
	}
	return nil
}

// A specific position in source.
type SourcePosition struct {
	state protoimpl.MessageState `protogen:"open.v1"`
	// The soucre location name (e.g. file name).
	Location string `protobuf:"bytes,1,opt,name=location,proto3" json:"location,omitempty"`
	// The character offset.
	Offset int32 `protobuf:"varint,2,opt,name=offset,proto3" json:"offset,omitempty"`
	// The 1-based index of the starting line in the source text
	// where the issue occurs, or 0 if unknown.
	Line int32 `protobuf:"varint,3,opt,name=line,proto3" json:"line,omitempty"`
	// The 0-based index of the starting position within the line of source text
	// where the issue occurs.  Only meaningful if line is nonzer..
	Column        int32 `protobuf:"varint,4,opt,name=column,proto3" json:"column,omitempty"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *SourcePosition) Reset() {
	*x = SourcePosition{}
	mi := &file_google_api_expr_v1beta1_source_proto_msgTypes[1]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *SourcePosition) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*SourcePosition) ProtoMessage() {}

func (x *SourcePosition) ProtoReflect() protoreflect.Message {
	mi := &file_google_api_expr_v1beta1_source_proto_msgTypes[1]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use SourcePosition.ProtoReflect.Descriptor instead.
func (*SourcePosition) Descriptor() ([]byte, []int) {
	return file_google_api_expr_v1beta1_source_proto_rawDescGZIP(), []int{1}
}

func (x *SourcePosition) GetLocation() string {
	if x != nil {
		return x.Location
	}
	return ""
}

func (x *SourcePosition) GetOffset() int32 {
	if x != nil {
		return x.Offset
	}
	return 0
}

func (x *SourcePosition) GetLine() int32 {
	if x != nil {
		return x.Line
	}
	return 0
}

func (x *SourcePosition) GetColumn() int32 {
	if x != nil {
		return x.Column
	}
	return 0
}

var File_google_api_expr_v1beta1_source_proto protoreflect.FileDescriptor

const file_google_api_expr_v1beta1_source_proto_rawDesc = "" +
	"\n" +
	"$google/api/expr/v1beta1/source.proto\x12\x17google.api.expr.v1beta1\"\xdb\x01\n" +
	"\n" +
	"SourceInfo\x12\x1a\n" +
	"\blocation\x18\x02 \x01(\tR\blocation\x12!\n" +
	"\fline_offsets\x18\x03 \x03(\x05R\vlineOffsets\x12P\n" +
	"\tpositions\x18\x04 \x03(\v22.google.api.expr.v1beta1.SourceInfo.PositionsEntryR\tpositions\x1a<\n" +
	"\x0ePositionsEntry\x12\x10\n" +
	"\x03key\x18\x01 \x01(\x05R\x03key\x12\x14\n" +
	"\x05value\x18\x02 \x01(\x05R\x05value:\x028\x01\"p\n" +
	"\x0eSourcePosition\x12\x1a\n" +
	"\blocation\x18\x01 \x01(\tR\blocation\x12\x16\n" +
	"\x06offset\x18\x02 \x01(\x05R\x06offset\x12\x12\n" +
	"\x04line\x18\x03 \x01(\x05R\x04line\x12\x16\n" +
	"\x06column\x18\x04 \x01(\x05R\x06columnB\xfc\x01\n" +
	"\x1bcom.google.api.expr.v1beta1B\vSourceProtoP\x01ZNgithub.com/spounge-ai/spounge-proto/gen/go/google/api/expr/v1beta1;exprv1beta1\xf8\x01\x01\xa2\x02\x03GAE\xaa\x02\x17Google.Api.Expr.V1beta1\xca\x02\x17Google\\Api\\Expr\\V1beta1\xe2\x02#Google\\Api\\Expr\\V1beta1\\GPBMetadata\xea\x02\x1aGoogle::Api::Expr::V1beta1b\x06proto3"

var (
	file_google_api_expr_v1beta1_source_proto_rawDescOnce sync.Once
	file_google_api_expr_v1beta1_source_proto_rawDescData []byte
)

func file_google_api_expr_v1beta1_source_proto_rawDescGZIP() []byte {
	file_google_api_expr_v1beta1_source_proto_rawDescOnce.Do(func() {
		file_google_api_expr_v1beta1_source_proto_rawDescData = protoimpl.X.CompressGZIP(unsafe.Slice(unsafe.StringData(file_google_api_expr_v1beta1_source_proto_rawDesc), len(file_google_api_expr_v1beta1_source_proto_rawDesc)))
	})
	return file_google_api_expr_v1beta1_source_proto_rawDescData
}

var file_google_api_expr_v1beta1_source_proto_msgTypes = make([]protoimpl.MessageInfo, 3)
var file_google_api_expr_v1beta1_source_proto_goTypes = []any{
	(*SourceInfo)(nil),     // 0: google.api.expr.v1beta1.SourceInfo
	(*SourcePosition)(nil), // 1: google.api.expr.v1beta1.SourcePosition
	nil,                    // 2: google.api.expr.v1beta1.SourceInfo.PositionsEntry
}
var file_google_api_expr_v1beta1_source_proto_depIdxs = []int32{
	2, // 0: google.api.expr.v1beta1.SourceInfo.positions:type_name -> google.api.expr.v1beta1.SourceInfo.PositionsEntry
	1, // [1:1] is the sub-list for method output_type
	1, // [1:1] is the sub-list for method input_type
	1, // [1:1] is the sub-list for extension type_name
	1, // [1:1] is the sub-list for extension extendee
	0, // [0:1] is the sub-list for field type_name
}

func init() { file_google_api_expr_v1beta1_source_proto_init() }
func file_google_api_expr_v1beta1_source_proto_init() {
	if File_google_api_expr_v1beta1_source_proto != nil {
		return
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: unsafe.Slice(unsafe.StringData(file_google_api_expr_v1beta1_source_proto_rawDesc), len(file_google_api_expr_v1beta1_source_proto_rawDesc)),
			NumEnums:      0,
			NumMessages:   3,
			NumExtensions: 0,
			NumServices:   0,
		},
		GoTypes:           file_google_api_expr_v1beta1_source_proto_goTypes,
		DependencyIndexes: file_google_api_expr_v1beta1_source_proto_depIdxs,
		MessageInfos:      file_google_api_expr_v1beta1_source_proto_msgTypes,
	}.Build()
	File_google_api_expr_v1beta1_source_proto = out.File
	file_google_api_expr_v1beta1_source_proto_goTypes = nil
	file_google_api_expr_v1beta1_source_proto_depIdxs = nil
}

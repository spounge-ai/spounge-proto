// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.36.6
// 	protoc        (unknown)
// source: workflow/v2/workflow.proto

package workflowv2

import (
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	structpb "google.golang.org/protobuf/types/known/structpb"
	timestamppb "google.golang.org/protobuf/types/known/timestamppb"
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

type WorkflowConfig struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	Id            string                 `protobuf:"bytes,1,opt,name=id,proto3" json:"id,omitempty"`
	UserId        string                 `protobuf:"bytes,2,opt,name=user_id,json=userId,proto3" json:"user_id,omitempty"`
	Name          string                 `protobuf:"bytes,3,opt,name=name,proto3" json:"name,omitempty"`
	Description   *string                `protobuf:"bytes,4,opt,name=description,proto3,oneof" json:"description,omitempty"`
	Version       int32                  `protobuf:"varint,5,opt,name=version,proto3" json:"version,omitempty"`
	Steps         []*WorkflowStep        `protobuf:"bytes,6,rep,name=steps,proto3" json:"steps,omitempty"`
	CreatedAt     *timestamppb.Timestamp `protobuf:"bytes,7,opt,name=created_at,json=createdAt,proto3" json:"created_at,omitempty"`
	UpdatedAt     *timestamppb.Timestamp `protobuf:"bytes,8,opt,name=updated_at,json=updatedAt,proto3" json:"updated_at,omitempty"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *WorkflowConfig) Reset() {
	*x = WorkflowConfig{}
	mi := &file_workflow_v2_workflow_proto_msgTypes[0]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *WorkflowConfig) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*WorkflowConfig) ProtoMessage() {}

func (x *WorkflowConfig) ProtoReflect() protoreflect.Message {
	mi := &file_workflow_v2_workflow_proto_msgTypes[0]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use WorkflowConfig.ProtoReflect.Descriptor instead.
func (*WorkflowConfig) Descriptor() ([]byte, []int) {
	return file_workflow_v2_workflow_proto_rawDescGZIP(), []int{0}
}

func (x *WorkflowConfig) GetId() string {
	if x != nil {
		return x.Id
	}
	return ""
}

func (x *WorkflowConfig) GetUserId() string {
	if x != nil {
		return x.UserId
	}
	return ""
}

func (x *WorkflowConfig) GetName() string {
	if x != nil {
		return x.Name
	}
	return ""
}

func (x *WorkflowConfig) GetDescription() string {
	if x != nil && x.Description != nil {
		return *x.Description
	}
	return ""
}

func (x *WorkflowConfig) GetVersion() int32 {
	if x != nil {
		return x.Version
	}
	return 0
}

func (x *WorkflowConfig) GetSteps() []*WorkflowStep {
	if x != nil {
		return x.Steps
	}
	return nil
}

func (x *WorkflowConfig) GetCreatedAt() *timestamppb.Timestamp {
	if x != nil {
		return x.CreatedAt
	}
	return nil
}

func (x *WorkflowConfig) GetUpdatedAt() *timestamppb.Timestamp {
	if x != nil {
		return x.UpdatedAt
	}
	return nil
}

type WorkflowStep struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	Id            string                 `protobuf:"bytes,1,opt,name=id,proto3" json:"id,omitempty"`
	Name          string                 `protobuf:"bytes,2,opt,name=name,proto3" json:"name,omitempty"`
	Description   *string                `protobuf:"bytes,3,opt,name=description,proto3,oneof" json:"description,omitempty"`
	ToolName      string                 `protobuf:"bytes,4,opt,name=tool_name,json=toolName,proto3" json:"tool_name,omitempty"`
	Parameters    *structpb.Struct       `protobuf:"bytes,5,opt,name=parameters,proto3" json:"parameters,omitempty"`
	DependsOn     []string               `protobuf:"bytes,6,rep,name=depends_on,json=dependsOn,proto3" json:"depends_on,omitempty"`
	SecretId      *string                `protobuf:"bytes,7,opt,name=secret_id,json=secretId,proto3,oneof" json:"secret_id,omitempty"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *WorkflowStep) Reset() {
	*x = WorkflowStep{}
	mi := &file_workflow_v2_workflow_proto_msgTypes[1]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *WorkflowStep) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*WorkflowStep) ProtoMessage() {}

func (x *WorkflowStep) ProtoReflect() protoreflect.Message {
	mi := &file_workflow_v2_workflow_proto_msgTypes[1]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use WorkflowStep.ProtoReflect.Descriptor instead.
func (*WorkflowStep) Descriptor() ([]byte, []int) {
	return file_workflow_v2_workflow_proto_rawDescGZIP(), []int{1}
}

func (x *WorkflowStep) GetId() string {
	if x != nil {
		return x.Id
	}
	return ""
}

func (x *WorkflowStep) GetName() string {
	if x != nil {
		return x.Name
	}
	return ""
}

func (x *WorkflowStep) GetDescription() string {
	if x != nil && x.Description != nil {
		return *x.Description
	}
	return ""
}

func (x *WorkflowStep) GetToolName() string {
	if x != nil {
		return x.ToolName
	}
	return ""
}

func (x *WorkflowStep) GetParameters() *structpb.Struct {
	if x != nil {
		return x.Parameters
	}
	return nil
}

func (x *WorkflowStep) GetDependsOn() []string {
	if x != nil {
		return x.DependsOn
	}
	return nil
}

func (x *WorkflowStep) GetSecretId() string {
	if x != nil && x.SecretId != nil {
		return *x.SecretId
	}
	return ""
}

var File_workflow_v2_workflow_proto protoreflect.FileDescriptor

const file_workflow_v2_workflow_proto_rawDesc = "" +
	"\n" +
	"\x1aworkflow/v2/workflow.proto\x12\vworkflow.v2\x1a\x1cgoogle/protobuf/struct.proto\x1a\x1fgoogle/protobuf/timestamp.proto\"\xc5\x02\n" +
	"\x0eWorkflowConfig\x12\x0e\n" +
	"\x02id\x18\x01 \x01(\tR\x02id\x12\x17\n" +
	"\auser_id\x18\x02 \x01(\tR\x06userId\x12\x12\n" +
	"\x04name\x18\x03 \x01(\tR\x04name\x12%\n" +
	"\vdescription\x18\x04 \x01(\tH\x00R\vdescription\x88\x01\x01\x12\x18\n" +
	"\aversion\x18\x05 \x01(\x05R\aversion\x12/\n" +
	"\x05steps\x18\x06 \x03(\v2\x19.workflow.v2.WorkflowStepR\x05steps\x129\n" +
	"\n" +
	"created_at\x18\a \x01(\v2\x1a.google.protobuf.TimestampR\tcreatedAt\x129\n" +
	"\n" +
	"updated_at\x18\b \x01(\v2\x1a.google.protobuf.TimestampR\tupdatedAtB\x0e\n" +
	"\f_description\"\x8e\x02\n" +
	"\fWorkflowStep\x12\x0e\n" +
	"\x02id\x18\x01 \x01(\tR\x02id\x12\x12\n" +
	"\x04name\x18\x02 \x01(\tR\x04name\x12%\n" +
	"\vdescription\x18\x03 \x01(\tH\x00R\vdescription\x88\x01\x01\x12\x1b\n" +
	"\ttool_name\x18\x04 \x01(\tR\btoolName\x127\n" +
	"\n" +
	"parameters\x18\x05 \x01(\v2\x17.google.protobuf.StructR\n" +
	"parameters\x12\x1d\n" +
	"\n" +
	"depends_on\x18\x06 \x03(\tR\tdependsOn\x12 \n" +
	"\tsecret_id\x18\a \x01(\tH\x01R\bsecretId\x88\x01\x01B\x0e\n" +
	"\f_descriptionB\f\n" +
	"\n" +
	"_secret_idB\xb0\x01\n" +
	"\x0fcom.workflow.v2B\rWorkflowProtoP\x01ZAgithub.com/spounge-ai/spounge-proto/gen/go/workflow/v2;workflowv2\xa2\x02\x03WXX\xaa\x02\vWorkflow.V2\xca\x02\vWorkflow\\V2\xe2\x02\x17Workflow\\V2\\GPBMetadata\xea\x02\fWorkflow::V2b\x06proto3"

var (
	file_workflow_v2_workflow_proto_rawDescOnce sync.Once
	file_workflow_v2_workflow_proto_rawDescData []byte
)

func file_workflow_v2_workflow_proto_rawDescGZIP() []byte {
	file_workflow_v2_workflow_proto_rawDescOnce.Do(func() {
		file_workflow_v2_workflow_proto_rawDescData = protoimpl.X.CompressGZIP(unsafe.Slice(unsafe.StringData(file_workflow_v2_workflow_proto_rawDesc), len(file_workflow_v2_workflow_proto_rawDesc)))
	})
	return file_workflow_v2_workflow_proto_rawDescData
}

var file_workflow_v2_workflow_proto_msgTypes = make([]protoimpl.MessageInfo, 2)
var file_workflow_v2_workflow_proto_goTypes = []any{
	(*WorkflowConfig)(nil),        // 0: workflow.v2.WorkflowConfig
	(*WorkflowStep)(nil),          // 1: workflow.v2.WorkflowStep
	(*timestamppb.Timestamp)(nil), // 2: google.protobuf.Timestamp
	(*structpb.Struct)(nil),       // 3: google.protobuf.Struct
}
var file_workflow_v2_workflow_proto_depIdxs = []int32{
	1, // 0: workflow.v2.WorkflowConfig.steps:type_name -> workflow.v2.WorkflowStep
	2, // 1: workflow.v2.WorkflowConfig.created_at:type_name -> google.protobuf.Timestamp
	2, // 2: workflow.v2.WorkflowConfig.updated_at:type_name -> google.protobuf.Timestamp
	3, // 3: workflow.v2.WorkflowStep.parameters:type_name -> google.protobuf.Struct
	4, // [4:4] is the sub-list for method output_type
	4, // [4:4] is the sub-list for method input_type
	4, // [4:4] is the sub-list for extension type_name
	4, // [4:4] is the sub-list for extension extendee
	0, // [0:4] is the sub-list for field type_name
}

func init() { file_workflow_v2_workflow_proto_init() }
func file_workflow_v2_workflow_proto_init() {
	if File_workflow_v2_workflow_proto != nil {
		return
	}
	file_workflow_v2_workflow_proto_msgTypes[0].OneofWrappers = []any{}
	file_workflow_v2_workflow_proto_msgTypes[1].OneofWrappers = []any{}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: unsafe.Slice(unsafe.StringData(file_workflow_v2_workflow_proto_rawDesc), len(file_workflow_v2_workflow_proto_rawDesc)),
			NumEnums:      0,
			NumMessages:   2,
			NumExtensions: 0,
			NumServices:   0,
		},
		GoTypes:           file_workflow_v2_workflow_proto_goTypes,
		DependencyIndexes: file_workflow_v2_workflow_proto_depIdxs,
		MessageInfos:      file_workflow_v2_workflow_proto_msgTypes,
	}.Build()
	File_workflow_v2_workflow_proto = out.File
	file_workflow_v2_workflow_proto_goTypes = nil
	file_workflow_v2_workflow_proto_depIdxs = nil
}

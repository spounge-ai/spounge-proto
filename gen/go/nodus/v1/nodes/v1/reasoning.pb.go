// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.36.6
// 	protoc        (unknown)
// source: nodus/v1/nodes/v1/reasoning.proto

package nodesv1

import (
	v11 "github.com/spounge-ai/spounge-proto/gen/go/nodus/v1/common/v1"
	v1 "github.com/spounge-ai/spounge-proto/gen/go/nodus/v1/integrations/v1"
	v12 "github.com/spounge-ai/spounge-proto/gen/go/nodus/v1/mcp/v1"
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	durationpb "google.golang.org/protobuf/types/known/durationpb"
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

type ReasoningNodeConfig struct {
	state               protoimpl.MessageState `protogen:"open.v1"`
	LlmConfig           *v1.LLMConfiguration   `protobuf:"bytes,1,opt,name=llm_config,json=llmConfig,proto3" json:"llm_config,omitempty"`
	ModelParameters     *v1.LLMParameters      `protobuf:"bytes,3,opt,name=model_parameters,json=modelParameters,proto3" json:"model_parameters,omitempty"`
	SystemPrompt        string                 `protobuf:"bytes,4,opt,name=system_prompt,json=systemPrompt,proto3" json:"system_prompt,omitempty"`
	UserPrompt          string                 `protobuf:"bytes,5,opt,name=user_prompt,json=userPrompt,proto3" json:"user_prompt,omitempty"`
	ConversationHistory []*v11.ChatMessage     `protobuf:"bytes,6,rep,name=conversation_history,json=conversationHistory,proto3" json:"conversation_history,omitempty"`
	ToolScope           *v12.ToolScope         `protobuf:"bytes,7,opt,name=tool_scope,json=toolScope,proto3" json:"tool_scope,omitempty"`
	AllowedTools        []string               `protobuf:"bytes,8,rep,name=allowed_tools,json=allowedTools,proto3" json:"allowed_tools,omitempty"`
	ForbiddenTools      []string               `protobuf:"bytes,9,rep,name=forbidden_tools,json=forbiddenTools,proto3" json:"forbidden_tools,omitempty"`
	ReasoningTimeout    *durationpb.Duration   `protobuf:"bytes,11,opt,name=reasoning_timeout,json=reasoningTimeout,proto3" json:"reasoning_timeout,omitempty"`
	RequireToolUse      bool                   `protobuf:"varint,12,opt,name=require_tool_use,json=requireToolUse,proto3" json:"require_tool_use,omitempty"`
	Options             *ReasoningOptions      `protobuf:"bytes,13,opt,name=options,proto3" json:"options,omitempty"`
	unknownFields       protoimpl.UnknownFields
	sizeCache           protoimpl.SizeCache
}

func (x *ReasoningNodeConfig) Reset() {
	*x = ReasoningNodeConfig{}
	mi := &file_nodus_v1_nodes_v1_reasoning_proto_msgTypes[0]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *ReasoningNodeConfig) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ReasoningNodeConfig) ProtoMessage() {}

func (x *ReasoningNodeConfig) ProtoReflect() protoreflect.Message {
	mi := &file_nodus_v1_nodes_v1_reasoning_proto_msgTypes[0]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ReasoningNodeConfig.ProtoReflect.Descriptor instead.
func (*ReasoningNodeConfig) Descriptor() ([]byte, []int) {
	return file_nodus_v1_nodes_v1_reasoning_proto_rawDescGZIP(), []int{0}
}

func (x *ReasoningNodeConfig) GetLlmConfig() *v1.LLMConfiguration {
	if x != nil {
		return x.LlmConfig
	}
	return nil
}

func (x *ReasoningNodeConfig) GetModelParameters() *v1.LLMParameters {
	if x != nil {
		return x.ModelParameters
	}
	return nil
}

func (x *ReasoningNodeConfig) GetSystemPrompt() string {
	if x != nil {
		return x.SystemPrompt
	}
	return ""
}

func (x *ReasoningNodeConfig) GetUserPrompt() string {
	if x != nil {
		return x.UserPrompt
	}
	return ""
}

func (x *ReasoningNodeConfig) GetConversationHistory() []*v11.ChatMessage {
	if x != nil {
		return x.ConversationHistory
	}
	return nil
}

func (x *ReasoningNodeConfig) GetToolScope() *v12.ToolScope {
	if x != nil {
		return x.ToolScope
	}
	return nil
}

func (x *ReasoningNodeConfig) GetAllowedTools() []string {
	if x != nil {
		return x.AllowedTools
	}
	return nil
}

func (x *ReasoningNodeConfig) GetForbiddenTools() []string {
	if x != nil {
		return x.ForbiddenTools
	}
	return nil
}

func (x *ReasoningNodeConfig) GetReasoningTimeout() *durationpb.Duration {
	if x != nil {
		return x.ReasoningTimeout
	}
	return nil
}

func (x *ReasoningNodeConfig) GetRequireToolUse() bool {
	if x != nil {
		return x.RequireToolUse
	}
	return false
}

func (x *ReasoningNodeConfig) GetOptions() *ReasoningOptions {
	if x != nil {
		return x.Options
	}
	return nil
}

type ReasoningOptions struct {
	state                   protoimpl.MessageState `protogen:"open.v1"`
	EnableChainOfThought    bool                   `protobuf:"varint,1,opt,name=enable_chain_of_thought,json=enableChainOfThought,proto3" json:"enable_chain_of_thought,omitempty"`
	IncludeReasoningTrace   bool                   `protobuf:"varint,2,opt,name=include_reasoning_trace,json=includeReasoningTrace,proto3" json:"include_reasoning_trace,omitempty"`
	TemperatureOverride     float32                `protobuf:"fixed32,3,opt,name=temperature_override,json=temperatureOverride,proto3" json:"temperature_override,omitempty"`
	ValidateToolOutputs     bool                   `protobuf:"varint,4,opt,name=validate_tool_outputs,json=validateToolOutputs,proto3" json:"validate_tool_outputs,omitempty"`
	OutputFormatInstruction string                 `protobuf:"bytes,5,opt,name=output_format_instruction,json=outputFormatInstruction,proto3" json:"output_format_instruction,omitempty"`
	RequiredOutputFields    []string               `protobuf:"bytes,6,rep,name=required_output_fields,json=requiredOutputFields,proto3" json:"required_output_fields,omitempty"`
	unknownFields           protoimpl.UnknownFields
	sizeCache               protoimpl.SizeCache
}

func (x *ReasoningOptions) Reset() {
	*x = ReasoningOptions{}
	mi := &file_nodus_v1_nodes_v1_reasoning_proto_msgTypes[1]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *ReasoningOptions) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ReasoningOptions) ProtoMessage() {}

func (x *ReasoningOptions) ProtoReflect() protoreflect.Message {
	mi := &file_nodus_v1_nodes_v1_reasoning_proto_msgTypes[1]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ReasoningOptions.ProtoReflect.Descriptor instead.
func (*ReasoningOptions) Descriptor() ([]byte, []int) {
	return file_nodus_v1_nodes_v1_reasoning_proto_rawDescGZIP(), []int{1}
}

func (x *ReasoningOptions) GetEnableChainOfThought() bool {
	if x != nil {
		return x.EnableChainOfThought
	}
	return false
}

func (x *ReasoningOptions) GetIncludeReasoningTrace() bool {
	if x != nil {
		return x.IncludeReasoningTrace
	}
	return false
}

func (x *ReasoningOptions) GetTemperatureOverride() float32 {
	if x != nil {
		return x.TemperatureOverride
	}
	return 0
}

func (x *ReasoningOptions) GetValidateToolOutputs() bool {
	if x != nil {
		return x.ValidateToolOutputs
	}
	return false
}

func (x *ReasoningOptions) GetOutputFormatInstruction() string {
	if x != nil {
		return x.OutputFormatInstruction
	}
	return ""
}

func (x *ReasoningOptions) GetRequiredOutputFields() []string {
	if x != nil {
		return x.RequiredOutputFields
	}
	return nil
}

var File_nodus_v1_nodes_v1_reasoning_proto protoreflect.FileDescriptor

const file_nodus_v1_nodes_v1_reasoning_proto_rawDesc = "" +
	"\n" +
	"!nodus/v1/nodes/v1/reasoning.proto\x12\x11nodus.v1.nodes.v1\x1a\x1egoogle/protobuf/duration.proto\x1a\x1enodus/v1/common/v1/types.proto\x1a\"nodus/v1/integrations/v1/llm.proto\x1a\x1anodus/v1/mcp/v1/tool.proto\"\x88\x05\n" +
	"\x13ReasoningNodeConfig\x12I\n" +
	"\n" +
	"llm_config\x18\x01 \x01(\v2*.nodus.v1.integrations.v1.LLMConfigurationR\tllmConfig\x12R\n" +
	"\x10model_parameters\x18\x03 \x01(\v2'.nodus.v1.integrations.v1.LLMParametersR\x0fmodelParameters\x12#\n" +
	"\rsystem_prompt\x18\x04 \x01(\tR\fsystemPrompt\x12\x1f\n" +
	"\vuser_prompt\x18\x05 \x01(\tR\n" +
	"userPrompt\x12R\n" +
	"\x14conversation_history\x18\x06 \x03(\v2\x1f.nodus.v1.common.v1.ChatMessageR\x13conversationHistory\x129\n" +
	"\n" +
	"tool_scope\x18\a \x01(\v2\x1a.nodus.v1.mcp.v1.ToolScopeR\ttoolScope\x12#\n" +
	"\rallowed_tools\x18\b \x03(\tR\fallowedTools\x12'\n" +
	"\x0fforbidden_tools\x18\t \x03(\tR\x0eforbiddenTools\x12F\n" +
	"\x11reasoning_timeout\x18\v \x01(\v2\x19.google.protobuf.DurationR\x10reasoningTimeout\x12(\n" +
	"\x10require_tool_use\x18\f \x01(\bR\x0erequireToolUse\x12=\n" +
	"\aoptions\x18\r \x01(\v2#.nodus.v1.nodes.v1.ReasoningOptionsR\aoptions\"\xda\x02\n" +
	"\x10ReasoningOptions\x125\n" +
	"\x17enable_chain_of_thought\x18\x01 \x01(\bR\x14enableChainOfThought\x126\n" +
	"\x17include_reasoning_trace\x18\x02 \x01(\bR\x15includeReasoningTrace\x121\n" +
	"\x14temperature_override\x18\x03 \x01(\x02R\x13temperatureOverride\x122\n" +
	"\x15validate_tool_outputs\x18\x04 \x01(\bR\x13validateToolOutputs\x12:\n" +
	"\x19output_format_instruction\x18\x05 \x01(\tR\x17outputFormatInstruction\x124\n" +
	"\x16required_output_fields\x18\x06 \x03(\tR\x14requiredOutputFieldsB\xd4\x01\n" +
	"\x15com.nodus.v1.nodes.v1B\x0eReasoningProtoP\x01ZDgithub.com/spounge-ai/spounge-proto/gen/go/nodus/v1/nodes/v1;nodesv1\xa2\x02\x03NVN\xaa\x02\x11Nodus.V1.Nodes.V1\xca\x02\x11Nodus\\V1\\Nodes\\V1\xe2\x02\x1dNodus\\V1\\Nodes\\V1\\GPBMetadata\xea\x02\x14Nodus::V1::Nodes::V1b\x06proto3"

var (
	file_nodus_v1_nodes_v1_reasoning_proto_rawDescOnce sync.Once
	file_nodus_v1_nodes_v1_reasoning_proto_rawDescData []byte
)

func file_nodus_v1_nodes_v1_reasoning_proto_rawDescGZIP() []byte {
	file_nodus_v1_nodes_v1_reasoning_proto_rawDescOnce.Do(func() {
		file_nodus_v1_nodes_v1_reasoning_proto_rawDescData = protoimpl.X.CompressGZIP(unsafe.Slice(unsafe.StringData(file_nodus_v1_nodes_v1_reasoning_proto_rawDesc), len(file_nodus_v1_nodes_v1_reasoning_proto_rawDesc)))
	})
	return file_nodus_v1_nodes_v1_reasoning_proto_rawDescData
}

var file_nodus_v1_nodes_v1_reasoning_proto_msgTypes = make([]protoimpl.MessageInfo, 2)
var file_nodus_v1_nodes_v1_reasoning_proto_goTypes = []any{
	(*ReasoningNodeConfig)(nil), // 0: nodus.v1.nodes.v1.ReasoningNodeConfig
	(*ReasoningOptions)(nil),    // 1: nodus.v1.nodes.v1.ReasoningOptions
	(*v1.LLMConfiguration)(nil), // 2: nodus.v1.integrations.v1.LLMConfiguration
	(*v1.LLMParameters)(nil),    // 3: nodus.v1.integrations.v1.LLMParameters
	(*v11.ChatMessage)(nil),     // 4: nodus.v1.common.v1.ChatMessage
	(*v12.ToolScope)(nil),       // 5: nodus.v1.mcp.v1.ToolScope
	(*durationpb.Duration)(nil), // 6: google.protobuf.Duration
}
var file_nodus_v1_nodes_v1_reasoning_proto_depIdxs = []int32{
	2, // 0: nodus.v1.nodes.v1.ReasoningNodeConfig.llm_config:type_name -> nodus.v1.integrations.v1.LLMConfiguration
	3, // 1: nodus.v1.nodes.v1.ReasoningNodeConfig.model_parameters:type_name -> nodus.v1.integrations.v1.LLMParameters
	4, // 2: nodus.v1.nodes.v1.ReasoningNodeConfig.conversation_history:type_name -> nodus.v1.common.v1.ChatMessage
	5, // 3: nodus.v1.nodes.v1.ReasoningNodeConfig.tool_scope:type_name -> nodus.v1.mcp.v1.ToolScope
	6, // 4: nodus.v1.nodes.v1.ReasoningNodeConfig.reasoning_timeout:type_name -> google.protobuf.Duration
	1, // 5: nodus.v1.nodes.v1.ReasoningNodeConfig.options:type_name -> nodus.v1.nodes.v1.ReasoningOptions
	6, // [6:6] is the sub-list for method output_type
	6, // [6:6] is the sub-list for method input_type
	6, // [6:6] is the sub-list for extension type_name
	6, // [6:6] is the sub-list for extension extendee
	0, // [0:6] is the sub-list for field type_name
}

func init() { file_nodus_v1_nodes_v1_reasoning_proto_init() }
func file_nodus_v1_nodes_v1_reasoning_proto_init() {
	if File_nodus_v1_nodes_v1_reasoning_proto != nil {
		return
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: unsafe.Slice(unsafe.StringData(file_nodus_v1_nodes_v1_reasoning_proto_rawDesc), len(file_nodus_v1_nodes_v1_reasoning_proto_rawDesc)),
			NumEnums:      0,
			NumMessages:   2,
			NumExtensions: 0,
			NumServices:   0,
		},
		GoTypes:           file_nodus_v1_nodes_v1_reasoning_proto_goTypes,
		DependencyIndexes: file_nodus_v1_nodes_v1_reasoning_proto_depIdxs,
		MessageInfos:      file_nodus_v1_nodes_v1_reasoning_proto_msgTypes,
	}.Build()
	File_nodus_v1_nodes_v1_reasoning_proto = out.File
	file_nodus_v1_nodes_v1_reasoning_proto_goTypes = nil
	file_nodus_v1_nodes_v1_reasoning_proto_depIdxs = nil
}

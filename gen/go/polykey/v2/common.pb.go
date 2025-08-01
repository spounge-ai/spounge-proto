// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.36.6
// 	protoc        (unknown)
// source: polykey/v2/common.proto

package polykeyv2

import (
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
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

type RequesterContext struct {
	state                  protoimpl.MessageState `protogen:"open.v1"`
	ClientIdentity         string                 `protobuf:"bytes,1,opt,name=client_identity,json=clientIdentity,proto3" json:"client_identity,omitempty"`
	CertificateFingerprint string                 `protobuf:"bytes,2,opt,name=certificate_fingerprint,json=certificateFingerprint,proto3" json:"certificate_fingerprint,omitempty"`
	ApplicationId          string                 `protobuf:"bytes,3,opt,name=application_id,json=applicationId,proto3" json:"application_id,omitempty"`
	CorrelationId          string                 `protobuf:"bytes,4,opt,name=correlation_id,json=correlationId,proto3" json:"correlation_id,omitempty"`
	unknownFields          protoimpl.UnknownFields
	sizeCache              protoimpl.SizeCache
}

func (x *RequesterContext) Reset() {
	*x = RequesterContext{}
	mi := &file_polykey_v2_common_proto_msgTypes[0]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *RequesterContext) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*RequesterContext) ProtoMessage() {}

func (x *RequesterContext) ProtoReflect() protoreflect.Message {
	mi := &file_polykey_v2_common_proto_msgTypes[0]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use RequesterContext.ProtoReflect.Descriptor instead.
func (*RequesterContext) Descriptor() ([]byte, []int) {
	return file_polykey_v2_common_proto_rawDescGZIP(), []int{0}
}

func (x *RequesterContext) GetClientIdentity() string {
	if x != nil {
		return x.ClientIdentity
	}
	return ""
}

func (x *RequesterContext) GetCertificateFingerprint() string {
	if x != nil {
		return x.CertificateFingerprint
	}
	return ""
}

func (x *RequesterContext) GetApplicationId() string {
	if x != nil {
		return x.ApplicationId
	}
	return ""
}

func (x *RequesterContext) GetCorrelationId() string {
	if x != nil {
		return x.CorrelationId
	}
	return ""
}

type AccessAttributes struct {
	state            protoimpl.MessageState `protogen:"open.v1"`
	Environment      string                 `protobuf:"bytes,1,opt,name=environment,proto3" json:"environment,omitempty"`
	NetworkZone      string                 `protobuf:"bytes,2,opt,name=network_zone,json=networkZone,proto3" json:"network_zone,omitempty"`
	GeographicRegion string                 `protobuf:"bytes,3,opt,name=geographic_region,json=geographicRegion,proto3" json:"geographic_region,omitempty"`
	RequestTime      *timestamppb.Timestamp `protobuf:"bytes,4,opt,name=request_time,json=requestTime,proto3" json:"request_time,omitempty"`
	TimeWindow       string                 `protobuf:"bytes,5,opt,name=time_window,json=timeWindow,proto3" json:"time_window,omitempty"` // e.g., "business-hours", "after-hours".
	Roles            []string               `protobuf:"bytes,6,rep,name=roles,proto3" json:"roles,omitempty"`
	Permissions      []string               `protobuf:"bytes,7,rep,name=permissions,proto3" json:"permissions,omitempty"`
	CustomAttributes map[string]string      `protobuf:"bytes,8,rep,name=custom_attributes,json=customAttributes,proto3" json:"custom_attributes,omitempty" protobuf_key:"bytes,1,opt,name=key" protobuf_val:"bytes,2,opt,name=value"`
	unknownFields    protoimpl.UnknownFields
	sizeCache        protoimpl.SizeCache
}

func (x *AccessAttributes) Reset() {
	*x = AccessAttributes{}
	mi := &file_polykey_v2_common_proto_msgTypes[1]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *AccessAttributes) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*AccessAttributes) ProtoMessage() {}

func (x *AccessAttributes) ProtoReflect() protoreflect.Message {
	mi := &file_polykey_v2_common_proto_msgTypes[1]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use AccessAttributes.ProtoReflect.Descriptor instead.
func (*AccessAttributes) Descriptor() ([]byte, []int) {
	return file_polykey_v2_common_proto_rawDescGZIP(), []int{1}
}

func (x *AccessAttributes) GetEnvironment() string {
	if x != nil {
		return x.Environment
	}
	return ""
}

func (x *AccessAttributes) GetNetworkZone() string {
	if x != nil {
		return x.NetworkZone
	}
	return ""
}

func (x *AccessAttributes) GetGeographicRegion() string {
	if x != nil {
		return x.GeographicRegion
	}
	return ""
}

func (x *AccessAttributes) GetRequestTime() *timestamppb.Timestamp {
	if x != nil {
		return x.RequestTime
	}
	return nil
}

func (x *AccessAttributes) GetTimeWindow() string {
	if x != nil {
		return x.TimeWindow
	}
	return ""
}

func (x *AccessAttributes) GetRoles() []string {
	if x != nil {
		return x.Roles
	}
	return nil
}

func (x *AccessAttributes) GetPermissions() []string {
	if x != nil {
		return x.Permissions
	}
	return nil
}

func (x *AccessAttributes) GetCustomAttributes() map[string]string {
	if x != nil {
		return x.CustomAttributes
	}
	return nil
}

type KeyMetadata struct {
	state              protoimpl.MessageState `protogen:"open.v1"`
	KeyId              string                 `protobuf:"bytes,1,opt,name=key_id,json=keyId,proto3" json:"key_id,omitempty"`
	KeyType            KeyType                `protobuf:"varint,2,opt,name=key_type,json=keyType,proto3,enum=polykey.v2.KeyType" json:"key_type,omitempty"`
	Status             KeyStatus              `protobuf:"varint,3,opt,name=status,proto3,enum=polykey.v2.KeyStatus" json:"status,omitempty"`
	Version            int32                  `protobuf:"varint,4,opt,name=version,proto3" json:"version,omitempty"`
	CreatedAt          *timestamppb.Timestamp `protobuf:"bytes,5,opt,name=created_at,json=createdAt,proto3" json:"created_at,omitempty"`
	UpdatedAt          *timestamppb.Timestamp `protobuf:"bytes,6,opt,name=updated_at,json=updatedAt,proto3" json:"updated_at,omitempty"`
	ExpiresAt          *timestamppb.Timestamp `protobuf:"bytes,7,opt,name=expires_at,json=expiresAt,proto3" json:"expires_at,omitempty"`
	LastAccessedAt     *timestamppb.Timestamp `protobuf:"bytes,8,opt,name=last_accessed_at,json=lastAccessedAt,proto3" json:"last_accessed_at,omitempty"`
	CreatorIdentity    string                 `protobuf:"bytes,9,opt,name=creator_identity,json=creatorIdentity,proto3" json:"creator_identity,omitempty"`
	AuthorizedContexts []string               `protobuf:"bytes,10,rep,name=authorized_contexts,json=authorizedContexts,proto3" json:"authorized_contexts,omitempty"`
	AccessPolicies     map[string]string      `protobuf:"bytes,11,rep,name=access_policies,json=accessPolicies,proto3" json:"access_policies,omitempty" protobuf_key:"bytes,1,opt,name=key" protobuf_val:"bytes,2,opt,name=value"`
	Description        string                 `protobuf:"bytes,12,opt,name=description,proto3" json:"description,omitempty"`
	Tags               map[string]string      `protobuf:"bytes,13,rep,name=tags,proto3" json:"tags,omitempty" protobuf_key:"bytes,1,opt,name=key" protobuf_val:"bytes,2,opt,name=value"`
	DataClassification string                 `protobuf:"bytes,14,opt,name=data_classification,json=dataClassification,proto3" json:"data_classification,omitempty"`
	MetadataChecksum   string                 `protobuf:"bytes,15,opt,name=metadata_checksum,json=metadataChecksum,proto3" json:"metadata_checksum,omitempty"`
	AccessCount        int64                  `protobuf:"varint,16,opt,name=access_count,json=accessCount,proto3" json:"access_count,omitempty"`
	unknownFields      protoimpl.UnknownFields
	sizeCache          protoimpl.SizeCache
}

func (x *KeyMetadata) Reset() {
	*x = KeyMetadata{}
	mi := &file_polykey_v2_common_proto_msgTypes[2]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *KeyMetadata) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*KeyMetadata) ProtoMessage() {}

func (x *KeyMetadata) ProtoReflect() protoreflect.Message {
	mi := &file_polykey_v2_common_proto_msgTypes[2]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use KeyMetadata.ProtoReflect.Descriptor instead.
func (*KeyMetadata) Descriptor() ([]byte, []int) {
	return file_polykey_v2_common_proto_rawDescGZIP(), []int{2}
}

func (x *KeyMetadata) GetKeyId() string {
	if x != nil {
		return x.KeyId
	}
	return ""
}

func (x *KeyMetadata) GetKeyType() KeyType {
	if x != nil {
		return x.KeyType
	}
	return KeyType_KEY_TYPE_UNSPECIFIED
}

func (x *KeyMetadata) GetStatus() KeyStatus {
	if x != nil {
		return x.Status
	}
	return KeyStatus_KEY_STATUS_UNSPECIFIED
}

func (x *KeyMetadata) GetVersion() int32 {
	if x != nil {
		return x.Version
	}
	return 0
}

func (x *KeyMetadata) GetCreatedAt() *timestamppb.Timestamp {
	if x != nil {
		return x.CreatedAt
	}
	return nil
}

func (x *KeyMetadata) GetUpdatedAt() *timestamppb.Timestamp {
	if x != nil {
		return x.UpdatedAt
	}
	return nil
}

func (x *KeyMetadata) GetExpiresAt() *timestamppb.Timestamp {
	if x != nil {
		return x.ExpiresAt
	}
	return nil
}

func (x *KeyMetadata) GetLastAccessedAt() *timestamppb.Timestamp {
	if x != nil {
		return x.LastAccessedAt
	}
	return nil
}

func (x *KeyMetadata) GetCreatorIdentity() string {
	if x != nil {
		return x.CreatorIdentity
	}
	return ""
}

func (x *KeyMetadata) GetAuthorizedContexts() []string {
	if x != nil {
		return x.AuthorizedContexts
	}
	return nil
}

func (x *KeyMetadata) GetAccessPolicies() map[string]string {
	if x != nil {
		return x.AccessPolicies
	}
	return nil
}

func (x *KeyMetadata) GetDescription() string {
	if x != nil {
		return x.Description
	}
	return ""
}

func (x *KeyMetadata) GetTags() map[string]string {
	if x != nil {
		return x.Tags
	}
	return nil
}

func (x *KeyMetadata) GetDataClassification() string {
	if x != nil {
		return x.DataClassification
	}
	return ""
}

func (x *KeyMetadata) GetMetadataChecksum() string {
	if x != nil {
		return x.MetadataChecksum
	}
	return ""
}

func (x *KeyMetadata) GetAccessCount() int64 {
	if x != nil {
		return x.AccessCount
	}
	return 0
}

type KeyMaterial struct {
	state               protoimpl.MessageState `protogen:"open.v1"`
	EncryptedKeyData    []byte                 `protobuf:"bytes,1,opt,name=encrypted_key_data,json=encryptedKeyData,proto3" json:"encrypted_key_data,omitempty"`
	EncryptionAlgorithm string                 `protobuf:"bytes,2,opt,name=encryption_algorithm,json=encryptionAlgorithm,proto3" json:"encryption_algorithm,omitempty"`
	KeyDerivationParams string                 `protobuf:"bytes,3,opt,name=key_derivation_params,json=keyDerivationParams,proto3" json:"key_derivation_params,omitempty"`
	KeyChecksum         string                 `protobuf:"bytes,4,opt,name=key_checksum,json=keyChecksum,proto3" json:"key_checksum,omitempty"`
	unknownFields       protoimpl.UnknownFields
	sizeCache           protoimpl.SizeCache
}

func (x *KeyMaterial) Reset() {
	*x = KeyMaterial{}
	mi := &file_polykey_v2_common_proto_msgTypes[3]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *KeyMaterial) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*KeyMaterial) ProtoMessage() {}

func (x *KeyMaterial) ProtoReflect() protoreflect.Message {
	mi := &file_polykey_v2_common_proto_msgTypes[3]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use KeyMaterial.ProtoReflect.Descriptor instead.
func (*KeyMaterial) Descriptor() ([]byte, []int) {
	return file_polykey_v2_common_proto_rawDescGZIP(), []int{3}
}

func (x *KeyMaterial) GetEncryptedKeyData() []byte {
	if x != nil {
		return x.EncryptedKeyData
	}
	return nil
}

func (x *KeyMaterial) GetEncryptionAlgorithm() string {
	if x != nil {
		return x.EncryptionAlgorithm
	}
	return ""
}

func (x *KeyMaterial) GetKeyDerivationParams() string {
	if x != nil {
		return x.KeyDerivationParams
	}
	return ""
}

func (x *KeyMaterial) GetKeyChecksum() string {
	if x != nil {
		return x.KeyChecksum
	}
	return ""
}

type AccessHistoryEntry struct {
	state          protoimpl.MessageState `protogen:"open.v1"`
	Timestamp      *timestamppb.Timestamp `protobuf:"bytes,1,opt,name=timestamp,proto3" json:"timestamp,omitempty"`
	ClientIdentity string                 `protobuf:"bytes,2,opt,name=client_identity,json=clientIdentity,proto3" json:"client_identity,omitempty"`
	Operation      string                 `protobuf:"bytes,3,opt,name=operation,proto3" json:"operation,omitempty"`
	Success        bool                   `protobuf:"varint,4,opt,name=success,proto3" json:"success,omitempty"`
	CorrelationId  string                 `protobuf:"bytes,5,opt,name=correlation_id,json=correlationId,proto3" json:"correlation_id,omitempty"`
	unknownFields  protoimpl.UnknownFields
	sizeCache      protoimpl.SizeCache
}

func (x *AccessHistoryEntry) Reset() {
	*x = AccessHistoryEntry{}
	mi := &file_polykey_v2_common_proto_msgTypes[4]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *AccessHistoryEntry) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*AccessHistoryEntry) ProtoMessage() {}

func (x *AccessHistoryEntry) ProtoReflect() protoreflect.Message {
	mi := &file_polykey_v2_common_proto_msgTypes[4]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use AccessHistoryEntry.ProtoReflect.Descriptor instead.
func (*AccessHistoryEntry) Descriptor() ([]byte, []int) {
	return file_polykey_v2_common_proto_rawDescGZIP(), []int{4}
}

func (x *AccessHistoryEntry) GetTimestamp() *timestamppb.Timestamp {
	if x != nil {
		return x.Timestamp
	}
	return nil
}

func (x *AccessHistoryEntry) GetClientIdentity() string {
	if x != nil {
		return x.ClientIdentity
	}
	return ""
}

func (x *AccessHistoryEntry) GetOperation() string {
	if x != nil {
		return x.Operation
	}
	return ""
}

func (x *AccessHistoryEntry) GetSuccess() bool {
	if x != nil {
		return x.Success
	}
	return false
}

func (x *AccessHistoryEntry) GetCorrelationId() string {
	if x != nil {
		return x.CorrelationId
	}
	return ""
}

type PolicyDetail struct {
	state          protoimpl.MessageState `protogen:"open.v1"`
	PolicyId       string                 `protobuf:"bytes,1,opt,name=policy_id,json=policyId,proto3" json:"policy_id,omitempty"`
	PolicyType     string                 `protobuf:"bytes,2,opt,name=policy_type,json=policyType,proto3" json:"policy_type,omitempty"` // e.g., "RBAC", "ABAC", "TimeBased".
	PolicyParams   map[string]string      `protobuf:"bytes,3,rep,name=policy_params,json=policyParams,proto3" json:"policy_params,omitempty" protobuf_key:"bytes,1,opt,name=key" protobuf_val:"bytes,2,opt,name=value"`
	EffectiveFrom  *timestamppb.Timestamp `protobuf:"bytes,4,opt,name=effective_from,json=effectiveFrom,proto3" json:"effective_from,omitempty"`
	EffectiveUntil *timestamppb.Timestamp `protobuf:"bytes,5,opt,name=effective_until,json=effectiveUntil,proto3" json:"effective_until,omitempty"`
	unknownFields  protoimpl.UnknownFields
	sizeCache      protoimpl.SizeCache
}

func (x *PolicyDetail) Reset() {
	*x = PolicyDetail{}
	mi := &file_polykey_v2_common_proto_msgTypes[5]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *PolicyDetail) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*PolicyDetail) ProtoMessage() {}

func (x *PolicyDetail) ProtoReflect() protoreflect.Message {
	mi := &file_polykey_v2_common_proto_msgTypes[5]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use PolicyDetail.ProtoReflect.Descriptor instead.
func (*PolicyDetail) Descriptor() ([]byte, []int) {
	return file_polykey_v2_common_proto_rawDescGZIP(), []int{5}
}

func (x *PolicyDetail) GetPolicyId() string {
	if x != nil {
		return x.PolicyId
	}
	return ""
}

func (x *PolicyDetail) GetPolicyType() string {
	if x != nil {
		return x.PolicyType
	}
	return ""
}

func (x *PolicyDetail) GetPolicyParams() map[string]string {
	if x != nil {
		return x.PolicyParams
	}
	return nil
}

func (x *PolicyDetail) GetEffectiveFrom() *timestamppb.Timestamp {
	if x != nil {
		return x.EffectiveFrom
	}
	return nil
}

func (x *PolicyDetail) GetEffectiveUntil() *timestamppb.Timestamp {
	if x != nil {
		return x.EffectiveUntil
	}
	return nil
}

var File_polykey_v2_common_proto protoreflect.FileDescriptor

const file_polykey_v2_common_proto_rawDesc = "" +
	"\n" +
	"\x17polykey/v2/common.proto\x12\n" +
	"polykey.v2\x1a\x1fgoogle/protobuf/timestamp.proto\x1a\x1apolykey/v2/key_types.proto\"\xc2\x01\n" +
	"\x10RequesterContext\x12'\n" +
	"\x0fclient_identity\x18\x01 \x01(\tR\x0eclientIdentity\x127\n" +
	"\x17certificate_fingerprint\x18\x02 \x01(\tR\x16certificateFingerprint\x12%\n" +
	"\x0eapplication_id\x18\x03 \x01(\tR\rapplicationId\x12%\n" +
	"\x0ecorrelation_id\x18\x04 \x01(\tR\rcorrelationId\"\xc2\x03\n" +
	"\x10AccessAttributes\x12 \n" +
	"\venvironment\x18\x01 \x01(\tR\venvironment\x12!\n" +
	"\fnetwork_zone\x18\x02 \x01(\tR\vnetworkZone\x12+\n" +
	"\x11geographic_region\x18\x03 \x01(\tR\x10geographicRegion\x12=\n" +
	"\frequest_time\x18\x04 \x01(\v2\x1a.google.protobuf.TimestampR\vrequestTime\x12\x1f\n" +
	"\vtime_window\x18\x05 \x01(\tR\n" +
	"timeWindow\x12\x14\n" +
	"\x05roles\x18\x06 \x03(\tR\x05roles\x12 \n" +
	"\vpermissions\x18\a \x03(\tR\vpermissions\x12_\n" +
	"\x11custom_attributes\x18\b \x03(\v22.polykey.v2.AccessAttributes.CustomAttributesEntryR\x10customAttributes\x1aC\n" +
	"\x15CustomAttributesEntry\x12\x10\n" +
	"\x03key\x18\x01 \x01(\tR\x03key\x12\x14\n" +
	"\x05value\x18\x02 \x01(\tR\x05value:\x028\x01\"\x9c\a\n" +
	"\vKeyMetadata\x12\x15\n" +
	"\x06key_id\x18\x01 \x01(\tR\x05keyId\x12.\n" +
	"\bkey_type\x18\x02 \x01(\x0e2\x13.polykey.v2.KeyTypeR\akeyType\x12-\n" +
	"\x06status\x18\x03 \x01(\x0e2\x15.polykey.v2.KeyStatusR\x06status\x12\x18\n" +
	"\aversion\x18\x04 \x01(\x05R\aversion\x129\n" +
	"\n" +
	"created_at\x18\x05 \x01(\v2\x1a.google.protobuf.TimestampR\tcreatedAt\x129\n" +
	"\n" +
	"updated_at\x18\x06 \x01(\v2\x1a.google.protobuf.TimestampR\tupdatedAt\x129\n" +
	"\n" +
	"expires_at\x18\a \x01(\v2\x1a.google.protobuf.TimestampR\texpiresAt\x12D\n" +
	"\x10last_accessed_at\x18\b \x01(\v2\x1a.google.protobuf.TimestampR\x0elastAccessedAt\x12)\n" +
	"\x10creator_identity\x18\t \x01(\tR\x0fcreatorIdentity\x12/\n" +
	"\x13authorized_contexts\x18\n" +
	" \x03(\tR\x12authorizedContexts\x12T\n" +
	"\x0faccess_policies\x18\v \x03(\v2+.polykey.v2.KeyMetadata.AccessPoliciesEntryR\x0eaccessPolicies\x12 \n" +
	"\vdescription\x18\f \x01(\tR\vdescription\x125\n" +
	"\x04tags\x18\r \x03(\v2!.polykey.v2.KeyMetadata.TagsEntryR\x04tags\x12/\n" +
	"\x13data_classification\x18\x0e \x01(\tR\x12dataClassification\x12+\n" +
	"\x11metadata_checksum\x18\x0f \x01(\tR\x10metadataChecksum\x12!\n" +
	"\faccess_count\x18\x10 \x01(\x03R\vaccessCount\x1aA\n" +
	"\x13AccessPoliciesEntry\x12\x10\n" +
	"\x03key\x18\x01 \x01(\tR\x03key\x12\x14\n" +
	"\x05value\x18\x02 \x01(\tR\x05value:\x028\x01\x1a7\n" +
	"\tTagsEntry\x12\x10\n" +
	"\x03key\x18\x01 \x01(\tR\x03key\x12\x14\n" +
	"\x05value\x18\x02 \x01(\tR\x05value:\x028\x01\"\xc5\x01\n" +
	"\vKeyMaterial\x12,\n" +
	"\x12encrypted_key_data\x18\x01 \x01(\fR\x10encryptedKeyData\x121\n" +
	"\x14encryption_algorithm\x18\x02 \x01(\tR\x13encryptionAlgorithm\x122\n" +
	"\x15key_derivation_params\x18\x03 \x01(\tR\x13keyDerivationParams\x12!\n" +
	"\fkey_checksum\x18\x04 \x01(\tR\vkeyChecksum\"\xd6\x01\n" +
	"\x12AccessHistoryEntry\x128\n" +
	"\ttimestamp\x18\x01 \x01(\v2\x1a.google.protobuf.TimestampR\ttimestamp\x12'\n" +
	"\x0fclient_identity\x18\x02 \x01(\tR\x0eclientIdentity\x12\x1c\n" +
	"\toperation\x18\x03 \x01(\tR\toperation\x12\x18\n" +
	"\asuccess\x18\x04 \x01(\bR\asuccess\x12%\n" +
	"\x0ecorrelation_id\x18\x05 \x01(\tR\rcorrelationId\"\xe6\x02\n" +
	"\fPolicyDetail\x12\x1b\n" +
	"\tpolicy_id\x18\x01 \x01(\tR\bpolicyId\x12\x1f\n" +
	"\vpolicy_type\x18\x02 \x01(\tR\n" +
	"policyType\x12O\n" +
	"\rpolicy_params\x18\x03 \x03(\v2*.polykey.v2.PolicyDetail.PolicyParamsEntryR\fpolicyParams\x12A\n" +
	"\x0eeffective_from\x18\x04 \x01(\v2\x1a.google.protobuf.TimestampR\reffectiveFrom\x12C\n" +
	"\x0feffective_until\x18\x05 \x01(\v2\x1a.google.protobuf.TimestampR\x0eeffectiveUntil\x1a?\n" +
	"\x11PolicyParamsEntry\x12\x10\n" +
	"\x03key\x18\x01 \x01(\tR\x03key\x12\x14\n" +
	"\x05value\x18\x02 \x01(\tR\x05value:\x028\x01B\xa7\x01\n" +
	"\x0ecom.polykey.v2B\vCommonProtoP\x01Z?github.com/spounge-ai/spounge-proto/gen/go/polykey/v2;polykeyv2\xa2\x02\x03PXX\xaa\x02\n" +
	"Polykey.V2\xca\x02\n" +
	"Polykey\\V2\xe2\x02\x16Polykey\\V2\\GPBMetadata\xea\x02\vPolykey::V2b\x06proto3"

var (
	file_polykey_v2_common_proto_rawDescOnce sync.Once
	file_polykey_v2_common_proto_rawDescData []byte
)

func file_polykey_v2_common_proto_rawDescGZIP() []byte {
	file_polykey_v2_common_proto_rawDescOnce.Do(func() {
		file_polykey_v2_common_proto_rawDescData = protoimpl.X.CompressGZIP(unsafe.Slice(unsafe.StringData(file_polykey_v2_common_proto_rawDesc), len(file_polykey_v2_common_proto_rawDesc)))
	})
	return file_polykey_v2_common_proto_rawDescData
}

var file_polykey_v2_common_proto_msgTypes = make([]protoimpl.MessageInfo, 10)
var file_polykey_v2_common_proto_goTypes = []any{
	(*RequesterContext)(nil),      // 0: polykey.v2.RequesterContext
	(*AccessAttributes)(nil),      // 1: polykey.v2.AccessAttributes
	(*KeyMetadata)(nil),           // 2: polykey.v2.KeyMetadata
	(*KeyMaterial)(nil),           // 3: polykey.v2.KeyMaterial
	(*AccessHistoryEntry)(nil),    // 4: polykey.v2.AccessHistoryEntry
	(*PolicyDetail)(nil),          // 5: polykey.v2.PolicyDetail
	nil,                           // 6: polykey.v2.AccessAttributes.CustomAttributesEntry
	nil,                           // 7: polykey.v2.KeyMetadata.AccessPoliciesEntry
	nil,                           // 8: polykey.v2.KeyMetadata.TagsEntry
	nil,                           // 9: polykey.v2.PolicyDetail.PolicyParamsEntry
	(*timestamppb.Timestamp)(nil), // 10: google.protobuf.Timestamp
	(KeyType)(0),                  // 11: polykey.v2.KeyType
	(KeyStatus)(0),                // 12: polykey.v2.KeyStatus
}
var file_polykey_v2_common_proto_depIdxs = []int32{
	10, // 0: polykey.v2.AccessAttributes.request_time:type_name -> google.protobuf.Timestamp
	6,  // 1: polykey.v2.AccessAttributes.custom_attributes:type_name -> polykey.v2.AccessAttributes.CustomAttributesEntry
	11, // 2: polykey.v2.KeyMetadata.key_type:type_name -> polykey.v2.KeyType
	12, // 3: polykey.v2.KeyMetadata.status:type_name -> polykey.v2.KeyStatus
	10, // 4: polykey.v2.KeyMetadata.created_at:type_name -> google.protobuf.Timestamp
	10, // 5: polykey.v2.KeyMetadata.updated_at:type_name -> google.protobuf.Timestamp
	10, // 6: polykey.v2.KeyMetadata.expires_at:type_name -> google.protobuf.Timestamp
	10, // 7: polykey.v2.KeyMetadata.last_accessed_at:type_name -> google.protobuf.Timestamp
	7,  // 8: polykey.v2.KeyMetadata.access_policies:type_name -> polykey.v2.KeyMetadata.AccessPoliciesEntry
	8,  // 9: polykey.v2.KeyMetadata.tags:type_name -> polykey.v2.KeyMetadata.TagsEntry
	10, // 10: polykey.v2.AccessHistoryEntry.timestamp:type_name -> google.protobuf.Timestamp
	9,  // 11: polykey.v2.PolicyDetail.policy_params:type_name -> polykey.v2.PolicyDetail.PolicyParamsEntry
	10, // 12: polykey.v2.PolicyDetail.effective_from:type_name -> google.protobuf.Timestamp
	10, // 13: polykey.v2.PolicyDetail.effective_until:type_name -> google.protobuf.Timestamp
	14, // [14:14] is the sub-list for method output_type
	14, // [14:14] is the sub-list for method input_type
	14, // [14:14] is the sub-list for extension type_name
	14, // [14:14] is the sub-list for extension extendee
	0,  // [0:14] is the sub-list for field type_name
}

func init() { file_polykey_v2_common_proto_init() }
func file_polykey_v2_common_proto_init() {
	if File_polykey_v2_common_proto != nil {
		return
	}
	file_polykey_v2_key_types_proto_init()
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: unsafe.Slice(unsafe.StringData(file_polykey_v2_common_proto_rawDesc), len(file_polykey_v2_common_proto_rawDesc)),
			NumEnums:      0,
			NumMessages:   10,
			NumExtensions: 0,
			NumServices:   0,
		},
		GoTypes:           file_polykey_v2_common_proto_goTypes,
		DependencyIndexes: file_polykey_v2_common_proto_depIdxs,
		MessageInfos:      file_polykey_v2_common_proto_msgTypes,
	}.Build()
	File_polykey_v2_common_proto = out.File
	file_polykey_v2_common_proto_goTypes = nil
	file_polykey_v2_common_proto_depIdxs = nil
}

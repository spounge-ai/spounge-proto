// Code generated by protoc-gen-go-grpc. DO NOT EDIT.
// versions:
// - protoc-gen-go-grpc v1.5.1
// - protoc             (unknown)
// source: api/v2/auth_gateway_service.proto

package apiv2

import (
	context "context"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
// Requires gRPC-Go v1.64.0 or later.
const _ = grpc.SupportPackageIsVersion9

const (
	AuthGatewayService_Login_FullMethodName        = "/api.v2.AuthGatewayService/Login"
	AuthGatewayService_RefreshToken_FullMethodName = "/api.v2.AuthGatewayService/RefreshToken"
	AuthGatewayService_Logout_FullMethodName       = "/api.v2.AuthGatewayService/Logout"
)

// AuthGatewayServiceClient is the client API for AuthGatewayService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type AuthGatewayServiceClient interface {
	Login(ctx context.Context, in *AuthGatewayServiceLoginRequest, opts ...grpc.CallOption) (*AuthGatewayServiceLoginResponse, error)
	RefreshToken(ctx context.Context, in *AuthGatewayServiceRefreshTokenRequest, opts ...grpc.CallOption) (*AuthGatewayServiceRefreshTokenResponse, error)
	Logout(ctx context.Context, in *AuthGatewayServiceLogoutRequest, opts ...grpc.CallOption) (*AuthGatewayServiceLogoutResponse, error)
}

type authGatewayServiceClient struct {
	cc grpc.ClientConnInterface
}

func NewAuthGatewayServiceClient(cc grpc.ClientConnInterface) AuthGatewayServiceClient {
	return &authGatewayServiceClient{cc}
}

func (c *authGatewayServiceClient) Login(ctx context.Context, in *AuthGatewayServiceLoginRequest, opts ...grpc.CallOption) (*AuthGatewayServiceLoginResponse, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(AuthGatewayServiceLoginResponse)
	err := c.cc.Invoke(ctx, AuthGatewayService_Login_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *authGatewayServiceClient) RefreshToken(ctx context.Context, in *AuthGatewayServiceRefreshTokenRequest, opts ...grpc.CallOption) (*AuthGatewayServiceRefreshTokenResponse, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(AuthGatewayServiceRefreshTokenResponse)
	err := c.cc.Invoke(ctx, AuthGatewayService_RefreshToken_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *authGatewayServiceClient) Logout(ctx context.Context, in *AuthGatewayServiceLogoutRequest, opts ...grpc.CallOption) (*AuthGatewayServiceLogoutResponse, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(AuthGatewayServiceLogoutResponse)
	err := c.cc.Invoke(ctx, AuthGatewayService_Logout_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// AuthGatewayServiceServer is the server API for AuthGatewayService service.
// All implementations must embed UnimplementedAuthGatewayServiceServer
// for forward compatibility.
type AuthGatewayServiceServer interface {
	Login(context.Context, *AuthGatewayServiceLoginRequest) (*AuthGatewayServiceLoginResponse, error)
	RefreshToken(context.Context, *AuthGatewayServiceRefreshTokenRequest) (*AuthGatewayServiceRefreshTokenResponse, error)
	Logout(context.Context, *AuthGatewayServiceLogoutRequest) (*AuthGatewayServiceLogoutResponse, error)
	mustEmbedUnimplementedAuthGatewayServiceServer()
}

// UnimplementedAuthGatewayServiceServer must be embedded to have
// forward compatible implementations.
//
// NOTE: this should be embedded by value instead of pointer to avoid a nil
// pointer dereference when methods are called.
type UnimplementedAuthGatewayServiceServer struct{}

func (UnimplementedAuthGatewayServiceServer) Login(context.Context, *AuthGatewayServiceLoginRequest) (*AuthGatewayServiceLoginResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method Login not implemented")
}
func (UnimplementedAuthGatewayServiceServer) RefreshToken(context.Context, *AuthGatewayServiceRefreshTokenRequest) (*AuthGatewayServiceRefreshTokenResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method RefreshToken not implemented")
}
func (UnimplementedAuthGatewayServiceServer) Logout(context.Context, *AuthGatewayServiceLogoutRequest) (*AuthGatewayServiceLogoutResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method Logout not implemented")
}
func (UnimplementedAuthGatewayServiceServer) mustEmbedUnimplementedAuthGatewayServiceServer() {}
func (UnimplementedAuthGatewayServiceServer) testEmbeddedByValue()                            {}

// UnsafeAuthGatewayServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to AuthGatewayServiceServer will
// result in compilation errors.
type UnsafeAuthGatewayServiceServer interface {
	mustEmbedUnimplementedAuthGatewayServiceServer()
}

func RegisterAuthGatewayServiceServer(s grpc.ServiceRegistrar, srv AuthGatewayServiceServer) {
	// If the following call pancis, it indicates UnimplementedAuthGatewayServiceServer was
	// embedded by pointer and is nil.  This will cause panics if an
	// unimplemented method is ever invoked, so we test this at initialization
	// time to prevent it from happening at runtime later due to I/O.
	if t, ok := srv.(interface{ testEmbeddedByValue() }); ok {
		t.testEmbeddedByValue()
	}
	s.RegisterService(&AuthGatewayService_ServiceDesc, srv)
}

func _AuthGatewayService_Login_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(AuthGatewayServiceLoginRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(AuthGatewayServiceServer).Login(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: AuthGatewayService_Login_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(AuthGatewayServiceServer).Login(ctx, req.(*AuthGatewayServiceLoginRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _AuthGatewayService_RefreshToken_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(AuthGatewayServiceRefreshTokenRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(AuthGatewayServiceServer).RefreshToken(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: AuthGatewayService_RefreshToken_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(AuthGatewayServiceServer).RefreshToken(ctx, req.(*AuthGatewayServiceRefreshTokenRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _AuthGatewayService_Logout_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(AuthGatewayServiceLogoutRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(AuthGatewayServiceServer).Logout(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: AuthGatewayService_Logout_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(AuthGatewayServiceServer).Logout(ctx, req.(*AuthGatewayServiceLogoutRequest))
	}
	return interceptor(ctx, in, info, handler)
}

// AuthGatewayService_ServiceDesc is the grpc.ServiceDesc for AuthGatewayService service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var AuthGatewayService_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "api.v2.AuthGatewayService",
	HandlerType: (*AuthGatewayServiceServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "Login",
			Handler:    _AuthGatewayService_Login_Handler,
		},
		{
			MethodName: "RefreshToken",
			Handler:    _AuthGatewayService_RefreshToken_Handler,
		},
		{
			MethodName: "Logout",
			Handler:    _AuthGatewayService_Logout_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "api/v2/auth_gateway_service.proto",
}

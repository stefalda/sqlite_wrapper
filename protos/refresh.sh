#!/bin/zsh
# Tried but it doesn't seem to matter: --grpc-web_out=mode=grpcwebtext:lib/generated 
protoc --dart_out=grpc:lib/generated -Iprotos protos/sqlite_wrapper_rpc.proto protos/google/protobuf/any.proto protos/google/protobuf/wrappers.proto protos/auth.proto




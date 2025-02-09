#!/bin/zsh
protoc --dart_out=grpc:lib/generated -Iprotos protos/sqlite_wrapper_rpc.proto protos/google/protobuf/any.proto protos/google/protobuf/wrappers.proto




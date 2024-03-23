cmake_minimum_required(VERSION 3.16)
project(tinyfile)

set(CMAKE_CXX_STANDARD 11)

include_directories(include/)

# API Library
add_library(tinyfile
        library.c
        include/tinyfile/library.h
        include/tinyfile/types.h)

target_link_libraries(tinyfile rt pthread)

target_compile_definitions(tinyfile PUBLIC -DDEBUG=0)

# Server
add_executable(tinyfile-server
        server.c
        include/tinyfile/server.h
        include/tinyfile/types.h
        include/tinyfile/messages.h
        include/tinyfile/params.h
        include/snappy-c/snappy.c)

target_link_libraries(tinyfile-server rt pthread)

# Client
add_executable(tinyfile-client
        client.c)

target_link_libraries(tinyfile-client tinyfile)

cmake_minimum_required(VERSION 3.17)
project(tinyfile)

set(CMAKE_CXX_STANDARD 11)

include_directories(utils/)

# API Library
add_executable(tinyfile
        library.c
        utils/tinyfile/library.h
        utils/tinyfile/types.h)

target_link_libraries(tinyfile rt pthread)

target_compile_definitions(tinyfile PUBLIC -DDEBUG=0)

# Server
add_executable(tinyfile-server
        server.c
        utils/tinyfile/server.h
        utils/tinyfile/types.h
        utils/tinyfile/messages.h
        utils/tinyfile/params.h)

target_link_libraries(tinyfile-server rt pthread)


# Client
add_executable(tinyfile-client
        client.c)

target_link_libraries(tinyfile-client tinyfile)

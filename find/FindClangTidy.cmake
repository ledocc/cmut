


set(__ClangTidy_NAME clang-tidy)

if (PACKAGE_FIND_VERSION)
    set(__ClangTidy_NAME ${__ClangTify_NAME}-${PACKAGE_FIND_VERSION})
endif()

message(STATUS "PACKAGE_FIND_VERSION = ${PACKAGE_FIND_VERSION}")

find_program(ClangTidy_COMMAND NAMES ${__ClangTidy_NAME})


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    ClangTidy FOUND_VAR ClangTidy_FOUND
    REQUIRED_VARS
        ClangTidy_COMMAND
    )




find_program(cppcheck_COMMAND NAMES cppcheck)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    cppcheck FOUND_VAR cppcheck_FOUND
    REQUIRED_VARS
        cppcheck_COMMAND
    )

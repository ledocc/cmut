

set(__IncludeWhatYouUse_NAME include-what-you-use iwyu)
find_program(IncludeWhatYouUse_COMMAND NAMES ${__IncludeWhatYouUse_NAME})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    IncludeWhatYouUse FOUND_VAR IncludeWhatYouUse_FOUND
    REQUIRED_VARS
        IncludeWhatYouUse_COMMAND
    )

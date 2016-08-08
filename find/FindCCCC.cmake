# - Find cccc
#
# CCCC_EXECUTABLE - the cccc binary



find_program(
    CCCC_EXECUTABLE
    NAMES cccc
    DOC "C and C++ Code Counter, a software metrics tool"
    )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(cccc DEFAULT_MSG CCCC_EXECUTABLE)

mark_as_advanced(CCCC_EXECUTABLE)

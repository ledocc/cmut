include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()



#######################################################################################################################
#######################################################################################################################
#
# private functions
#
#######################################################################################################################
#######################################################################################################################

# __cmut__install__define_variables define variables use by cmut__install function/macro
#
macro(__cmut__install__define_variables)

    if(NOT __cmut__install__define_variables__done)

        set(cmut__install__generated_dir "${PROJECT_BINARY_DIR}")

        set(cmut__install__config_dir  "lib/cmake/${PROJECT_NAME}")
        set(cmut__install__include_dir "include")
        set(cmut__install__runtime_dir "bin")
        set(cmut__install__library_dir "lib")
        set(cmut__install__archive_dir "lib")
        set(cmut__install__framework_dir "lib")
        set(cmut__install__bundle_dir ".")
        set(cmut__install__private_header_dir "include")
        set(cmut__install__public_header_dir  "include")
        set(cmut__install__resource_dir       "resource")

        set(cmut__install__project_config "${cmut__install__config_dir}/${PROJECT_NAME}Config.cmake")
        set(cmut__install__version_config "${cmut__install__config_dir}/${PROJECT_NAME}ConfigVersion.cmake")
        set(cmut__install__export_namespace "${PROJECT_NAME}::")
        set(cmut__install__target_export_name_posfix "Target")

        set(__cmut__install__define_variables__done 1)

    endif()

endmacro()

#######################################################################################################################
#######################################################################################################################
#
# end private functions
#
#######################################################################################################################
#######################################################################################################################

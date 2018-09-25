

set(__CMUT__INSTALL__INSTALL_UNIX_LAUNCHER__SCRIPT_IN "${CMAKE_CURRENT_LIST_DIR}/unix_launcher.sh.in")


## cmut__install__install_unix_launcher( appName [EXEC_NAME execName][EXEC_DIR execDir][DESTINATION installPathDir][COMPONENT component] )
##
## install unix script to launch appName, this script define LD_LIBRARY_PATH on "execDir" directory, start "appName"
##   redirect stdout in appName.log.txt and stderr in appName.err.txt
##
## appName     : name of the installed script (appName.sh)
## EXEC_NAME   : name of the executable run by rhe script. Default = "appName"
## EXEC_DIR    : directory path of executable relative to installPathDir. Default = bin
## DESTINATION : directory where the script will be installed
## COMPONENT   : component use for this install

function(cmut__install__install_unix_launcher appName )

    if(NOT UNIX)
        cmut_warn("[cmut][install][install_unix_launcher] : not unix platform, \"${appName}\" launcher installation skipped.")
        return()
    endif()



    cmut__utils__parse_arguments(
        cmut__install__install_unix_launcher
        ARG
        ""
        "EXEC_NAME;EXEC_DIR;DESTINATION;COMPONENT"
        ""
        ${ARGN}
        )

    if(NOT ARG_EXEC_NAME)
        set(ARG_EXEC_NAME ${appName})
    endif()

    if(NOT ARG_EXEC_DIR)
        set(ARG_EXEC_DIR bin)
    endif()

    if(NOT ARG_DESTINATION)
        set(ARG_DESTINATION .)
    endif()

    if(NOT ARG_COMPONENT)
        set(ARG_COMPONENT)
    endif()



    configure_file( "${__CMUT__INSTALL__INSTALL_UNIX_LAUNCHER__SCRIPT_IN}" "${appName}.sh"  @ONLY)

    install(
        PROGRAMS "${CMAKE_CURRENT_BINARY_DIR}/${appName}.sh"
        DESTINATION "${ARG_DESTINATION}"
        COMPONENT ${ARG_COMPONENT}
        )

endfunction()

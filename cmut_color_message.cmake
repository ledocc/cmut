include(${CMAKE_CURRENT_LIST_DIR}/utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()


include(${CMAKE_CURRENT_LIST_DIR}/utils/cmut__utils__get_num_colors_to_screen.cmake)

set(ENV_CMUT_COLOR "$ENV{CMUT_COLOR}")
if(ENV_CMUT_COLOR STREQUAL "")
    set(ENV_CMUT_DISABLE_COLOR_MESSAGE "$ENV{CMUT_DISABLE_COLOR_MESSAGE}")
    if( NOT ENV_CMUT_DISABLE_COLOR_MESSAGE STREQUAL "" )
        message(STATUS "cmut environment variable \"CMUT_DISABLE_COLOR_MESSAGE\" is deprecated, prefer \"CMUT_COLOR\" instead")
        if(ENV_CMUT_DISABLE_COLOR_MESSAGE)
            set(ENV_CMUT_COLOR FALSE)
        endif()
    endif()
endif()
if(ENV_CMUT_COLOR STREQUAL "")
    set(ENV_CMUT_COLOR TRUE)
endif()
option(CMUT_COLOR "use color in cmut log." ${ENV_CMUT_COLOR})

#message(STATUS "CMUT_COLOR = ${CMUT_COLOR}")

if(CMUT_COLOR)

    if( "$ENV{SESSIONNAME}" STREQUAL "Console" )
        message(STATUS "use windows CMD color")    
        set(cmut_color_message_Bold          [1m)
        set(cmut_color_message_Reset         [0m)
        set(cmut_color_message_Standout      [0m)
        set(cmut_color_message_ExitStandout  )
        set(cmut_color_message_Underline     [4m)
        set(cmut_color_message_ExitUnderline [24m)
        set(cmut_color_message_Blink         )
        set(cmut_color_message_Black         [30m)
        set(cmut_color_message_Red           [31m)
        set(cmut_color_message_Green         [32m)
        set(cmut_color_message_Yellow        [33m)
        set(cmut_color_message_Blue          [34m)
        set(cmut_color_message_Magenta       [35m)
        set(cmut_color_message_Cyan          [36m)
        set(cmut_color_message_White         [37m)
        
    else()
    
        cmut__utils__get_num_colors_to_screen(__cmut_num_colors)
        if(__cmut_num_colors GREATER 1)
        
            cmut__utils__tput(cmut_color_message_Bold          bold)
            cmut__utils__tput(cmut_color_message_Reset         sgr0)
            cmut__utils__tput(cmut_color_message_Standout      smso)
            cmut__utils__tput(cmut_color_message_ExitStandout  rmso)
            cmut__utils__tput(cmut_color_message_Underline     smul)
            cmut__utils__tput(cmut_color_message_ExitUnderline rmul)
            cmut__utils__tput(cmut_color_message_Blink         blink)
            cmut__utils__tput(cmut_color_message_Black         setaf 0)
            cmut__utils__tput(cmut_color_message_Red           setaf 1)
            cmut__utils__tput(cmut_color_message_Green         setaf 2)
            cmut__utils__tput(cmut_color_message_Yellow        setaf 3)
            cmut__utils__tput(cmut_color_message_Blue          setaf 4)
            cmut__utils__tput(cmut_color_message_Magenta       setaf 5)
            cmut__utils__tput(cmut_color_message_Cyan          setaf 6)
            cmut__utils__tput(cmut_color_message_White         setaf 7)
            
        endif()
    endif()
endif()

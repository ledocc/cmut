include(${CMAKE_CURRENT_LIST_DIR}/utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()


include(${CMAKE_CURRENT_LIST_DIR}/utils/cmut__utils__get_num_colors_to_screen.cmake)

cmut__utils__get_num_colors_to_screen(__cmut_num_colors)
if($ENV{CMUT_DISABLE_COLOR_MESSAGE})
    set(__cmut_num_colors 1)
endif()


if(__cmut_num_colors GREATER 1)

    cmut__utils__tput(cmut_color_message_Bold      bold)
    cmut__utils__tput(cmut_color_message_Reset     sgr0)
    cmut__utils__tput(cmut_color_message_Standout  smso)
    cmut__utils__tput(cmut_color_message_ExitStandout  rmso)
    cmut__utils__tput(cmut_color_message_Underline smul)
    cmut__utils__tput(cmut_color_message_ExitUnderline rmul)
    cmut__utils__tput(cmut_color_message_Blink     blink)
    cmut__utils__tput(cmut_color_message_Black     setaf 0)
    cmut__utils__tput(cmut_color_message_Red       setaf 1)
    cmut__utils__tput(cmut_color_message_Green     setaf 2)
    cmut__utils__tput(cmut_color_message_Yellow    setaf 3)
    cmut__utils__tput(cmut_color_message_Blue      setaf 4)
    cmut__utils__tput(cmut_color_message_Magenta   setaf 5)
    cmut__utils__tput(cmut_color_message_Cyan      setaf 6)
    cmut__utils__tput(cmut_color_message_White     setaf 7)
endif()

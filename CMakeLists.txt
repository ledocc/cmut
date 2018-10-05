##--------------------------------------------------------------------------------------------------------------------##
# define minimum cmake version
##--------------------------------------------------------------------------------------------------------------------##
cmake_minimum_required(VERSION 3.12.0)
cmake_policy(VERSION 3.12)

include(cmut.cmake)


##--------------------------------------------------------------------------------------------------------------------##
# define project name/version
##--------------------------------------------------------------------------------------------------------------------##
project(cmut)
cmut__config__log_project_begin()
cmut__utils__set_project_version_from_file("${CMAKE_CURRENT_LIST_DIR}/version.txt")
cmut__utils__get_build_time(${PROJECT_NAME}_BUILD_TIME)




include(${CMAKE_CURRENT_LIST_DIR}/../utils/cmut__utils__header_guard.cmake)
cmut__utils__define_header_guard()

# This option controls the autodetect override.
# When ON, conan_cmake_autodetect doesn't get run.
# While using conan it does guarantee only the configuration from the current profile is being used.
function(cmut__config__option_no_autodetect defaultValue)

    option(CMUT__CONFIG__NO_AUTODETECT "Set to ON not to run conan_cmake_autodetect (potentially overriding profile)"  ${defaultValue})
    cmut__log__info("cmut__config" "No autodetect is ${CMUT__CONFIG__NO_AUTODETECT}")
    set(CMUT__CONFIG__OPTION_NO_AUTODETECT ${CMUT__CONFIG__NO_AUTODETECT} PARENT_SCOPE)

endfunction()

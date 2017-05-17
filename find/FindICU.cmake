# Finds the International Components for Unicode (ICU) Library
#
#  ICU_UC_FOUND       - True if ICU's commun library found.
#  ICU_I18N_FOUND     - True if ICU's internationalization library found.
#  ICU_DATA_FOUND     - True if ICU's data library found.
#
#  ICU_VERSION        - version of ICU found
#
#  ICU_INCLUDE_DIRS   - Directory to include to get ICU headers
#                       Note: always include ICU headers as, e.g.,
#                       unicode/utypes.h
#  ICU_UC_LIBRARIES   - Libraries to link against for the common ICU
#  ICU_I18N_LIBRARIES - Libraries to link against for ICU internationaliation
#                       (note: in addition to ICU_ICU_LIBRARIES)
#
#
#  icu::uc            - exported ICU common library target
#  icu::i18n          - exported ICU internationalization library target
#  icu::data          - exported ICU data library target


include(FindPackageHandleStandardArgs)



# Look for the header file.
find_path(
    ICU_INCLUDE_DIR
    NAMES unicode/utypes.h
    DOC "Include directory for the ICU library"
)
mark_as_advanced(ICU_INCLUDE_DIR)
set(ICU_INCLUDE_DIRS ${ICU_INCLUDE_DIR})


set(ICU_MAJOR_VERSION 0)
set(ICU_MINOR_VERSION 0)
if (EXISTS "${ICU_INCLUDE_DIR}/unicode/uvernum.h")
    FILE(READ "${ICU_INCLUDE_DIR}/unicode/uvernum.h" _ICU_VERSION_CONTENTS)
else()
    FILE(READ "${ICU_INCLUDE_DIR}/unicode/uversion.h" _ICU_VERSION_CONTENTS)
endif()

STRING(REGEX REPLACE ".*#define U_ICU_VERSION_MAJOR_NUM ([0-9]+).*" "\\1" ICU_MAJOR_VERSION "${_ICU_VERSION_CONTENTS}")
STRING(REGEX REPLACE ".*#define U_ICU_VERSION_MINOR_NUM ([0-9]+).*" "\\1" ICU_MINOR_VERSION "${_ICU_VERSION_CONTENTS}")

set(ICU_VERSION "${ICU_MAJOR_VERSION}.${ICU_MINOR_VERSION}")




macro(find_icu_library LIB_NAME)

    set(options "")
    set(oneValueArgs DOC)
    set(multiValueArgs NAMES)
    cmake_parse_arguments(__find_icu_library "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

    set(LIB_DOC    ${__find_icu_library_DOC})
    set(LIB_NAMES  ${__find_icu_library_NAMES})


    # Look for the library.
    find_library(
        ICU_${LIB_NAME}_LIBRARY
        NAMES ${LIB_NAMES}
        DOC "Libraries to link against for the common parts of ICU"
    )
    mark_as_advanced(ICU_${LIB_NAME}_LIBRARY)
    set(ICU_${LIB_NAME}_LIBRARIES ${ICU_${LIB_NAME}_LIBRARY})

    find_package_handle_standard_args(
        ICU_${LIB_NAME}
        REQUIRED_VARS
            ICU_INCLUDE_DIRS
            ICU_${LIB_NAME}_LIBRARIES
        VERSION_VAR
            ICU_VERSION
    )

    if(ICU_${LIB_NAME}_FOUND)

        string(TOLOWER ${LIB_NAME} lib_name)

        add_library(icu::${lib_name} STATIC IMPORTED)
        set_target_properties(
            icu::${lib_name}
            PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${ICU_INCLUDE_DIRS}"
        )

        set_target_properties(
            icu::${lib_name}
            PROPERTIES
                IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
                IMPORTED_LOCATION "${ICU_${LIB_NAME}_LIBRARY}"

                IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
                IMPORTED_LOCATION_RELEASE "${ICU_${LIB_NAME}_LIBRARY}"
        )
    endif()

endmacro()


find_icu_library(
    UC
    NAMES icuuc cygicuuc cygicuuc32
    DOC "Libraries to link against for the common parts of ICU"
)

find_icu_library(
    I18N
    NAMES icuin icui18n cygicuin cygicuin32
    DOC "Libraries to link against for ICU internationalization"
)

find_icu_library(
    DATA
    NAMES icudt icudata cygicudata cygicudata32
    DOC "Libraries to link against for ICU data"
)












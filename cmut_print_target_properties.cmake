
include(CMakePrintHelpers)


function(cmut_print_target_properties target)

    cmake_print_properties(
        TARGETS
            ${target}
        PROPERTIES
            LOCATION
            INTERFACE_INCLUDE_DIRECTORIES
            INTERFACE_LINK_LIBRARIES
    )

endfunction()



function(cmut_print_target_interface_properties target)

    cmake_print_properties(
        TARGETS
            ${target}
        PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES
            INTERFACE_LINK_LIBRARIES
    )

endfunction()



function(cmut_print_target_all_properties target CONFIG)

    cmake_print_properties(
        TARGETS
            ${target}
        PROPERTIES


        ALIASED_TARGET
        ANDROID_ANT_ADDITIONAL_OPTIONS
        ANDROID_API
        ANDROID_API_MIN
        ANDROID_ARCH
        ANDROID_ASSETS_DIRECTORIES
        ANDROID_GUI
        ANDROID_JAR_DEPENDENCIES
        ANDROID_JAR_DIRECTORIES
        ANDROID_JAVA_SOURCE_DIR
        ANDROID_NATIVE_LIB_DEPENDENCIES
        ANDROID_NATIVE_LIB_DIRECTORIES
        ANDROID_PROCESS_MAX
        ANDROID_PROGUARD
        ANDROID_PROGUARD_CONFIG_PATH
        ANDROID_SECURE_PROPS_PATH
        ANDROID_SKIP_ANT_STEP
        ANDROID_STL_TYPE
        ARCHIVE_OUTPUT_DIRECTORY_${CONFIG}
        ARCHIVE_OUTPUT_DIRECTORY
        ARCHIVE_OUTPUT_NAME_${CONFIG}
        ARCHIVE_OUTPUT_NAME
        AUTOGEN_TARGET_DEPENDS
        AUTOMOC_MOC_OPTIONS
        AUTOMOC
        AUTOUIC
        AUTOUIC_OPTIONS
        AUTORCC
        AUTORCC_OPTIONS
        BINARY_DIR
        BUILD_WITH_INSTALL_RPATH
        BUNDLE_EXTENSION
        BUNDLE
        C_EXTENSIONS
        C_STANDARD
        C_STANDARD_REQUIRED
        COMPATIBLE_INTERFACE_BOOL
        COMPATIBLE_INTERFACE_NUMBER_MAX
        COMPATIBLE_INTERFACE_NUMBER_MIN
        COMPATIBLE_INTERFACE_STRING
        COMPILE_DEFINITIONS
        COMPILE_FEATURES
        COMPILE_FLAGS
        COMPILE_OPTIONS
        COMPILE_PDB_NAME
        COMPILE_PDB_NAME_${CONFIG}
        COMPILE_PDB_OUTPUT_DIRECTORY
        COMPILE_PDB_OUTPUT_DIRECTORY_${CONFIG}
        ${CONFIG}_OUTPUT_NAME
        ${CONFIG}_POSTFIX
        CROSSCOMPILING_EMULATOR
        CXX_EXTENSIONS
        CXX_STANDARD
        CXX_STANDARD_REQUIRED
        DEBUG_POSTFIX
        DEFINE_SYMBOL
        DEPLOYMENT_REMOTE_DIRECTORY
        EchoString
        ENABLE_EXPORTS
        EXCLUDE_FROM_ALL
        EXCLUDE_FROM_DEFAULT_BUILD_${CONFIG}
        EXCLUDE_FROM_DEFAULT_BUILD
        EXPORT_NAME
        FOLDER
        Fortran_FORMAT
        Fortran_MODULE_DIRECTORY
        FRAMEWORK
        FRAMEWORK_VERSION
        GENERATOR_FILE_NAME
        GNUtoMS
        HAS_CXX
        IMPLICIT_DEPENDS_INCLUDE_TRANSFORM
        IMPORTED_CONFIGURATIONS
        IMPORTED_IMPLIB_${CONFIG}
        IMPORTED_IMPLIB
        IMPORTED_LINK_DEPENDENT_LIBRARIES_${CONFIG}
        IMPORTED_LINK_DEPENDENT_LIBRARIES
        IMPORTED_LINK_INTERFACE_LANGUAGES_${CONFIG}
        IMPORTED_LINK_INTERFACE_LANGUAGES
        IMPORTED_LINK_INTERFACE_LIBRARIES_${CONFIG}
        IMPORTED_LINK_INTERFACE_LIBRARIES
        IMPORTED_LINK_INTERFACE_MULTIPLICITY_${CONFIG}
        IMPORTED_LINK_INTERFACE_MULTIPLICITY
        IMPORTED_LOCATION_${CONFIG}
        IMPORTED_LOCATION
        IMPORTED_NO_SONAME_${CONFIG}
        IMPORTED_NO_SONAME
        IMPORTED
        IMPORTED_SONAME_${CONFIG}
        IMPORTED_SONAME
        IMPORT_PREFIX
        IMPORT_SUFFIX
        INCLUDE_DIRECTORIES
        INSTALL_NAME_DIR
        INSTALL_RPATH
        INSTALL_RPATH_USE_LINK_PATH
        INTERFACE_AUTOUIC_OPTIONS
        INTERFACE_COMPILE_DEFINITIONS
        INTERFACE_COMPILE_FEATURES
        INTERFACE_COMPILE_OPTIONS
        INTERFACE_INCLUDE_DIRECTORIES
        INTERFACE_LINK_LIBRARIES
        INTERFACE_POSITION_INDEPENDENT_CODE
        INTERFACE_SOURCES
        INTERFACE_SYSTEM_INCLUDE_DIRECTORIES
        INTERPROCEDURAL_OPTIMIZATION_${CONFIG}
        INTERPROCEDURAL_OPTIMIZATION
        IOS_INSTALL_COMBINED
        JOB_POOL_COMPILE
        JOB_POOL_LINK
        LABELS
        <LANG>_CLANG_TIDY
        <LANG>_COMPILER_LAUNCHER
        <LANG>_INCLUDE_WHAT_YOU_USE
        <LANG>_VISIBILITY_PRESET
        LIBRARY_OUTPUT_DIRECTORY_${CONFIG}
        LIBRARY_OUTPUT_DIRECTORY
        LIBRARY_OUTPUT_NAME_${CONFIG}
        LIBRARY_OUTPUT_NAME
        LINK_DEPENDS_NO_SHARED
        LINK_DEPENDS
        LINKER_LANGUAGE
        LINK_FLAGS_${CONFIG}
        LINK_FLAGS
        LINK_INTERFACE_LIBRARIES_${CONFIG}
        LINK_INTERFACE_LIBRARIES
        LINK_INTERFACE_MULTIPLICITY_${CONFIG}
        LINK_INTERFACE_MULTIPLICITY
        LINK_LIBRARIES
        LINK_SEARCH_END_STATIC
        LINK_SEARCH_START_STATIC
        LOCATION_${CONFIG}
        LOCATION
        MACOSX_BUNDLE_INFO_PLIST
        MACOSX_BUNDLE
        MACOSX_FRAMEWORK_INFO_PLIST
        MACOSX_RPATH
        MAP_IMPORTED_CONFIG_${CONFIG}
        NAME
        NO_SONAME
        NO_SYSTEM_FROM_IMPORTED
        OSX_ARCHITECTURES_${CONFIG}
        OSX_ARCHITECTURES
        OUTPUT_NAME_${CONFIG}
        OUTPUT_NAME
        PDB_NAME_${CONFIG}
        PDB_NAME
        PDB_OUTPUT_DIRECTORY_${CONFIG}
        PDB_OUTPUT_DIRECTORY
        POSITION_INDEPENDENT_CODE
        PREFIX
        PRIVATE_HEADER
        PROJECT_LABEL
        PUBLIC_HEADER
        RESOURCE
        RULE_LAUNCH_COMPILE
        RULE_LAUNCH_CUSTOM
        RULE_LAUNCH_LINK
        RUNTIME_OUTPUT_DIRECTORY_${CONFIG}
        RUNTIME_OUTPUT_DIRECTORY
        RUNTIME_OUTPUT_NAME_${CONFIG}
        RUNTIME_OUTPUT_NAME
        SKIP_BUILD_RPATH
        SOURCE_DIR
        #SOURCES
        SOVERSION
        STATIC_LIBRARY_FLAGS_${CONFIG}
        STATIC_LIBRARY_FLAGS
        SUFFIX
        TYPE
        VERSION
        VISIBILITY_INLINES_HIDDEN
        VS_CONFIGURATION_TYPE
        VS_DESKTOP_EXTENSIONS_VERSION
        VS_DOTNET_REFERENCES
        VS_DOTNET_TARGET_FRAMEWORK_VERSION
        VS_GLOBAL_KEYWORD
        VS_GLOBAL_PROJECT_TYPES
        VS_GLOBAL_ROOTNAMESPACE
        VS_IOT_EXTENSIONS_VERSION
        VS_IOT_STARTUP_TASK
        VS_KEYWORD
        VS_MOBILE_EXTENSIONS_VERSION
        VS_SCC_AUXPATH
        VS_SCC_LOCALPATH
        VS_SCC_PROJECTNAME
        VS_SCC_PROVIDER
        VS_WINDOWS_TARGET_PLATFORM_MIN_VERSION
        VS_WINRT_COMPONENT
        VS_WINRT_EXTENSIONS
        VS_WINRT_REFERENCES
        WIN32_EXECUTABLE
        WINDOWS_EXPORT_ALL_SYMBOLS
        XCTEST
    )

endfunction()
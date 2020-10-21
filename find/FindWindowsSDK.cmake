# - Find WindowsSDK
#
# WINSDK_DIR - the WindowsSDK root directory
# D3DCOMPILER_DLL - the d3dcompiler_*.dll library


set(SDK_VERSION_LIST 10.0.18262.0)
set(SDK_SEARCH_PATH "c:/Program Files (x86)/Windows Kits/10")

if(CMAKE_SIZEOF_VOID_P EQUAL 4)
    set(ARCH_PREFIX x86)
else(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(ARCH_PREFIX x64)
else()
    cmut__log__error(FindWindowsSDK "can't determine architecture prefix to use (x86 or x64).")
endif()

find_path(
    WINSDK_DIR
    SDKManifest
    PATH "${SDK_SEARCH_PATH}"
    NO_DEFAULT_PATH
    )

find_file(
    D3DCOMPILER_DLL
    d3dcompiler_47.dll
    PATH "${WINSDK_DIR}/Redist/D3D/${ARCH_PREFIX}"
    )


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    WINSDK
    DEFAULT_MSG
    WINSDK_DIR D3DCOMPILER_DLL
    )





include("${CMUT_ROOT}/utils/cmut__utils__fixup_dylib.cmake")
include("${CMUT_ROOT}/utils/cmut__utils__chmod.cmake")

cmake_policy(SET CMP0011 NEW)
cmake_policy(SET CMP0009 NEW)




function(cmut__install__fixup_bundle_dylib bundleApp)

    # fixup dylib in ${bundleApp}.app to use @rpath instead of @executable_path
    cmut_info("MacOS dir      = ${bundleApp}/Contents/MacOS/*.dylib")
    cmut_info("Frameworks dir = ${bundleApp}/Contents/Frameworks/*.framework")


    file(GLOB_RECURSE dylibs
         LIST_DIRECTORIES false "${bundleApp}/Contents/*.dylib")
    cmut_info("dylibs          = ${dylibs}")

    file(GLOB framework_dirs
         LIST_DIRECTORIES true "${bundleApp}/Contents/Frameworks/*.framework")
    foreach(framework_dir ${framework_dirs})
        get_filename_component(framework_name "${framework_dir}" NAME_WE)
        list(APPEND frameworks "${framework_dir}/${framework_name}")
    endforeach()
    cmut_info("frameworks = ${frameworks}")

    foreach(dylib ${dylibs} ${frameworks})
        cmut_info("current dylib     = ${dylib}")
        cmut__utils__chmod("${dylib}" 755)
        cmut__utils__fixup_dylib_id("${dylib}")
        cmut__utils__fixup_dylib_dependencies("${dylib}" "@executable_path/../MacOS")
        cmut__utils__fixup_dylib_dependencies("${dylib}" "@executable_path/../Frameworks")
    endforeach()



    get_filename_component(exe ${bundleApp} NAME_WE)
    set(bundleExe "${bundleApp}/Contents/MacOS/${exe}")
    cmut__utils__install_name_tool(result -add_rpath "@loader_path" "${bundleExe}")
    cmut__utils__install_name_tool(result -add_rpath "@loader_path/../Frameworks" "${bundleExe}")

#    set(qtWebEngineProcess "${bundleApp}/Contents/Frameworks/QtWebEngineCore.framework/Helpers/QtWebEngineProcess.app/Contents/MacOS/QtWebEngineProcess")
#    cmut__utils__install_name_tool(result -add_rpath "@loader_path/../../../../../../../../MacOS" "${qtWebEngineProcess}")

endfunction()

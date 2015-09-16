
#define function cmut_is_release_bin(result bin)
# result : bool set to 1 if ${bin} is build in release mode
# bin : binary file to test

# cmut_is_release_bin try to determine if the binary file give in parameter is build in release mode.
#
# on windows/msvc, it use dumpbin to search in dependency if msvc[0-9]*d.dll is found. If yes, the binary is build in debug mode. 






if(MSVC)
    function(cmut_is_release_bin result bin)
        execute_process( COMMAND dumpbin /DEPENDENTS "${bin}"
                         COMMAND findstr /I "msvcp[0-9]*d.dll"
                         RESULT_VARIABLE __intenal_result
                         OUTPUT_QUIET
                         ERROR_QUIET )
         set(${result} ${__intenal_result} PARENT_SCOPE)
    endfunction()

else()
    function(cmut_is_release_bin result bin)
        set(${result} ${result}-NOTFOUND PARENT_SCOPE)
    endfunction()
endif()
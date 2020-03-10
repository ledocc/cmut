
include("${CMAKE_CURRENT_LIST_DIR}/../cmut__unit_test__check.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/../../lang/copy_if_defined.cmake")


function(cmut__unit_test__lang__copy_if_defined)

    unset(VAR_TO_TEST)
    set(dst toto)

    cmut__lang__copy_if_defined(VAR_TO_TEST dst)
    cmut__unit_test__check(cmut__unit_test__lang__copy_if_defined__not_defined ${dst} STREQUAL "toto")

    set(VAR_TO_TEST titi)
    cmut__lang__copy_if_defined(VAR_TO_TEST dst)
    cmut__unit_test__check(cmut__unit_test__lang__copy_if_defined__happy_path ${dst} STREQUAL "titi")

endfunction()

cmut__unit_test__lang__copy_if_defined()

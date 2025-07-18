# Registers the cmake/module.cmake file in the AFTER_SRC_LOAD hook
# @author Abracadaniel22

CU_ADD_HOOK(AFTER_SRC_LOAD "${CMAKE_CURRENT_SOURCE_DIR}/cmake/module.cmake")
# Copies the required DBC files to the server once
# @author Abracadaniel22

function(should_skip_copy SRC_FILE DEST_FILE SKIP_VAR)
  if(EXISTS "${DEST_FILE}")
    file(SIZE "${SRC_FILE}" SOURCE_SIZE)
    file(SIZE "${DEST_FILE}" DEST_SIZE)
    
    if(SOURCE_SIZE EQUAL DEST_SIZE)
      file(MD5 "${SRC_FILE}" SOURCE_MD5)
      file(MD5 "${DEST_FILE}" DEST_MD5)
      
      if(SOURCE_MD5 STREQUAL DEST_MD5)
        set(${SKIP_VAR} TRUE PARENT_SCOPE)
        return()
      endif()
    endif()
  endif()
  
  set(${SKIP_VAR} FALSE PARENT_SCOPE)
endfunction()

file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/data/dbc")
file(GLOB_RECURSE DBC_FILES "${CMAKE_CURRENT_SOURCE_DIR}/modules/mod-fly-anywhere/data/patch/server/*.dbc")

foreach(DBC_FILE ${DBC_FILES}) 
  get_filename_component(FILE_NAME "${DBC_FILE}" NAME) 
  set(DEST_FILE "${CMAKE_BINARY_DIR}/data/dbc/${FILE_NAME}") 
  set(BACKUP_FILE "${CMAKE_BINARY_DIR}/data/dbc/${FILE_NAME}.backup")

  should_skip_copy("${DBC_FILE}" "${DEST_FILE}" DBC_FILE_ALREADY_COPIED)
  if(DBC_FILE_ALREADY_COPIED)
    message(STATUS "[mod-fly-anywhere] Skipping ${FILE_NAME}: identical file already exists")
    continue()
  else()
    if(EXISTS "${DEST_FILE}") 
      message(STATUS "[mod-fly-anywhere] Backing up existing ${DEST_FILE} to ${BACKUP_FILE}") 
      file(RENAME "${DEST_FILE}" "${BACKUP_FILE}") 
    endif()
    message(STATUS "[mod-fly-anywhere] Copying ${DBC_FILE} to ${CMAKE_BINARY_DIR}/data/dbc") 
    file(COPY "${DBC_FILE}" DESTINATION "${CMAKE_BINARY_DIR}/data/dbc") 
  endif()
endforeach()

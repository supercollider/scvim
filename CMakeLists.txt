IF(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  install(FILES sc/SCVim.sc
    DESTINATION "$ENV{HOME}/Library/Application Support/SuperCollider/Extensions/scide_scvim"
    PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ)
ELSE()
  install(FILES sc/SCVim.sc
    DESTINATION share/SuperCollider/Extensions/scide_scvim
    PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ)
ENDIF()

IF(NOT TARGET uninstall)
  configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
    IMMEDIATE @ONLY)

  add_custom_target(uninstall
    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake)
ENDIF(NOT TARGET uninstall)

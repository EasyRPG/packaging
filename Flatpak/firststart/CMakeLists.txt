cmake_minimum_required(VERSION 3.18)

project(EasyRPG-Flatpak-firststart VERSION 1.0)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/CMakeModules)
include(GlibCompileResourcesSupport)

# resources

set(RES_PREFIX "/org/easyrpg/firststart/")
list(APPEND RESOURCES STRIPBLANKS ui/assistant.glade)
compile_gresources(RESOURCE_OUT XML_OUT TYPE EMBED_C
    PREFIX ${RES_PREFIX} RESOURCES ${RESOURCES})

add_custom_target(resources DEPENDS ${RESOURCE_OUT})

# libraries

include(FindPkgConfig)
find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK gtk+-3.0 REQUIRED)

# executable

add_executable(firststart
    src/main.c
    src/mkdir_p.h
    src/mkdir_p.c
    ${RESOURCE_OUT})
target_compile_definitions(firststart PRIVATE RES_PREFIX="${RES_PREFIX}")
set_property(TARGET firststart PROPERTY C_STANDARD 11)
target_link_libraries(firststart PRIVATE ${GTK_LIBRARIES})
target_include_directories(firststart PRIVATE ${GTK_INCLUDE_DIRS})
target_link_directories(firststart PRIVATE ${GTK_LIBRARY_DIRS})
target_compile_options(firststart PRIVATE ${GTK_CFLAGS_OTHER})
target_link_options(firststart PRIVATE "-rdynamic") # needed for signal handlers

# installation

include(GNUInstallDirs)
install(TARGETS firststart
        RUNTIME DESTINATION bin)

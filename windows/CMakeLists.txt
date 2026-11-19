# Project-level configuration.
cmake_minimum_required(VERSION 3.14)
project(meshcore_open LANGUAGES CXX)

# The name of the executable created for the application. Change this to change
# the on-disk name of your application.
set(BINARY_NAME "meshcore_open")

# Explicitly opt in to modern CMake behaviors to avoid warnings with recent
# versions of CMake.
cmake_policy(VERSION 3.14...3.25)

# Define build configuration option.
get_property(IS_MULTICONFIG GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
if(IS_MULTICONFIG)
  set(CMAKE_CONFIGURATION_TYPES "Debug;Profile;Release"
    CACHE STRING "" FORCE)
else()
  if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE "Debug" CACHE
      STRING "Flutter build mode" FORCE)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
      "Debug" "Profile" "Release")
  endif()
endif()
# Define settings for the Profile build mode.
set(CMAKE_EXE_LINKER_FLAGS_PROFILE "${CMAKE_EXE_LINKER_FLAGS_RELEASE}")
set(CMAKE_SHARED_LINKER_FLAGS_PROFILE "${CMAKE_SHARED_LINKER_FLAGS_RELEASE}")
set(CMAKE_C_FLAGS_PROFILE "${CMAKE_C_FLAGS_RELEASE}")
set(CMAKE_CXX_FLAGS_PROFILE "${CMAKE_CXX_FLAGS_RELEASE}")

# Use Unicode for all projects.
add_definitions(-DUNICODE -D_UNICODE)

# Compilation settings that should be applied to most targets.
#
# Be cautious about adding new options here, as plugins use this function by
# default. In most cases, you should add new options to specific targets instead
# of modifying this function.
function(APPLY_STANDARD_SETTINGS TARGET)
  target_compile_features(${TARGET} PUBLIC cxx_std_17)
  target_compile_options(${TARGET} PRIVATE /W4 /WX /wd"4100")
  target_compile_options(${TARGET} PRIVATE /EHsc)
  target_compile_definitions(${TARGET} PRIVATE "_HAS_EXCEPTIONS=0")
  target_compile_definitions(${TARGET} PRIVATE "$<$<CONFIG:Debug>:_DEBUG>")
endfunction()

# Flutter library and tool build rules.
set(FLUTTER_MANAGED_DIR "${CMAKE_CURRENT_SOURCE_DIR}/flutter")
add_subdirectory(${FLUTTER_MANAGED_DIR})

# Application build; see runner/CMakeLists.txt.
add_subdirectory("runner")


# ONNX Runtime for flutter_onnxruntime. The plugin normally downloads it from
# the github.com/microsoft/onnxruntime releases page, which now returns 404, so
# the Windows build fails. Fetch Microsoft's official NuGet package instead
# (hash-checked) and unpack it into the exact folder the plugin checks first.
# The plugin then skips its own download and still ships onnxruntime.dll with
# the app. Must run before generated_plugins.cmake.
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  set(ONNXRUNTIME_VERSION "1.28.0")
  set(_ort_sha256 "769d1d3ea8ab6cd69f737c9dd4d4462aa4ad0ccfa106eaf506efc40d7bead5db")
  set(_ort_dir "${CMAKE_BINARY_DIR}/plugins/flutter_onnxruntime/onnxruntime/onnxruntime-win-x64-${ONNXRUNTIME_VERSION}")
  if(NOT EXISTS "${_ort_dir}/include/onnxruntime_cxx_api.h")
    set(_ort_pkg "${CMAKE_BINARY_DIR}/onnxruntime-${ONNXRUNTIME_VERSION}.nupkg")
    set(_ort_tmp "${CMAKE_BINARY_DIR}/onnxruntime-nupkg")
    message(STATUS "Fetching ONNX Runtime ${ONNXRUNTIME_VERSION} from NuGet")
    file(DOWNLOAD
      "https://api.nuget.org/v3-flatcontainer/microsoft.ml.onnxruntime/${ONNXRUNTIME_VERSION}/microsoft.ml.onnxruntime.${ONNXRUNTIME_VERSION}.nupkg"
      "${_ort_pkg}"
      EXPECTED_HASH SHA256=${_ort_sha256}
      STATUS _ort_status)
    list(GET _ort_status 0 _ort_code)
    if(NOT _ort_code EQUAL 0)
      message(FATAL_ERROR "ONNX Runtime NuGet download failed: ${_ort_status}")
    endif()
    file(REMOVE_RECURSE "${_ort_tmp}")
    file(MAKE_DIRECTORY "${_ort_tmp}")
    execute_process(COMMAND ${CMAKE_COMMAND} -E tar xf "${_ort_pkg}"
                    WORKING_DIRECTORY "${_ort_tmp}" RESULT_VARIABLE _ort_rc)
    if(NOT _ort_rc EQUAL 0)
      message(FATAL_ERROR "Could not unpack ONNX Runtime NuGet package")
    endif()
    file(MAKE_DIRECTORY "${_ort_dir}/include" "${_ort_dir}/lib")
    file(GLOB _ort_headers "${_ort_tmp}/build/native/include/*")
    file(GLOB _ort_bins "${_ort_tmp}/runtimes/win-x64/native/*")
    file(COPY ${_ort_headers} DESTINATION "${_ort_dir}/include")
    file(COPY ${_ort_bins} DESTINATION "${_ort_dir}/lib")
    file(REMOVE_RECURSE "${_ort_tmp}")
    file(REMOVE "${_ort_pkg}")
  endif()
endif()

# Generated plugin build rules, which manage building the plugins and adding
# them to the application.
include(flutter/generated_plugins.cmake)


# === Installation ===
# Support files are copied into place next to the executable, so that it can
# run in place. This is done instead of making a separate bundle (as on Linux)
# so that building and running from within Visual Studio will work.
set(BUILD_BUNDLE_DIR "$<TARGET_FILE_DIR:${BINARY_NAME}>")
# Make the "install" step default, as it's required to run.
set(CMAKE_VS_INCLUDE_INSTALL_TO_DEFAULT_BUILD 1)
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "${BUILD_BUNDLE_DIR}" CACHE PATH "..." FORCE)
endif()

set(INSTALL_BUNDLE_DATA_DIR "${CMAKE_INSTALL_PREFIX}/data")
set(INSTALL_BUNDLE_LIB_DIR "${CMAKE_INSTALL_PREFIX}")

install(TARGETS ${BINARY_NAME} RUNTIME DESTINATION "${CMAKE_INSTALL_PREFIX}"
  COMPONENT Runtime)

install(FILES "${FLUTTER_ICU_DATA_FILE}" DESTINATION "${INSTALL_BUNDLE_DATA_DIR}"
  COMPONENT Runtime)

install(FILES "${FLUTTER_LIBRARY}" DESTINATION "${INSTALL_BUNDLE_LIB_DIR}"
  COMPONENT Runtime)

if(PLUGIN_BUNDLED_LIBRARIES)
  install(FILES "${PLUGIN_BUNDLED_LIBRARIES}"
    DESTINATION "${INSTALL_BUNDLE_LIB_DIR}"
    COMPONENT Runtime)
endif()

# Copy the native assets provided by the build.dart from all packages.
set(NATIVE_ASSETS_DIR "${PROJECT_BUILD_DIR}native_assets/windows/")
if(EXISTS "${NATIVE_ASSETS_DIR}")
  install(DIRECTORY "${NATIVE_ASSETS_DIR}"
    DESTINATION "${INSTALL_BUNDLE_LIB_DIR}"
    COMPONENT Runtime)
endif()

# Fully re-copy the assets directory on each build to avoid having stale files
# from a previous install.
set(FLUTTER_ASSET_DIR_NAME "flutter_assets")
install(CODE "
  file(REMOVE_RECURSE \"${INSTALL_BUNDLE_DATA_DIR}/${FLUTTER_ASSET_DIR_NAME}\")
  " COMPONENT Runtime)
install(DIRECTORY "${PROJECT_BUILD_DIR}/${FLUTTER_ASSET_DIR_NAME}"
  DESTINATION "${INSTALL_BUNDLE_DATA_DIR}" COMPONENT Runtime)

# Install the AOT library on non-Debug builds only.
install(FILES "${AOT_LIBRARY}" DESTINATION "${INSTALL_BUNDLE_DATA_DIR}"
  CONFIGURATIONS Profile;Release
  COMPONENT Runtime)

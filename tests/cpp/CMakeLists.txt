# Using GLOB could be a bad idea (but use it for the tests)
# https://stackoverflow.com/questions/32411963/why-is-cmake-file-glob-evil

# With GLOB:
file(GLOB TEST_SOURCES test_*.cpp)
# Without GLOB:
#set(TEST_SOURCES 
#  test_Francky.cpp)
#  test_SPDEDrift.cpp)

# Add test_HDF5 if supported
if (USE_HDF5)
  list(APPEND TEST_SOURCES ztest_HDF5.cpp)
endif()

# Generation folder
cmake_path(APPEND CMAKE_CURRENT_BINARY_DIR ${CMAKE_BUILD_TYPE}
           OUTPUT_VARIABLE GLOBAL_DST_DIR)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${GLOBAL_DST_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${GLOBAL_DST_DIR})

# Create the output directory (logs)
cmake_path(APPEND GLOBAL_DST_DIR output
           OUTPUT_VARIABLE TEST_DST_DIR)
file(MAKE_DIRECTORY ${TEST_DST_DIR})

# Compile each test executable
set(TARGETS_EXE "")
foreach(TEST_SOURCE_FILE ${TEST_SOURCES})
    # Retrieve source file name without extension (will become executable name)
    get_filename_component(TEST_NAME ${TEST_SOURCE_FILE} NAME_WE)
    # Add to executable targets list
    list(APPEND TARGETS_EXE ${TEST_NAME})
    # Define sources list for the target executable
    add_executable(${TEST_NAME} EXCLUDE_FROM_ALL ${TEST_SOURCE_FILE})
    # Link gstlearn to each test
    target_link_libraries(${TEST_NAME} PRIVATE ${PROJECT_NAME}::shared)
    # Trigger the build of the test with the target build_tests
    add_dependencies(build_tests ${TEST_NAME})
endforeach(TEST_SOURCE_FILE ${TEST_SOURCES})

# Display test output in case of failure
set(CTEST_OUTPUT_ON_FAILURE ON)

# Run each registered executable
foreach(TARGET_EXE ${TARGETS_EXE})
    # Run the test (and generate *.out in ${TEST_DST_DIR})
    add_test(NAME ${TARGET_EXE}
             COMMAND ${TARGET_EXE}
             WORKING_DIRECTORY ${TEST_DST_DIR})
    # Compare the output result (diff output is shown when CTEST_OUTPUT_ON_FAILURE=1)
    add_test(NAME ${TARGET_EXE}_cmp
             COMMAND diff --strip-trailing-cr ${CMAKE_CURRENT_SOURCE_DIR}/output/${TARGET_EXE}.ref ${TEST_DST_DIR}/${TARGET_EXE}.out
             WORKING_DIRECTORY ${TEST_DST_DIR})
endforeach(TARGET_EXE ${TARGETS_EXE})

# Look parent CMakeLists for MY_CTEST_COMMAND definition
if (WIN32)
  # Need to copy C++ shared library to tests directory
  add_custom_target(check_cpp
    COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:${PROJECT_NAME}::shared> ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
    COMMAND ${MY_CTEST_COMMAND} DEPENDS ${TARGETS_EXE}
  )
else()
  add_custom_target(check_cpp
    COMMAND ${MY_CTEST_COMMAND} DEPENDS ${TARGETS_EXE}
  )
endif()

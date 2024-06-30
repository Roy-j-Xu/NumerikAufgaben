# Set the minimum version of CMake that can be used
# To find the cmake version run
# $ cmake --version
cmake_minimum_required(VERSION 3.5)

# Set the project name
project(aufgabe9)

# Create a sources variable with a link to all cpp files to compile
set(HELPER
    src/helper.c
    src/vorrueckwaertsub.c
    src/lrmp.c
    src/Broyden.c
)

# Add an executable with the above sources
add_executable(TEST test/helperTest.c ${HELPER})
add_executable(PROB_1 test/BroydenTest.c ${HELPER})
add_executable(PROB_2 test/problem2.c ${HELPER})
add_executable(PROB_3 test/problem3.c ${HELPER})

# Set the directories that should be included in the build command for this target
# when running g++ these will be included as -I/directory/path/
include_directories(include)

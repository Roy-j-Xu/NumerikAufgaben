# Set the minimum version of CMake that can be used
# To find the cmake version run
# $ cmake --version
cmake_minimum_required(VERSION 3.5)

# Set the project name
project(aufgabe6)

# Create a sources variable with a link to all cpp files to compile
set(HELPER
    src/helper.c
    src/vorrueckwaertsub.c
)

set(SRC_0
    test/helperTest.c
)

set(SRC_1
    src/HouseQR.c
    test/HouseQRTest.c
)

set(SRC_2
    src/HouseQR.c
    src/LinAusHouse.c
    test/LinAusHouseTest.c
)

set(SRC_3
    test/problem4.c
)

# Add an executable with the above sources
add_executable(TEST ${SRC_0} ${HELPER})
add_executable(PROB_1 ${SRC_1} ${HELPER})
add_executable(PROB_23 ${SRC_2} ${HELPER})
add_executable(PROB_4 ${SRC_2} ${HELPER})


# Set the directories that should be included in the build command for this target
# when running g++ these will be included as -I/directory/path/
include_directories(include)

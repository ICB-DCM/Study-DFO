project(erbb_standard)

cmake_minimum_required(VERSION 2.8)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(CheckCXXCompilerFlag)
set(MY_CXX_FLAGS -Wall -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable)
foreach(FLAG ${MY_CXX_FLAGS})
    unset(CUR_FLAG_SUPPORTED CACHE)
    CHECK_CXX_COMPILER_FLAG(${FLAG} CUR_FLAG_SUPPORTED)
    if(${CUR_FLAG_SUPPORTED})
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${FLAG}")
    endif()
endforeach(FLAG)

find_package(Amici HINTS ${CMAKE_CURRENT_LIST_DIR}/../../build)
get_property(AmiciConfigIncludes TARGET Upstream::amici PROPERTY INCLUDE_DIRECTORIES)

set(MODEL_DIR "${Amici_DIR}/../models/erbb_standard")

include_directories("${CMAKE_CURRENT_SOURCE_DIR}")
include_directories(${AmiciConfigIncludes})

set(SRC_LIST_LIB ${MODEL_DIR}/erbb_standard_J.cpp
${MODEL_DIR}/erbb_standard_JB.cpp
${MODEL_DIR}/erbb_standard_JDiag.cpp
${MODEL_DIR}/erbb_standard_JSparse.cpp
${MODEL_DIR}/erbb_standard_JSparseB.cpp
${MODEL_DIR}/erbb_standard_Jv.cpp
${MODEL_DIR}/erbb_standard_JvB.cpp
${MODEL_DIR}/erbb_standard_Jy.cpp
${MODEL_DIR}/erbb_standard_dJydsigma.cpp
${MODEL_DIR}/erbb_standard_dJydy.cpp
${MODEL_DIR}/erbb_standard_deltasx.cpp
${MODEL_DIR}/erbb_standard_dwdp.cpp
${MODEL_DIR}/erbb_standard_dwdx.cpp
${MODEL_DIR}/erbb_standard_dxdotdp.cpp
${MODEL_DIR}/erbb_standard_dydp.cpp
${MODEL_DIR}/erbb_standard_dydx.cpp
${MODEL_DIR}/erbb_standard_qBdot.cpp
${MODEL_DIR}/erbb_standard_root.cpp
${MODEL_DIR}/erbb_standard_sigma_y.cpp
${MODEL_DIR}/erbb_standard_sxdot.cpp
${MODEL_DIR}/erbb_standard_w.cpp
${MODEL_DIR}/erbb_standard_x0.cpp
${MODEL_DIR}/erbb_standard_xBdot.cpp
${MODEL_DIR}/erbb_standard_xdot.cpp
${MODEL_DIR}/erbb_standard_y.cpp

${MODEL_DIR}/wrapfunctions.cpp
)
    
add_library(${PROJECT_NAME} ${SRC_LIST_LIB})
    
target_link_libraries(
    ${PROJECT_NAME}
    Upstream::amici
)

set(SRC_LIST_EXE main.cpp)

add_executable(simulate_${PROJECT_NAME} ${SRC_LIST_EXE})
    
target_link_libraries(simulate_${PROJECT_NAME} ${PROJECT_NAME} Upstream::amici)

if($ENV{ENABLE_GCOV_COVERAGE})
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0 --coverage")
endif()

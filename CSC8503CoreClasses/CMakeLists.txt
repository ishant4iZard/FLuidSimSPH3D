set(PROJECT_NAME CSC8503CoreClasses)

################################################################################
# Source groups
################################################################################
set(Collision_Detection
    "AABBVolume.h"
    "CapsuleVolume.h"  
    "CollisionDetection.h"
    "CollisionDetection.cpp"
    "CollisionVolume.h"
    "OBBVolume.h"
    "QuadTree.h"
    "QuadTree.cpp"
    "Ray.h"
    "SphereVolume.h"
)
source_group("Collision Detection" FILES ${Collision_Detection})

set(Physics
    "constraint.h"  
    "constraint.h"  
    "PositionConstraint.cpp"
    "PositionConstraint.h"
    "OrientationConstraint.cpp"
    "OrientationConstraint.h"
    "PhysicsObject.cpp"
    "PhysicsObject.h"
    "PhysicsSystem.cpp"
    "PhysicsSystem.h"
)
source_group("Physics" FILES ${Physics})

set(Header_Files
    "Debug.h"
    "GameObject.h"
    "GameWorld.h"
    "RenderObject.h"
    "Transform.h"
)
source_group("Header Files" FILES ${Header_Files})

set(Source_Files
    "Debug.cpp"
    "GameObject.cpp"
    "GameWorld.cpp"
    "RenderObject.cpp"
    "Transform.cpp"
)
source_group("Source Files" FILES ${Source_Files})

set(ALL_FILES
    ${Header_Files}
    ${Source_Files}
    ${Collision_Detection}
    ${Physics})

set_source_files_properties(${ALL_FILES} PROPERTIES LANGUAGE CXX)

################################################################################
# Target
################################################################################
add_library(${PROJECT_NAME} STATIC ${ALL_FILES})

#set(CMAKE_CXX_SOURCE_FILE_EXTENSIONS c;C;M;c++;cc;cpp;cxx;m;mm;mpp;CPP;ixx;cppm)

use_props(${PROJECT_NAME} "${CMAKE_CONFIGURATION_TYPES}" "${DEFAULT_CXX_PROPS}")
set(ROOT_NAMESPACE CSC8503CoreClasses)

set_target_properties(${PROJECT_NAME} PROPERTIES
    VS_GLOBAL_KEYWORD "Win32Proj"
)
set_target_properties(${PROJECT_NAME} PROPERTIES
    INTERPROCEDURAL_OPTIMIZATION_RELEASE "TRUE"
)
################################################################################
# Compile definitions
################################################################################
target_compile_definitions(${PROJECT_NAME} PRIVATE
    "UNICODE"
    "_UNICODE"
    "WIN32_LEAN_AND_MEAN"
    "_WINSOCK_DEPRECATED_NO_WARNINGS"
	"NOMINMAX"
)

target_precompile_headers(${PROJECT_NAME} PRIVATE
    <vector>
    <map>
    <stack>
    <string>
    <list>
    <thread>
    <atomic>
    <functional>
    <iostream>
    <set>
    "../NCLCoreClasses/Vector2.h"
    "../NCLCoreClasses/Vector3.h"
    "../NCLCoreClasses/Vector4.h"
    "../NCLCoreClasses/Quaternion.h"
    "../NCLCoreClasses/Plane.h"
    "../NCLCoreClasses/Matrix2.h"
    "../NCLCoreClasses/Matrix3.h"
    "../NCLCoreClasses/Matrix4.h"
	"../NCLCoreClasses/GameTimer.h"
)

################################################################################
# Compile and link options
################################################################################


################################################################################
# Dependencies
################################################################################
set(ADDITIONAL_LIBRARY_DEPENDENCIES
    "NCLCoreClasses"
    "ws2_32.lib"
)

include_directories("../NCLCoreClasses/")
include_directories("./")

if(MSVC)
    target_link_libraries(${PROJECT_NAME} PRIVATE "ws2_32.lib")
endif()
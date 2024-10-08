#version 430 core

uniform mat4 modelMatrix 	= mat4(1.0f);
uniform mat4 viewMatrix 	= mat4(1.0f);
uniform mat4 projMatrix 	= mat4(1.0f);
uniform mat4 shadowMatrix 	= mat4(1.0f);

layout(location = 0) in vec3 position;
layout(location = 1) in vec4 colour;
layout(location = 2) in vec2 texCoord;
layout(location = 3) in vec3 normal;

uniform vec4 		objectColour = vec4(1,1,1,1);

layout(std430, binding = 3) buffer TriangleBuffer {
    vec4 triangles[];
};

uniform bool hasVertexColours = false;

out Vertex
{
	vec4 colour;
	vec2 texCoord;
	vec4 shadowProj;
	vec3 normal;
	vec3 worldPos;
} OUT;

void main(void)
{
	mat4 mvp 		  = (projMatrix * viewMatrix );
	uint triangleIndex = gl_VertexID / 3;
    uint vertexIndex = gl_VertexID % 3;

	vec4 vertexPos[3];
    vertexPos[0] = triangles[triangleIndex * 3];
    vertexPos[1] = triangles[triangleIndex * 3 + 1];
    vertexPos[2] = triangles[triangleIndex * 3 + 2];

    //vec4 vertexPos = triangles[triangleIndex * 6 + vertexIndex * 2];
    //vec4 vertexNormal = triangles[triangleIndex * 6 + vertexIndex * 2 + 1];

	// Calculate the face normal
	vec3 edge1 = vertexPos[1].xyz - vertexPos[0].xyz;
	vec3 edge2 = vertexPos[2].xyz - vertexPos[0].xyz;
	vec3 faceNormal = normalize(cross(edge1, edge2));

	OUT.shadowProj 	=  shadowMatrix * vertexPos[vertexIndex];
	OUT.worldPos 	= (modelMatrix * vertexPos[vertexIndex]).xyz;
	OUT.normal 		= faceNormal;
	
	OUT.texCoord	= texCoord;
	OUT.colour		= objectColour;

	if(hasVertexColours) {
		OUT.colour		= objectColour * colour;
	}
	gl_Position		= mvp * vertexPos[vertexIndex];
}
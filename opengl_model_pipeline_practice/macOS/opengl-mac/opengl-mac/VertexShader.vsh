#version 330 core

layout(location = 0) in float xPos;
layout(location = 1) in float yPos;
layout(location = 2) in vec4 color;

out vec4 vColor;

void main()
{
    vColor = color;
    gl_Position = vec4(xPos, yPos, 1.0, 1.0);
}

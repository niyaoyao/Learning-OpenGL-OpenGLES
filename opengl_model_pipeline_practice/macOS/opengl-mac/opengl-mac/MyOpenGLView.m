//
//  MyOpenGLView.m
//  opengl-mac
//
//  Created by niyao on 5/17/18.
//  Copyright © 2018 dourui. All rights reserved.
//

#import "MyOpenGLView.h"

@interface MyOpenGLView ()

@property (nonatomic, copy) NSString *vertexString;
@property (nonatomic, copy) NSString *fragmentString;

@end

@implementation MyOpenGLView

- (instancetype)initWithFrame:(NSRect)frameRect {
    if (self = [super initWithFrame:frameRect]) {
        [self initGL];
    }
    
    return self;
}

- (void)initGL {
    NSLog(@"...was here");
    
    // 1. Create a context with opengl pixel format
    NSOpenGLPixelFormatAttribute pixelFormatAttributes[] =
    {
        NSOpenGLPFAOpenGLProfile, NSOpenGLProfileVersion4_1Core,
        NSOpenGLPFAColorSize    , 24                           ,
        NSOpenGLPFAAlphaSize    , 8                            ,
        NSOpenGLPFADoubleBuffer ,
        NSOpenGLPFAAccelerated  ,
        NSOpenGLPFANoRecovery   ,
        0
    };
    NSOpenGLPixelFormat *pixelFormat = [[NSOpenGLPixelFormat alloc] initWithAttributes:pixelFormatAttributes];
    
    super.pixelFormat = pixelFormat;
    // load glsl file
    NSString *vertexFile = [[NSBundle mainBundle] pathForResource:@"VertexShader" ofType:@"vsh"];
    NSString *fragmentFile = [[NSBundle mainBundle] pathForResource:@"FragmentShader" ofType:@"fsh"];

    NSError *error;

    NSString *vertexString = [NSString stringWithContentsOfFile:vertexFile encoding:NSUTF8StringEncoding error:&error];
    if (!vertexString) {
        NSLog(@"vanney code log : error loading vertex shader : %@", error.localizedDescription);
        exit(1);
    }
    self.vertexString = vertexString;

    NSString *fragmentString = [NSString stringWithContentsOfFile:fragmentFile encoding:NSUTF8StringEncoding error:&error];
    if (!fragmentString) {
        NSLog(@"vanney code log : error loading fragment shader : %@", error.localizedDescription);
        exit(1);
    }
    self.fragmentString = fragmentString;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // 2. Make the context current
    [[self openGLContext] makeCurrentContext];
    
    // 3. Define and compile vertex and fragment shaders
    GLuint  vs;
    GLuint  fs;
    
    const char *vss = [self.vertexString UTF8String];
    vs = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vs, 1, &vss, NULL);
    glCompileShader(vs);
    
    const char *fss = [self.fragmentString UTF8String];
    fs = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fs, 1, &fss, NULL);
    glCompileShader(fs);
    printf("vs: %i, fs: %i\n",vs,fs);
    
    int success;
    char infoLog[512];
    glGetShaderiv(vs, GL_COMPILE_STATUS, &success);
    if (!success)
    {
        glGetShaderInfoLog(vs, 512, NULL, infoLog);
        printf("ERROR::SHADER::VERTEX::COMPILATION_FAILED\n%s\n", infoLog);
    }
    
    glGetShaderiv(fs, GL_COMPILE_STATUS, &success);
    if (!success)
    {
        glGetShaderInfoLog(fs, 512, NULL, infoLog);
        printf("ERROR::SHADER::FRAGMENT::COMPILATION_FAILED\n%s\n", infoLog);
    }
    
    // 4. Attach the shaders
    shaderProgram = glCreateProgram();
    glAttachShader(shaderProgram, vs);
    glAttachShader(shaderProgram, fs);
    glLinkProgram(shaderProgram);
    // check for linking errors
    glGetProgramiv(shaderProgram, GL_LINK_STATUS, &success);
    if (!success) {
        glGetProgramInfoLog(shaderProgram, 512, NULL, infoLog);
        printf("ERROR::SHADER::PROGRAM::LINKING_FAILED\n%s\n", infoLog);
    }
    
    glDeleteShader(vs);
    glDeleteShader(fs);
    printf("positionUniform: %i, colourAttribute: %i, positionAttribute: %i\n",positionUniform,colourAttribute,positionAttribute);
    // There is no space (or other values) between each set of 3 values. The values are tightly packed in the array.
    float vertices[] = {
        0.0f,  0.0f, 0.0f,  //  (x,y,z) = (0,0,0)
        1.0f, 0.0f, 0.0f,  // (x,y,z) = (1,0,0)
        1.0f,  1.0f, 0.0f,   // (x,y,z) = (1,1,0)t
        0.f, 1.0f, 0.0f,  //(x,y,z) = (0,1,0)
//        -1.0f, -1.0f, 0.0f,
//        1.0f, -1.0f, 0.0f,
//        0.0f,  1.0f, 0.0f,
    };
    float colors[] = {
        1.0f, 0.0f, 0.0f, 1.0,  //  r
        0.0f, 1.0f, 0.0f, 1.0,  //   g
        0.0f, 0.0f, 1.0f, 1.0,   // b
        0.0f, 0.5f, 1.0f, 1.0,   // b
    };
//    unsigned int indices[] = {  // note that we start from 0!
//        0, 1, 2,  // first Triangle
//        0, 2, 3,   // second Triangle
//    };
    
    
    unsigned int VBO_vertext, VBO_color, VAO, EBO;
    // bind the Vertex Array Object first, then bind and set vertex buffer(s), and then configure vertex attributes(s).
    glGenVertexArrays(1, &VAO);
    glBindVertexArray(VAO);
    
    glGenBuffers(1, &VBO_vertext);
    glBindBuffer(GL_ARRAY_BUFFER, VBO_vertext);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    
//    glGenBuffers(1, &EBO);
//    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
//    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
    
    // 1rst attribute buffer : vertices
    glEnableVertexAttribArray(0);
    glBindBuffer(GL_ARRAY_BUFFER, VBO_vertext);
    glVertexAttribPointer(
        0,                  // attribute 0. No particular reason for 0, but must match the layout in the shader.
        3,                  // size
        GL_FLOAT,           // type
        GL_FALSE,           // normalized?
        0,                  // stride
        (void*)0            // array buffer offset
    );
    
    glGenBuffers(1, &VBO_color);
    glBindBuffer(GL_ARRAY_BUFFER, VBO_color);
    glBufferData(GL_ARRAY_BUFFER, sizeof(colors), colors, GL_STATIC_DRAW);
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 4 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(1);
    
    // note that this is allowed, the call to glVertexAttribPointer registered VBO as the vertex attribute's bound vertex buffer object so afterwards we can safely unbind
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    
    // remember: do NOT unbind the EBO while a VAO is active as the bound element buffer object IS stored in the VAO; keep the EBO bound.
    //glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    
    // You can unbind the VAO afterwards so other VAO calls won't accidentally modify this VAO, but this rarely happens. Modifying other
    // VAOs requires a call to glBindVertexArray anyways so we generally don't unbind VAOs (nor VBOs) when it's not directly necessary.
//    glBindVertexArray(0);
    // Drawing code here.
    glViewport(100, 100, 100, 100);
    glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    // draw our first triangle
//    glUseProgram(shaderProgram);
//    glBindVertexArray(VAO);
    glDrawArrays(GL_TRIANGLES, 0, 3);
//    glBindVertexArray(0);
    glUseProgram(shaderProgram);
//    glBindVertexArray(VAO);
    // Draw the triangle !
    glDrawArrays(GL_TRIANGLES, 0, 3); // 3 indices starting at 0 -> 1 triangle

//    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);
    
    [[self openGLContext] flushBuffer];
}


@end

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
//    float verticesTriangle[] = {
//        0.0f,  -1.0f, 0.0f,  //  (x,y,z) = (0,-1,0)
//        1.0f, -1.0f, 0.0f,  // (x,y,z) = (1,-1,0)
//        1.0f,  1.0f, 0.0f,   // (x,y,z) = (1,1,0)
//        -1.0f, 1.0f, 0.0f,  //(x,y,z) = (-1,1,0)
//        -1.0f, -0.0f, 0.0f,  //(x,y,z) = (-1,-0,0)
//        -1.0f, -0.5f, 0.0f,  //(x,y,z) = (-1,-0.5,0)
//        
//    };
    float colors[] = {
        1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 0.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  1.0f, 1.0f, 0.0f, 1.0,  // y
    };
//    unsigned int indices[] = {  // note that we start from 0!
//        0, 1, 2,  // first Triangle
//        0, 2, 3,   // second Triangle
//        0, 3, 4,   // third Triangle
//        0, 4, 5,   // third Triangle
//    };
//    
    const int numPoints = 200;
    float verticesX[numPoints] = {};
    float verticesY[numPoints] = {};
    float verticesY2[numPoints] = {};

    for (int i = 0; i < numPoints; i++)
    {
        float x = (float)(i);
        x = 2 * x / (numPoints - 1) - 1;
        float delta = cbrt(x*x) * cbrt(x*x) - 4*x*x + 4;
        float y1 = (cbrt(x*x) + sqrt(delta)) / 2;
        float y2 = (cbrt(x*x) - sqrt(delta)) / 2;
        verticesX[i] = x;
        verticesY[i] =  y1 - 0.5;
        verticesY2[i] =  y2;
    
        NSLog(@"(x,y, y2) => (%.2f, %.2f, %.2f)", verticesX[i], verticesY[i], verticesY[i]);
    }
    unsigned int VBO_vertext, VBO_vertext2, VBO_color, VAO, EBO;
    // bind the Vertex Array Object first, then bind and set vertex buffer(s), and then configure vertex attributes(s).
    glGenVertexArrays(1, &VAO);
    glBindVertexArray(VAO);
    
    glGenBuffers(1, &VBO_vertext);
    glBindBuffer(GL_ARRAY_BUFFER, VBO_vertext);
    glBufferData(GL_ARRAY_BUFFER, sizeof(verticesX), verticesX, GL_STATIC_DRAW);
    glVertexAttribPointer(0, 1, GL_FLOAT, GL_FALSE, 1 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(0);
    
    glGenBuffers(1, &VBO_vertext2);
    glBindBuffer(GL_ARRAY_BUFFER, VBO_vertext2);
    glBufferData(GL_ARRAY_BUFFER, sizeof(verticesY), verticesY, GL_STATIC_DRAW);
    glVertexAttribPointer(1, 1, GL_FLOAT, GL_FALSE, 1 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(1);
    
    
    glGenBuffers(1, &VBO_color);
    glBindBuffer(GL_ARRAY_BUFFER, VBO_color);
    glBufferData(GL_ARRAY_BUFFER, sizeof(colors), colors, GL_STATIC_DRAW);
    glVertexAttribPointer(2, 4, GL_FLOAT, GL_FALSE, 4 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(2);
    
    // note that this is allowed, the call to glVertexAttribPointer registered VBO as the vertex attribute's bound vertex buffer object so afterwards we can safely unbind
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    
    // remember: do NOT unbind the EBO while a VAO is active as the bound element buffer object IS stored in the VAO; keep the EBO bound.
    //glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    
    // You can unbind the VAO afterwards so other VAO calls won't accidentally modify this VAO, but this rarely happens. Modifying other
    // VAOs requires a call to glBindVertexArray anyways so we generally don't unbind VAOs (nor VBOs) when it's not directly necessary.
    glBindVertexArray(0);
    // Drawing code here.
    glViewport(10, 50, 100, 100);
    glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    // draw our first triangle
    glUseProgram(shaderProgram);
    glBindVertexArray(VAO);
    glDrawArrays(GL_LINE_STRIP, 0, numPoints);
    glLineWidth(3);
    [[self openGLContext] flushBuffer];
}


@end

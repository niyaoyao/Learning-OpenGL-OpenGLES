//
//  ViewController.m
//  GLESHeartBeat
//
//  Created by ibu_mob_basic_9 on 2024/1/25.
//

#import "ViewController.h"
#import <OpenGLES/ES3/gl.h>
#import "NYGLHelper.h"

@interface ViewController () <GLKViewDelegate> {
    GLuint shaderProgram;
    
    GLint positionUniform;
    GLint colourAttribute;
    GLint positionAttribute;
}

@property (nonatomic, copy) NSString *vertexString;
@property (nonatomic, copy) NSString *fragmentString;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGLView];
}


- (void)setupGLView {
    // Create an OpenGL ES context and assign it to the view loaded from storyboard
    GLKView *view = (GLKView *)self.view;
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
 
    // Configure renderbuffers created by the view
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    view.drawableStencilFormat = GLKViewDrawableStencilFormat8;
 
    // Enable multisampling
    view.drawableMultisample = GLKViewDrawableMultisample4X;
    view.delegate = self;
    
    // setup context
    [EAGLContext setCurrentContext:view.context];

    self.vertexString = [NYGLHelper utf8String:[NYGLHelper loadShaderFilename:@"VertexShader" extension:@"glsl"]];
    self.fragmentString = [NYGLHelper utf8String:[NYGLHelper loadShaderFilename:@"FragmentShader" extension:@"glsl"]];
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
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    
    float colors[] = {
        1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f,
    };
    
    const int numPoints = 400;
    float verticesX[numPoints] = {};
    float verticesY[numPoints] = {};

    for (int i = 0; i < numPoints; i++)
    {
        /*
           Graph function:
           (x^2 + y^2 - 1)^3 - x^2*y^3 = 0
           => y^2 - y*cbrt(x^2) + x^2 - 1 = 0
           */
        float x = (float)(i);
        x = 2 * x / (numPoints - 1) - 1;
        float delta = cbrt(x*x) * cbrt(x*x) - 4*x*x + 4;
        float y1 = 0.0;
        if (x < 0 && x >= -1) {
            y1 = sqrt(0.25 - (x + 0.5) * (x + 0.5));
        } else {
            y1 = sqrt(0.25 - (x - 0.5) * (x - 0.5));
        }
        y1 += 0.8;
//        float y1 = (cbrt(x*x) + sqrt(delta)) / 2;
        float y2 = (cbrt(x*x) - sqrt(delta)) / 2;
        if (i%2==0) {
            [self beatX:&x y:&y1];
        } else {
            [self beatX:&x y:&y2];
        }
        verticesX[i] = x;
        verticesY[i] = i % 2 == 0 ? y1 - 0.575 : y2;
//        NSLog(@"%.2f,%.2f,%.2f,%.2f,", x, y1, y2, delta);
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
    CGFloat w = self.view.frame.size.width;
    CGFloat x = w;
    CGFloat h = w;
    CGFloat y = self.view.frame.size.height * 1.5;
    glViewport(x, y, w, h);
    glClearColor(1.f, 0.94f, 0.96f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    // draw our first triangle
    glUseProgram(shaderProgram);
    glBindVertexArray(VAO);
    glDrawArrays(GL_LINE_STRIP, 0, numPoints);
    glLineWidth(3);
    glBindVertexArray(0);
}

- (void)beatX:(float *)x y:(float *)y {
    float p = 0.0;
    NSTimeInterval time = [[NSDate new] timeIntervalSince1970];
    float tt = fmod(time,1.5)/1.5;
    float ss = pow(tt,.2)*0.5 + 0.5;
    ss = 1.0 + ss*0.5*sin(tt*6.2831*3.0 + *y * 0.5)*exp(-tt*4.0);
//    p *= float2(0.5,1.5) + ss*float2(0.5,-0.5);
    *x *= ss * 0.5 + 0.5;
    *y *= ss *(- 0.5) + 1.5;
}
@end

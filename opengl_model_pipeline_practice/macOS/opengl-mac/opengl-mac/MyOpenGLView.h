//
//  MyOpenGLView.h
//  opengl-mac
//
//  Created by niyao on 5/17/18.
//  Copyright © 2018 dourui. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <OpenGL/gl3.h>
#import <OpenGL/OpenGL.h>

@interface MyOpenGLView : NSOpenGLView {
    GLuint shaderProgram;
//    GLuint vertexArrayObject;
//    GLuint vertexBuffer;
    
    GLint positionUniform;
    GLint colourAttribute;
    GLint positionAttribute;
}

@end

//
//  ViewController.m
//  opengl-mac
//
//  Created by niyao on 5/11/18.
//  Copyright © 2018 dourui. All rights reserved.
//

#import "ViewController.h"
#import "MyOpenGLView.h"
#import <OpenGL/OpenGL.h>
#import <OpenGL/gl3.h>
#define kFailedToInitialiseGLException @"Failed to initialise OpenGL"

#define GetError( )\
{\
for ( GLenum Error = glGetError( ); ( GL_NO_ERROR != Error ); Error = glGetError( ) )\
{\
switch ( Error )\
{\
case GL_INVALID_ENUM:      printf( "\n%s\n\n", "GL_INVALID_ENUM"      ); assert( 0 ); break;\
case GL_INVALID_VALUE:     printf( "\n%s\n\n", "GL_INVALID_VALUE"     ); assert( 0 ); break;\
case GL_INVALID_OPERATION: printf( "\n%s\n\n", "GL_INVALID_OPERATION" ); assert( 0 ); break;\
case GL_OUT_OF_MEMORY:     printf( "\n%s\n\n", "GL_OUT_OF_MEMORY"     ); assert( 0 ); break;\
default:                                                                              break;\
}\
}\
}

@interface ViewController()

@property (nonatomic, readwrite, retain)  NSOpenGLView *myGLView;

@end
@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyOpenGLView *glView = [[MyOpenGLView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview: glView];
    
}

@end

//
//  GLShader.h
//  GLESHeartBeat
//
//  Created by ibu_mob_basic_9 on 2024/1/26.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES3/gl.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYGLShader : NSObject

@property (nonatomic, assign) GLuint shaderProgram;
@property (nonatomic, assign) GLuint  vertextShaderID;
@property (nonatomic, assign) GLuint  fragmentShaderID;

- (BOOL)loadVertexShaderFileName:(NSString *)filename extension:(NSString *)extension;
- (BOOL)loadFragmentShaderFileName:(NSString *)filename extension:(NSString *)extension;
- (BOOL)linkShaderProgram;
@end

NS_ASSUME_NONNULL_END

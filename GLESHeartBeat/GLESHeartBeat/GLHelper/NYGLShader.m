//
//  GLShader.m
//  GLESHeartBeat
//
//  Created by ibu_mob_basic_9 on 2024/1/26.
//

#import "NYGLShader.h"
#import "NYGLHelper.h"

@interface NYGLShader () 

@property (nonatomic, copy) NSString *vertexString;
@property (nonatomic, copy) NSString *fragmentString;

@end

@implementation NYGLShader

- (BOOL)loadVertexShaderFileName:(NSString *)filename extension:(NSString *)extension {
    self.vertexString = [NYGLHelper utf8String:[NYGLHelper loadShaderFilename:filename extension:extension]];
    
    const char *vss = [self.vertexString UTF8String];
    self.vertextShaderID = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(self.vertextShaderID, 1, &vss, NULL);
    glCompileShader(self.vertextShaderID);
    
    int success;
    char infoLog[512];
    glGetShaderiv(self.vertextShaderID, GL_COMPILE_STATUS, &success);
    if (!success)
    {
        glGetShaderInfoLog(self.vertextShaderID, 512, NULL, infoLog);
        printf("ERROR::SHADER::VERTEX::COMPILATION_FAILED\n%s\n", infoLog);
    }
    
    return success;
}

- (BOOL)loadFragmentShaderFileName:(NSString *)filename extension:(NSString *)extension {
    
    self.fragmentString = [NYGLHelper utf8String:[NYGLHelper loadShaderFilename:filename extension:extension]];
    
    
    const char *fss = [self.fragmentString UTF8String];
    self.fragmentShaderID = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(self.fragmentShaderID, 1, &fss, NULL);
    glCompileShader(self.fragmentShaderID);
    printf("self.vertextShaderID: %i, self.fragmentShaderID: %i\n",self.vertextShaderID,self.fragmentShaderID);
    
    int success;
    char infoLog[512];
    
    glGetShaderiv(self.fragmentShaderID, GL_COMPILE_STATUS, &success);
    if (!success)
    {
        glGetShaderInfoLog(self.fragmentShaderID, 512, NULL, infoLog);
        printf("ERROR::SHADER::FRAGMENT::COMPILATION_FAILED\n%s\n", infoLog);
    }
    
    return success;
}

- (BOOL)linkShaderProgram {
    int success;
    char infoLog[512];
    // 4. Attach the shaders
    self.shaderProgram = glCreateProgram();
    glAttachShader(self.shaderProgram, self.vertextShaderID);
    glAttachShader(self.shaderProgram, self.fragmentShaderID);
    glLinkProgram(self.shaderProgram);
    // check for linking errors
    glGetProgramiv(self.shaderProgram, GL_LINK_STATUS, &success);
    if (!success) {
        glGetProgramInfoLog(self.shaderProgram, 512, NULL, infoLog);
        printf("ERROR::SHADER::PROGRAM::LINKING_FAILED\n%s\n", infoLog);
    }
    
    glDeleteShader(self.vertextShaderID);
    glDeleteShader(self.fragmentShaderID);
    return success;
}
@end

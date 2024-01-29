//
//  GLHelper.m
//  GLESHeartBeat
//
//  Created by ibu_mob_basic_9 on 2024/1/25.
//

#import "NYGLHelper.h"

@implementation NYGLHelper
+ (NSString *)loadShaderFilename:(NSString *)filename extension:(NSString *)extension {
    return [self loadBundle:[NSBundle mainBundle] shaderFilename:filename extension:extension];
}

+ (NSString *)loadBundle:(NSBundle *)bundle shaderFilename:(NSString *)filename extension:(NSString *)extension {
    return [bundle pathForResource:filename ofType:extension];
}

+ (NSString *)utf8String:(NSString *)string {
    NSError *error = nil;
    NSString *utf8EncodeString = [NSString stringWithContentsOfFile:string encoding:NSUTF8StringEncoding error:&error];
    if (error != nil) {
        NSString *reason = [NSString stringWithFormat:@"vanney code log : error loading vertex shader : %@", error.localizedDescription];
        @throw [NSException exceptionWithName:@"LOAD_SHADER_ERROR" reason:reason userInfo:@{}];
    }
    return utf8EncodeString;
}

+ (const char *)characherString:(NSString *)string {
    NSString *utf8EncodeStr = nil;
    @try {
        utf8EncodeStr =  [self utf8String:string];
    } @catch (NSException *exception) {
        @throw exception;
    } @finally {
        NSLog(@"final");
    }
    
    return [utf8EncodeStr UTF8String];
}

+ (void)beatX:(float *)x y:(float *)y {
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

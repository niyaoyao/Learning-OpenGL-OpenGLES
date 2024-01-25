//
//  GLHelper.h
//  GLESHeartBeat
//
//  Created by ibu_mob_basic_9 on 2024/1/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYGLHelper : NSObject
/// load main bundle shader file
+ (NSString *)loadShaderFilename:(NSString *)filename extension:(NSString *)extension;
+ (NSString *)loadBundle:(NSBundle *)bundle shaderFilename:(NSString *)filename extension:(NSString *)extension;
+ (NSString *)utf8String:(NSString *)string;
+ (const char *)characherString:(NSString *)string;
@end

NS_ASSUME_NONNULL_END

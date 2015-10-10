//
//  Utils.h
//  MyMG
//
//  Created by caobin on 15/10/8.
//  Copyright (c) 2015年 caobin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TempPath(file)  [file stringByAppendingString:@".temp"]

@interface Utils : NSObject

+(void)SandboxDictionary;

+ (long long) fileSizeAtPath:(NSString*) filePath;

@end

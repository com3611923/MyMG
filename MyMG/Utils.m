//
//  Utils.m
//  MyMG
//
//  Created by caobin on 15/10/8.
//  Copyright (c) 2015年 caobin. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(void)SandboxDictionary
{
    
    NSLog(@"sandbox : %@", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO));
    NSDocumentController *docController = [NSDocumentController sharedDocumentController];
    NSArray *docArray = [docController recentDocumentURLs];
    for (size_t i = 0; i < [docArray count]; i++) {
        NSLog(@"Recent File %ld, %@\n",i,[[docArray objectAtIndex:i] absoluteString]);
    }
    
}

//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

@end

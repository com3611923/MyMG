//
//  DownloadHandle.m
//  MyMG
//
//  Created by caobin on 15/10/8.
//  Copyright (c) 2015年 caobin. All rights reserved.
//

#import "DownloadHandle.h"
#import "Utils.h"
#import <AFNetworking.h>

@interface DownloadHandle(){
    
    AFHTTPClient    *_downloadClient;
    
    AFHTTPRequestOperation *_downloadOperation;
    
    NSOperationQueue *_queue;
}

@end


@implementation DownloadTask



@end

@implementation DownloadHandle

+(id)shareHandle
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

-(id)init
{
    self = [super init];
    if(self) {
        _downloadClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        

    }
    return self;
}


#pragma mark 下载
- (void)downloadWithTask:(DownloadTask *)task
{
    
    NSString *path = @"/Users/pp/Downloads/PP 下载/应用/PPtest_2.0.0build349.ipa";
    NSString *tmpPath = [path stringByAppendingString:@".temp"];
    
   NSString *range = [NSString stringWithFormat:@"bytes=%llu-", [Utils fileSizeAtPath:tmpPath]];
    
    // 1. 建立请求
    NSMutableURLRequest *request = [_downloadClient requestWithMethod:@"GET" path:@"http://ghost.25pp.com/soft/release/PPbuildsoft/PPhelper2.0.0build349-pp20-PC-50d40d8560f648ea3458dbca526d7f0a.ipa" parameters:nil];
    [request setValue:range forHTTPHeaderField:@"Range"];
    // 2. 操作
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    _downloadOperation = op;

    op.outputStream = [NSOutputStream outputStreamToFileAtPath:tmpPath append:YES];
    

    [op setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
        // 设置进度条的百分比
        CGFloat precent = (CGFloat)totalBytesRead / totalBytesExpectedToRead;
        NSLog(@"%f", precent);
        
    }];
    
    // 设置下载完成操作
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        

        [[NSFileManager defaultManager] moveItemAtPath:tmpPath toPath:path error:NULL];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
    }];
    
    // 启动下载
    [_downloadClient.operationQueue addOperation:op];
}

@end

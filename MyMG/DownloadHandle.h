//
//  DownloadHandle.h
//  MyMG
//
//  Created by caobin on 15/10/8.
//  Copyright (c) 2015年 caobin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    DOWNLOAD_STATE_WAIT,    //等待
    DOWNLOAD_STATE_EXEC,    //下载中
    DOWNLOAD_STATE_STOP,    //暂停下载
    DOWNLOAD_STATE_FAILED,  //下载失败
    DOWNLOAD_STATE_GET,     //获取中
}DOWNLOAD_STATE;

@class AFHTTPRequestOperation;

@interface DownloadTask : NSObject {
    
}

@property (nonatomic , strong) AFHTTPRequestOperation *operation;

@property (nonatomic , strong) NSString *url;

@property (nonatomic , strong) NSString *path;

@property BOOL finished;

@property DOWNLOAD_STATE state;

@property long long offSet;

@property long long fileSize;

@property double speed;     //下载速度

@property double progress;      //下载进度

@end


@interface DownloadHandle : NSObject {
    
}

+(id)shareHandle;

- (void)downloadWithTask:(DownloadTask *)task;

@end

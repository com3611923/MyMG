//
//  MGResourcePage.h
//  MyMG
//
//  Created by caobin on 15/9/25.
//  Copyright (c) 2015年 caobin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

#define WALLPAPER_SITE_2        @"http://ppmac2.25pp.com/res/wallpaper_v2/index.html#u_home"

@interface MGResourcePage : WebView {
    
    BOOL            _loadFinished;
}


@end

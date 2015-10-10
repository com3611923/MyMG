//
//  AppDelegate.m
//  MyMG
//
//  Created by caobin on 15/9/24.
//  Copyright (c) 2015年 caobin. All rights reserved.
//

#import "AppDelegate.h"
#import "MGTitleButton.h"
#import "MGResourcePage.h"
#import <WebViewJavascriptBridge.h>
#import "Utils.h"
#import "DownloadHandle.h"

@interface AppDelegate () {
    
    NSImageView                     *_menuBackgoundView;
    id                              _menuBackgroundConstraint;
    
    MGResourcePage                  *_resourcePage;
}

//@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

-(void)applicationWillFinishLaunching:(NSNotification *)notification
{
    [_window center];
    [_window makeKeyAndOrderFront:self];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.window.delegate = (id)self;
    self.window.trafficLightButtonsLeftMargin = 7.0;
    self.window.fullScreenButtonRightMargin   = 7.0;
    self.window.centerFullScreenButton        = NO;
    self.window.titleBarHeight                = 510.0;
    self.window.centerTrafficLightButtons     = NO;
    self.window.backgroundColor               = [NSColor whiteColor];
    
    self.window.titleBarDrawingBlock = ^(BOOL drawsAsMainWindow,CGRect drawingRect, CGPathRef clippingPath) {
        // clear 全屏模式顶部两个圆角的白色
        [[NSColor clearColor] setFill];
        NSRectFill(drawingRect);
        
        CGContextRef ctx = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
        if (clippingPath) {
            CGContextAddPath(ctx, clippingPath);
            CGContextClip(ctx);
        }
        
        NSImage *bgImage = [NSImage imageNamed:@"titlebar_bg"];
        [bgImage drawInRect:NSMakeRect(0, 0, bgImage.size.width, drawingRect.size.height)
                   fromRect:NSZeroRect
                  operation:NSCompositeSourceOver
                   fraction:1.f];
        
        [[NSColor colorWithDeviceRed:101/255.f green:167/255.f blue:172/255.f alpha:1.f] setFill];
        NSRectFill(NSMakeRect(bgImage.size.width, 0, drawingRect.size.width - bgImage.size.width, drawingRect.size.height));
      //  [[NSColor grayColor] setFill];
        NSRectFill(drawingRect);
    };
    
    [self drawTitleTabBar];
    [self initWebResource];
    
    [Utils SandboxDictionary];
    
  //  [[DownloadHandle shareHandle] downloadWithTask:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


#pragma mark - TabBar

-(void)drawTitleTabBar
{
    // TitleBar 背景
    NSView *superview = self.window.titleBarView;
    
    _menuBackgoundView = [[NSImageView alloc] init];
    [_menuBackgoundView setImage:[NSImage imageNamed:@"titleBackground2"]];
    [_menuBackgoundView setImageScaling:NSImageScaleNone];
    
    [superview addSubview:_menuBackgoundView];
    [_menuBackgoundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).offset(20);
        _menuBackgroundConstraint = make.left.equalTo(superview).with.offset(200 - 2 * 53);
        make.width.equalTo(@53);
        make.height.equalTo(@22);
    }];
    
    NSArray *titleArray = @[@"全部", @"电影", @"电视剧", @"娱乐", @"纪录片", @"综艺", @"音乐", @"动漫", @"旅游", @"片花"];
    
    for (int i = 0; i < titleArray.count; i++) {
        MGTitleButton *button = [[MGTitleButton alloc] init];
        
        button.titleLabel.stringValue = titleArray[i];
        button.state = NSOffState;
        [button setTag:i];
        [button setTarget:self];
        [button setAction:@selector(titleBarAction:)];
        [superview addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superview).offset(20);
            make.left.equalTo(superview).with.offset(200 + (i - 2) * 53);
            make.width.equalTo(@53);
            make.height.equalTo(@22);
        }];
        
        [button setState:NSOnState];
    }
}


- (void)titleBarAction:(NSButton *)sender
{
    usleep(10 * 1000);
    dispatch_async(dispatch_get_main_queue(), ^{
        @autoreleasepool {
            [self setTitleBarToChange:sender];
        }
        
    });
}

-(void)setTitleBarToChange:(NSButton *)sender
{
    CGFloat val=200+ (sender.tag - 2) * 53;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_menuBackgoundView setAlphaValue:0];
        [[_menuBackgoundView animator] setAlphaValue:1.0];
        [[_menuBackgroundConstraint  animator] setOffset:val];
    });
    [self clearMenuOnState];
    [_menuBackgoundView setHidden:NO];
    [sender setState:NSOnState];
}

-(void)clearMenuOnState
{
    for (NSView *view in self.window.titleBarView.subviews) {
        if ([view isKindOfClass:[NSButton class]] && (((NSButton *)view).state == NSOnState)) {
            [((NSButton *)view)setState : NSOffState];
        }
        if ([view isKindOfClass:[NSButton class]] ){
            [view setNeedsDisplay:YES];
        }
    }
    [_menuBackgoundView setHidden:YES];
    
}

#pragma mark - WebResource

-(void)initWebResource
{
    _resourcePage = [[MGResourcePage alloc] init];
    _resourcePage.UIDelegate = _resourcePage;
    _resourcePage.resourceLoadDelegate	= _resourcePage;
    _resourcePage.frameLoadDelegate		= _resourcePage;
    _resourcePage.policyDelegate			= _resourcePage;
    [[(WebView *)_resourcePage mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:WALLPAPER_SITE_2]]];
    [self.window.titleBarView addSubview:_resourcePage];
    [_resourcePage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_menuBackgoundView).offset(40);
        make.left.equalTo(self.window.contentView);
        make.right.equalTo(self.window.contentView);
        make.bottom.equalTo(self.window.contentView);
    }];
    
    [WebViewJavascriptBridge enableLogging];
    
//    WebViewJavascriptBridge *bridge = [WebViewJavascriptBridge bridgeForWebView:_resourcePage handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"Received message from javascript: %@", data);
//        responseCallback(@"Right back atcha");
//    }];
//    [bridge registerHandler:@"BeginDownload" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"......");
//    }];
}

@end

//
//  MGResourcePage.m
//  MyMG
//
//  Created by caobin on 15/9/25.
//  Copyright (c) 2015年 caobin. All rights reserved.
//

#import "MGResourcePage.h"

@implementation MGResourcePage

-(id)init
{
    self = [super init];
    if(self) {
       // _eventSource = [[EventSource alloc] init];
    }
    return self;
}

#pragma mark
#pragma mark -- Web View UIDelegate

// 屏蔽WebView右击事件
- (NSArray *)webView:(WebView *)sender contextMenuItemsForElement:(NSDictionary *)element defaultMenuItems:(NSArray *)defaultMenuItems
{
   	return nil;
}

- (NSUInteger)webView:(WebView *)webView dragDestinationActionMaskForDraggingInfo:(id <NSDraggingInfo>)draggingInfo
{
    return 0;
}

#pragma mark
#pragma mark -- Web View ResourceDelegate

- (void)webView:(WebView *)sender resource:(id)identifier didFinishLoadingFromDataSource:(WebDataSource *)dataSource
{

}

- (void)webView:(WebView *)sender resource:(id)identifier didFailLoadingWithError:(NSError *)error fromDataSource:(WebDataSource *)dataSource
{

}

- (void)webView:(WebView *)webView decidePolicyForNewWindowAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request newFrameName:(NSString *)frameName decisionListener:(id <WebPolicyDecisionListener>)listener
{
    NSURL *URL = [request URL];
    
    [[NSWorkspace sharedWorkspace] openURL:URL];
}

#pragma mark 
#pragma mark -- FrameLoadResource Delegate

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
    _loadFinished = YES;
}

-(void)pageDidFinishLoadForFrame
{

}

- (void)webView:(WebView *)webView didClearWindowObject:(WebScriptObject *)windowObject forFrame:(WebFrame *)frame
{
    [windowObject setValue:self forKey:@"external"];
}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)selector
{
    if (selector == @selector(BeginDownload:Name:)) {
        return NO;
    }
    return YES;
}

+ (NSString *)webScriptNameForSelector:(SEL)selector
{
    if (selector == @selector(BeginDownload:Name:)) {
        return @"BeginDownload";
    }
    return nil;
}

#pragma mark
#pragma mark -- WebView Callback Methods

/*
 JS->OC
 资源页下载
 */
- (int)BeginDownload:(NSString *)url Name:(NSString *)name
{
    return 0;
}

@end

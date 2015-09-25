//
//  MGTitleButton.h
//  MyMG
//
//  Created by caobin on 15/9/24.
//  Copyright (c) 2015年 caobin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MGTitleButton : NSButton {
    
    BOOL    mouseInside;
    NSTrackingArea	*trackingArea;
}

@property (nonatomic , strong) NSTextField *titleLabel;

- (void)setTextColor:(NSColor *)textColor;

@end

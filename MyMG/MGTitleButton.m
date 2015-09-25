//
//  MGTitleButton.m
//  MyMG
//
//  Created by caobin on 15/9/24.
//  Copyright (c) 2015年 caobin. All rights reserved.
//

#import "MGTitleButton.h"
#import "MGTextFieldCell.h"

@implementation MGTitleButton {

}

- (id)init
{
    self = [super init];
    
    if (self) {
        [self setButtonType:NSMomentaryChangeButton];
        [self setImagePosition:NSImageOnly];
        [self setBordered:NO];
    
        _titleLabel = [[NSTextField alloc] init];
        [_titleLabel setCell:[[MGTextFieldCell alloc] init]];
        [_titleLabel setBordered:NO];
        [_titleLabel setBezeled:NO];
        [_titleLabel setEditable:NO];
        [_titleLabel setBackgroundColor:[NSColor clearColor]];
        [_titleLabel setAlignment:NSCenterTextAlignment];
        
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.equalTo(self);
        }];
    }
    
    return self;
}

- (void)setMouseInside:(BOOL)value
{
    if (mouseInside != value) {
        mouseInside = value;
        [self setNeedsDisplay];
    }
}

- (BOOL)mouseInside
{
    return mouseInside;
}

- (void)mouseEntered:(NSEvent *)theEvent
{
    self.mouseInside = YES;
}

- (void)mouseExited:(NSEvent *)theEvent
{
    self.mouseInside = NO;
    
}

- (void)updateTrackingAreas
{
    [super updateTrackingAreas];
    
    if (trackingArea == nil) {
        trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect
                                                   options :NSTrackingInVisibleRect | NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited
                                                     owner	:self
                                                   userInfo:nil];
    }
    
    if (![[self trackingAreas] containsObject:trackingArea]) {
        [self addTrackingArea:trackingArea];
    }
}

- (void)setTextColor:(NSColor *)textColor
{
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc]
                                            initWithAttributedString:[self attributedTitle]];
    NSUInteger	len		= [attrTitle length];
    NSRange		range	= NSMakeRange(0, len);
    
    [attrTitle addAttribute:NSForegroundColorAttributeName
                     value	:textColor
                     range	:range];
    [attrTitle fixAttributesInRange:range];
    [self setAttributedTitle:attrTitle];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    int roundedRectangleCornerRadius = 2;
    NSRect roundedRectangleInnerRect = NSInsetRect(dirtyRect, roundedRectangleCornerRadius, roundedRectangleCornerRadius);
    NSBezierPath* roundedRectanglePath = [NSBezierPath bezierPath];
    [roundedRectanglePath appendBezierPathWithArcWithCenter: NSMakePoint(NSMinX(roundedRectangleInnerRect), NSMinY(roundedRectangleInnerRect)) radius: roundedRectangleCornerRadius startAngle: 180 endAngle: 270];
    [roundedRectanglePath appendBezierPathWithArcWithCenter: NSMakePoint(NSMaxX(roundedRectangleInnerRect), NSMinY(roundedRectangleInnerRect)) radius: roundedRectangleCornerRadius startAngle: 270 endAngle: 360];
    [roundedRectanglePath lineToPoint: NSMakePoint(NSMaxX(dirtyRect), NSMaxY(dirtyRect))];
    [roundedRectanglePath lineToPoint: NSMakePoint(NSMinX(dirtyRect), NSMaxY(dirtyRect))];
    [roundedRectanglePath closePath];
    
    if (self.mouseInside && [self isEnabled] && ![self.cell isHighlighted] && (self.state != NSOnState)) {
        NSColor			*color = [NSColor colorWithCalibratedRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:0.1];
        [color setFill];
        [roundedRectanglePath fill];
        
        
        
    } else if (self.mouseInside && [self isEnabled] && [self.cell isHighlighted] && (self.state != NSOnState)) {
        NSColor			*color = [NSColor colorWithCalibratedRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.1];
        [color setFill];
        [roundedRectanglePath fill];
    } else {
        //        if (_natureImage) {
        //            [_natureImage drawInRect:NSMakeRect((NSWidth(dirtyRect) - IMAGEWIDTH) / 2, 15, IMAGEWIDTH, IMAGEHEIGHT) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0 respectFlipped:YES hints:@{}];
        //        }
    }
    
    if(self.state == NSOnState) {
        [_titleLabel setTextColor:[NSColor whiteColor]];
    }else {
        [_titleLabel setTextColor:[NSColor blackColor]];
    }
    
    
    [super drawRect:dirtyRect];
}

@end

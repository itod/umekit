//
//  UMETabBarItemButtonCell.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 10/14/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import "UMETabBarItemButtonCell.h"
#import <UMEKit/UMETabBarItem.h>

#define MIN_WIDTH 40
#define TITLE_OFFSET_X 2
#define TITLE_OFFSET_Y 1
#define IMAGE_OFFSET_Y 4

static NSShadow *sTitleShadow = nil;

static NSImage *sLeftImageHi = nil;
static NSImage *sCenterImageHi = nil;
static NSImage *sRightImageHi = nil;

static NSImage *sBackgroundImage = nil;

@interface UMETabBarItemButtonCell ()
- (void)commonInit;
@end

@implementation UMETabBarItemButtonCell

+ (void)initialize {
    if ([UMETabBarItemButtonCell class] == self) {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        sTitleShadow = [[NSShadow alloc] init];
        [sTitleShadow setShadowColor:[[NSColor blackColor] colorWithAlphaComponent:0.5]];
        [sTitleShadow setShadowOffset:NSMakeSize(0, 1)];
        [sTitleShadow setShadowBlurRadius:0];
        
        NSBundle *b = [NSBundle bundleForClass:self];
        
        sLeftImageHi   = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"tabbar_button_bg_hi_01"]];
        sCenterImageHi = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"tabbar_button_bg_hi_02"]];
        sRightImageHi  = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"tabbar_button_bg_hi_03"]];
        
        sBackgroundImage = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"tabbar_bg"]];
        
        [pool release];
    }
}


- (id)initTextCell:(NSString *)s {
    if (self = [super initTextCell:s]) {
        [self commonInit];
    }
    return self;
}


- (id)initImageCell:(NSImage *)i {
    if (self = [super initImageCell:i]) {
        [self commonInit];
    }
    return self;
}


- (void)commonInit {
    [self setImagePosition:NSImageAbove];
}


- (void)dealloc {
    [super dealloc];
}


- (BOOL)isOpaque {
    return YES;
}


- (void)drawWithFrame:(NSRect)r inView:(NSView *)cv {
    [self drawInteriorWithFrame:r inView:cv];
}


- (void)drawInteriorWithFrame:(NSRect)r inView:(NSView *)cv { 
    //UMETabBarItemButton *b = (UMETabBarItemButton *)cv;
    //UMETabBarItem *item = b.item;
    
    // if below the min width, just clear and return (dont draw borked background image)
    if (r.size.width < MIN_WIDTH) {
        return;
    }    
    
    NSDrawThreePartImage(r, sBackgroundImage, sBackgroundImage, sBackgroundImage, NO, NSCompositeSourceOver, 1, YES);
    
    // draw bg image
    if (NSOnState == [self state]) {
        NSImage *leftImage = sLeftImageHi;
        NSImage *centerImage = sCenterImageHi;
        NSImage *rightImage = sRightImageHi;
        
        [leftImage setFlipped:[cv isFlipped]];
        [centerImage setFlipped:[cv isFlipped]];
        [rightImage setFlipped:[cv isFlipped]];
        
        NSDrawThreePartImage(r, leftImage, centerImage, rightImage, NO, NSCompositeSourceOver, 1, NO);
    }
    
    // draw image
    if ([self imagePosition] != NSNoImage) {
        NSImage *img = nil;
        if (NSOnState == [self state]) {
            img = [self alternateImage];
        } else {
            img = [self image];
        }
        
        [img setFlipped:[cv isFlipped]];
        
        NSSize size = [img size];
        NSPoint p = NSMakePoint(r.origin.x + round((r.size.width - size.width) / 2.0) + TITLE_OFFSET_X, IMAGE_OFFSET_Y);
        
        [img drawAtPoint:p fromRect:NSMakeRect(0, 0, size.width, size.height) operation:NSCompositeSourceOver fraction:1];
    }
    
    // draw title
    if ([self imagePosition] != NSImageOnly) {
        NSString *title = [self title];
        if ([title length]) {
            NSColor *color = nil;
            if ([self isEnabled]) {
                if (NSOnState == [self state]) {
                    color = [NSColor whiteColor];
                } else {
                    color = [NSColor colorWithCalibratedWhite:1.0 alpha:0.6];
                }
            } else {
                color = [NSColor colorWithCalibratedWhite:1.0 alpha:0.4];
            }
            
            NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [self font], NSFontAttributeName, 
                                        color, NSForegroundColorAttributeName, 
                                        sTitleShadow, NSShadowAttributeName, 
                                        nil];
            
            NSSize size = [title sizeWithAttributes:attributes];
            
//            NSPoint p = NSMakePoint(r.origin.x + round((r.size.width - size.width) / 2.0) + TITLE_OFFSET_X,
//                                    r.size.height - size.height - TITLE_OFFSET_Y);
//            
//            [title drawAtPoint:p withAttributes:attributes];

            NSRect d = NSMakeRect(r.origin.x + round((r.size.width - size.width) / 2.0) + TITLE_OFFSET_X,
                                  r.size.height - size.height - TITLE_OFFSET_Y,
                                  r.size.width - TITLE_OFFSET_X * 2, size.height);
            
            [title drawWithRect:d options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:attributes];
        }
    }
}

@end

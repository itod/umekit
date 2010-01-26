//
//  UMEBarButtonItemButtonCell.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 10/13/09.
//  Copyright 2009 Yahoo! Inc.. All rights reserved.
//

#import "UMEBarButtonItemButtonCell.h"
#import "UMEBarButtonItemButton.h"
#import <UMEKit/UMEBarButtonItem.h>

#define MIN_WIDTH 36
#define MIN_BACK_WIDTH 46
#define MIN_IMAGE_PADDING 4

#define TITLE_OFFSET_X 10
#define BACK_TITLE_OFFSET_X 7
#define TITLE_OFFSET_Y -1

#define IMAGE_OFFSET_X 0
#define IMAGE_OFFSET_Y -1

static NSShadow *sTitleShadow = nil;

static NSImage *sLeftImagePlain = nil;
static NSImage *sLeftImageDone = nil;
static NSImage *sLeftImageBack = nil;
static NSImage *sCenterImagePlain = nil;
static NSImage *sCenterImageDone = nil;
static NSImage *sCenterImageBack = nil;
static NSImage *sRightImagePlain = nil;
static NSImage *sRightImageDone = nil;
static NSImage *sRightImageBack = nil;

static NSImage *sLeftImagePlainHi = nil;
static NSImage *sLeftImageDoneHi = nil;
static NSImage *sLeftImageBackHi = nil;
static NSImage *sCenterImagePlainHi = nil;
static NSImage *sCenterImageDoneHi = nil;
static NSImage *sCenterImageBackHi = nil;
static NSImage *sRightImagePlainHi = nil;
static NSImage *sRightImageDoneHi = nil;
static NSImage *sRightImageBackHi = nil;

@interface UMEBarButtonItemButtonCell ()
- (void)commonInit;
@end

@implementation UMEBarButtonItemButtonCell

+ (void)initialize {
    if ([UMEBarButtonItemButtonCell class] == self) {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

        sTitleShadow = [[NSShadow alloc] init];
        [sTitleShadow setShadowColor:[[NSColor blackColor] colorWithAlphaComponent:0.7]];
        [sTitleShadow setShadowOffset:NSMakeSize(0, 1)];
        [sTitleShadow setShadowBlurRadius:0];

        NSBundle *b = [NSBundle bundleForClass:[UMEBarButtonItemButtonCell class]];
        
        sLeftImagePlain     = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_plain_bg_01"]];
        sLeftImageDone      = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_done_bg_01"]];
        sLeftImageBack      = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"back_button_bg_01"]];
        sCenterImagePlain   = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_plain_bg_02"]];
        sCenterImageDone    = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_done_bg_02"]];
        sCenterImageBack    = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"back_button_bg_02"]];
        sRightImagePlain    = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_plain_bg_03"]];
        sRightImageDone     = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_done_bg_03"]];
        sRightImageBack     = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"back_button_bg_03"]];

        sLeftImagePlainHi   = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_plain_bg_hi_01"]];
        sLeftImageDoneHi    = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_done_bg_hi_01"]];
        sLeftImageBackHi    = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"back_button_bg_hi_01"]];
        sCenterImagePlainHi = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_plain_bg_hi_02"]];
        sCenterImageDoneHi  = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_done_bg_hi_02"]];
        sCenterImageBackHi  = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"back_button_bg_hi_02"]];
        sRightImagePlainHi  = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_plain_bg_hi_03"]];
        sRightImageDoneHi   = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_done_bg_hi_03"]];
        sRightImageBackHi   = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"back_button_bg_hi_03"]];
        
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
    [self setTitle:@""];
    [self setImage:nil];
    [self setImagePosition:NSImageBelow];
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


- (void)drawBackgroundWithFrame:(NSRect)r inView:(NSView *)cv {
    UMEBarButtonItemButton *button = (UMEBarButtonItemButton *)cv;
    UMEBarButtonItem *item = button.item;
        
    // draw bg image
    NSImage *leftImage = nil;
    NSImage *centerImage = nil;
    NSImage *rightImage = nil;
    
    switch (item.style) {
        case UMEBarButtonItemStylePlain:
            if ([self isHighlighted]) {
                leftImage = sLeftImagePlainHi;
                centerImage = sCenterImagePlainHi;
                rightImage = sRightImagePlainHi;
            } else {
                leftImage = sLeftImagePlain;
                centerImage = sCenterImagePlain;
                rightImage = sRightImagePlain;
            }
            break;
        case UMEBarButtonItemStyleDone:
            if ([self isHighlighted]) {
                leftImage = sLeftImageDoneHi;
                centerImage = sCenterImageDoneHi;
                rightImage = sRightImageDoneHi;
            } else {
                leftImage = sLeftImageDone;
                centerImage = sCenterImageDone;
                rightImage = sRightImageDone;
            }
            break;
        case UMEBarButtonItemStyleBack:
            if ([self isHighlighted]) {
                leftImage = sLeftImageBackHi;
                centerImage = sCenterImageBackHi;
                rightImage = sRightImageBackHi;
            } else {
                leftImage = sLeftImageBack;
                centerImage = sCenterImageBack;
                rightImage = sRightImageBack;
            }
            break;
        default:
            NSAssert(0, @"Unknown UMEBarButtonItemStyle");
            break;
    }
    
    [leftImage setFlipped:[cv isFlipped]];
    [centerImage setFlipped:[cv isFlipped]];
    [rightImage setFlipped:[cv isFlipped]];
    
    CGFloat alpha = [self isEnabled] ? 1.0 : 0.7;
    
    NSDrawThreePartImage(r, leftImage, centerImage, rightImage, NO, NSCompositeSourceOver, alpha, NO);
}


- (void)drawInteriorWithFrame:(NSRect)r inView:(NSView *)cv {
    UMEBarButtonItemButton *button = (UMEBarButtonItemButton *)cv;
    UMEBarButtonItem *item = button.item;

    // if below the min width, just clear and return (dont draw borked background image)
    CGFloat minWidth = MIN_WIDTH;
    if (NSImageOnly == [self imagePosition]) {
        minWidth = [[self image] size].width + MIN_IMAGE_PADDING;
    } else if (UMEBarButtonItemStyleBack == item.style) {
        minWidth = MIN_BACK_WIDTH;
    }

    if (r.size.width < minWidth) {
        [[NSColor clearColor] set];
        NSRectFill(r);
        return;
    }

    // ok, we're above the min width. we can draw
    [self drawBackgroundWithFrame:r inView:cv];
    
    // draw image 
    if (NSImageOnly == [self imagePosition]) {
        NSImage *img = nil;
        if ([self isHighlighted]) {
            img = [self alternateImage];
        } else {
            img = [self image];
        }
        
        [img setFlipped:[cv isFlipped]];
        
        NSSize size = [img size];
        NSPoint p = NSMakePoint(r.origin.x + round((r.size.width - size.width) / 2.0) + IMAGE_OFFSET_X,
                                r.origin.y + round((r.size.height - size.height) / 2.0) + IMAGE_OFFSET_Y);
        
        CGFloat alpha = [self isEnabled] ? 1.0 : 0.7;

        [img drawAtPoint:p fromRect:NSMakeRect(0, 0, size.width, size.height) operation:NSCompositeSourceOver fraction:alpha];
    }
    
    // draw title
    if (NSImageOnly != [self imagePosition]) {
        NSString *title = [self title];
        if ([title length]) {
            NSColor *color = nil;
            if ([self isEnabled]) {
                color = [NSColor whiteColor];
            } else {
                color = [NSColor colorWithCalibratedWhite:1.0 alpha:0.7];
            }
            
            NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [self font], NSFontAttributeName, 
                                        color, NSForegroundColorAttributeName, 
                                        sTitleShadow, NSShadowAttributeName, 
                                        nil];
            
            NSSize size = [title sizeWithAttributes:attributes];
//            NSPoint p = NSMakePoint(r.origin.x + round((r.size.width - size.width) / 2.0) + TITLE_OFFSET_X,
//                                    r.origin.y + round((r.size.height - size.height) / 2.0) + TITLE_OFFSET_Y);
//            
            NSRect d = NSMakeRect(TITLE_OFFSET_X,
                                  r.origin.y + round((r.size.height - size.height) / 2.0) + TITLE_OFFSET_Y,
                                  r.size.width - TITLE_OFFSET_X * 2, size.height);
            
            if (UMEBarButtonItemStyleBack == item.style) {
                d.origin.x += BACK_TITLE_OFFSET_X;
            }

            //            [title drawInRect:d withAttributes:attributes];
            [title drawWithRect:d options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:attributes];
        }
    }
}

@end

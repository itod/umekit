//  Copyright 2010 Todd Ditchendorf
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

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

static NSImage *sDefaultLeftImagePlain = nil;
static NSImage *sDefaultLeftImageDone = nil;
static NSImage *sDefaultLeftImageBack = nil;
static NSImage *sDefaultCenterImagePlain = nil;
static NSImage *sDefaultCenterImageDone = nil;
static NSImage *sDefaultCenterImageBack = nil;
static NSImage *sDefaultRightImagePlain = nil;
static NSImage *sDefaultRightImageDone = nil;
static NSImage *sDefaultRightImageBack = nil;

static NSImage *sDefaultLeftImagePlainHi = nil;
static NSImage *sDefaultLeftImageDoneHi = nil;
static NSImage *sDefaultLeftImageBackHi = nil;
static NSImage *sDefaultCenterImagePlainHi = nil;
static NSImage *sDefaultCenterImageDoneHi = nil;
static NSImage *sDefaultCenterImageBackHi = nil;
static NSImage *sDefaultRightImagePlainHi = nil;
static NSImage *sDefaultRightImageDoneHi = nil;
static NSImage *sDefaultRightImageBackHi = nil;

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
        
        sDefaultLeftImagePlain     = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_plain_bg_01"]];
        sDefaultLeftImageDone      = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_done_bg_01"]];
        sDefaultLeftImageBack      = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_back_bg_01"]];
        sDefaultCenterImagePlain   = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_plain_bg_02"]];
        sDefaultCenterImageDone    = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_done_bg_02"]];
        sDefaultCenterImageBack    = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_back_bg_02"]];
        sDefaultRightImagePlain    = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_plain_bg_03"]];
        sDefaultRightImageDone     = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_done_bg_03"]];
        sDefaultRightImageBack     = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_back_bg_03"]];

        sDefaultLeftImagePlainHi   = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_plain_bg_hi_01"]];
        sDefaultLeftImageDoneHi    = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_done_bg_hi_01"]];
        sDefaultLeftImageBackHi    = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_back_bg_hi_01"]];
        sDefaultCenterImagePlainHi = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_plain_bg_hi_02"]];
        sDefaultCenterImageDoneHi  = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_done_bg_hi_02"]];
        sDefaultCenterImageBackHi  = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_back_bg_hi_02"]];
        sDefaultRightImagePlainHi  = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_plain_bg_hi_03"]];
        sDefaultRightImageDoneHi   = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_done_bg_hi_03"]];
        sDefaultRightImageBackHi   = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"barbuttonitem_default_back_bg_hi_03"]];
        
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
                leftImage = sDefaultLeftImagePlainHi;
                centerImage = sDefaultCenterImagePlainHi;
                rightImage = sDefaultRightImagePlainHi;
            } else {
                leftImage = sDefaultLeftImagePlain;
                centerImage = sDefaultCenterImagePlain;
                rightImage = sDefaultRightImagePlain;
            }
            break;
        case UMEBarButtonItemStyleDone:
            if ([self isHighlighted]) {
                leftImage = sDefaultLeftImageDoneHi;
                centerImage = sDefaultCenterImageDoneHi;
                rightImage = sDefaultRightImageDoneHi;
            } else {
                leftImage = sDefaultLeftImageDone;
                centerImage = sDefaultCenterImageDone;
                rightImage = sDefaultRightImageDone;
            }
            break;
        case UMEBarButtonItemStyleBack:
            if ([self isHighlighted]) {
                leftImage = sDefaultLeftImageBackHi;
                centerImage = sDefaultCenterImageBackHi;
                rightImage = sDefaultRightImageBackHi;
            } else {
                leftImage = sDefaultLeftImageBack;
                centerImage = sDefaultCenterImageBack;
                rightImage = sDefaultRightImageBack;
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
        NSImage *img = [self image];        
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

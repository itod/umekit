//
//  UMEToolbar.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 2/16/10.
//  Copyright 2010 Todd Ditchendorf. All rights reserved.
//

#import "UMEToolbar.h"
#import "UMEImageCache.h"

#define ITEM_X 4.0
#define ITEM_MARGIN 5.0

@interface UMEBarButtonItem ()
- (void)sizeToFit;
@property (nonatomic) UMEBarStyle barStyle;            // default is UMEBarStyleDefault
@property (nonatomic, getter=isFlexible) BOOL flexible;
@end

@interface UMEToolbar ()
- (void)layoutItems;
@property (nonatomic, retain) NSMutableArray *flexibleItems;
@end

@implementation UMEToolbar

- (id)initWithFrame:(NSRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.barStyle = UMEBarStyleDefault;
    }
    return self;
}


- (void)dealloc {
    self.items = nil;
    self.tintColor = nil;
    self.flexibleItems = nil;
    [super dealloc];
}


- (void)awakeFromNib {

}


#pragma mark -
#pragma mark NSView

- (BOOL)isFlipped {
    return YES;
}


// necessary for the first run layout :|
//- (void)viewWillDraw {
//    if (!layoutDone) {
//        layoutDone = YES;
//        [self layoutItems];
//    }
//    [super viewWillDraw];
//}


- (void)resizeSubviewsWithOldSize:(NSSize)oldSize {
    [self layoutItems];
}


- (void)drawRect:(NSRect)dirtyRect {
    NSImage *bgImg = nil;
    
    switch (barStyle) {
        case UMEBarStyleDefault:
            bgImg = UMEIMG(@"toolbar_bg_default");
            break;
        case UMEBarStyleBlack:
            bgImg = UMEIMG(@"toolbar_bg_black");
            break;
        case UMEBarStyleGray:
            bgImg = UMEIMG(@"toolbar_bg_gray");
            break;
        case UMEBarStyleNavy:
            bgImg = UMEIMG(@"toolbar_bg_navy");
            break;
        default:
            break;
    }
    
    NSRect bounds = [self bounds];
    NSDrawThreePartImage(bounds, nil, bgImg, nil, NO, NSCompositeSourceOver, 1, YES);
    
    [[NSColor darkGrayColor] setStroke];
    CGFloat y = bounds.size.height - 1;
    [NSBezierPath strokeLineFromPoint:NSMakePoint(0, y) toPoint:NSMakePoint(bounds.size.width, y)];    
}


#pragma mark -
#pragma mark Public

- (void)setItems:(NSArray *)a animated:(BOOL)animated {
    self.items = a;
}


- (void)setItems:(NSArray *)a {
    if (a != items) {
        for (UMEBarButtonItem *item in items) {
            [item.customView removeFromSuperview];
        }
        
        [items autorelease];
        items = [a retain];
        
        self.flexibleItems = [NSMutableArray array];
        //numNonSpaceItems = 0;
        
        for (UMEBarButtonItem *item in items) {
            item.barStyle = barStyle;
//            if (!item.isSpace) {
//                numNonSpaceItems++;
//            }
            if (item.isFlexible) {
                [flexibleItems addObject:item];
            }
        }
        
        [self layoutItems];
    }
}


#pragma mark -
#pragma mark Private

- (void)layoutItems {
    NSRect bounds = [self bounds];
    
    CGFloat x = ITEM_X;
    CGFloat y = 0;
    CGFloat w = 0;
    CGFloat h = bounds.size.height - 2.0; // room for bottom line
    
    CGFloat availWidth = bounds.size.width;
    CGFloat nonFlexibleItemsTotalWidth = ITEM_X * 2; // left and right margin

    // calc total non-flexible width, and figure how many items can be visible in avail width
    for (UMEBarButtonItem *item in items) {
        CGFloat currWidth = NSWidth([item.customView frame]) + ITEM_MARGIN;
        if (!item.isFlexible) {
            nonFlexibleItemsTotalWidth += currWidth;
        }
    }
    
    NSUInteger flexibleItemCount = [flexibleItems count];
    BOOL itemsTruncated = (nonFlexibleItemsTotalWidth > availWidth);
    
    if (flexibleItemCount > 0) {
        CGFloat flexibleItemWidth = itemsTruncated ? 0 : (availWidth - nonFlexibleItemsTotalWidth) / flexibleItemCount;
        for (UMEBarButtonItem *flexibleItem in flexibleItems) {
            NSRect frame = [flexibleItem.customView frame];
            frame.size.width = flexibleItemWidth;
            [flexibleItem.customView setFrame:frame];
        }
    }
    
    for (UMEBarButtonItem *item in items) {
        //[item sizeToFit];
        [self addSubview:item.customView];
        w = [item width];
        [item.customView setFrame:NSMakeRect(x, y, w, h)];
        x += w + ITEM_MARGIN;
    }
    
    [self setNeedsDisplay:YES];
}

@synthesize barStyle;
@synthesize items;
@synthesize tintColor;
@synthesize translucent;
@synthesize flexibleItems;
@end

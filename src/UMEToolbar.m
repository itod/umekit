//
//  UMEToolbar.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 2/16/10.
//  Copyright 2010 Todd Ditchendorf. All rights reserved.
//

#import "UMEToolbar.h"

static NSImage *sDefaultBackgroundImage = nil;
static NSImage *sBlackBackgroundImage = nil;
static NSImage *sGrayBackgroundImage = nil;

@interface UMEBarButtonItem ()
- (void)sizeToFit;
@end

@interface UMEToolbar ()
- (void)layoutItems;
@end

@implementation UMEToolbar

+ (void)initialize {
    if ([UMEToolbar class] == self) {

        NSBundle *b = [NSBundle bundleForClass:[UMEToolbar class]];

        sDefaultBackgroundImage = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"toolbar_bg_default"]];
        sBlackBackgroundImage = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"toolbar_bg_black"]];
        sGrayBackgroundImage = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"toolbar_bg_gray"]];
    }
}


- (id)initWithFrame:(NSRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.barStyle = UMEBarStyleDefault;
    }
    return self;
}


- (void)dealloc {
    self.items = nil;
    self.tintColor = nil;
    [super dealloc];
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
            bgImg = sDefaultBackgroundImage;
            break;
        case UMEBarStyleBlack:
            bgImg = sBlackBackgroundImage;
            break;
        case UMEBarStyleGray:
            bgImg = sGrayBackgroundImage;
            break;
        default:
            break;
    }
    
    NSRect bounds = [self bounds];
    NSDrawThreePartImage(bounds, bgImg, bgImg, bgImg, NO, NSCompositeSourceOver, 1, YES);
}


#pragma mark -
#pragma mark Public

- (void)setItems:(NSArray *)a animated:(BOOL)animated {
    self.items = a;
}


- (void)setItems:(NSArray *)a {
    if (a != items) {
        [items autorelease];
        items = [a retain];
        
        [self layoutItems];
    }
}


#pragma mark -
#pragma mark Private

- (void)layoutItems {
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 0;
    CGFloat h = 0;
    
    for (UMEBarButtonItem *item in items) {
        //[item sizeToFit];
        [self addSubview:item.customView];
        w = [item width];
        h = NSHeight([item.customView frame]);
        [item.customView setFrame:NSMakeRect(x, y, w, h)];
        x += w;
    }
    
    [self setNeedsDisplay:YES];
}

@synthesize barStyle;
@synthesize items;
@synthesize tintColor;
@synthesize translucent;
@end

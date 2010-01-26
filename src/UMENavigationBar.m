//
//  UMENavigationBar.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 9/27/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <UMEKit/UMENavigationBar.h>
#import <UMEKit/UMEBarButtonItem.h>
#import <QuartzCore/QuartzCore.h>
#import "UMEFlippedView.h"

#define SIDE_VIEW_PADDING 4
#define LABEL_HEIGHT 20
#define LABEL_OFFSET_Y 12
#define LABEL_FONT_SIZE 16
#define MAX_TITLE_WIDTH_RATIO .5

static NSImage *sBackgroundImage = nil;

@interface UMEBarButtonItem ()
- (void)sizeToFit;
- (void)layout;
@property (nonatomic, retain) NSButton *button;
@end

@interface UMENavigationItem ()
@property (nonatomic, assign) UMENavigationBar *navigationBar;
@end

@interface UMENavigationBar ()
- (NSView *)newContainerView;
- (NSTextField *)newTitleLabel;
- (void)setTopItem:(UMENavigationItem *)newTopItem backItem:(UMENavigationItem *)newBackItem isPush:(BOOL)isPush animated:(BOOL)animated;

- (CAAnimation *)pushAnimation;
- (CAAnimation *)popAnimation;

- (void)layout;

@property (nonatomic, readwrite, retain) UMENavigationItem *topItem;
@property (nonatomic, readwrite, retain) UMENavigationItem *backItem;
@property (nonatomic, retain) NSView *containerView;
@property (nonatomic, retain) NSTextField *label;
@property (nonatomic, retain) UMEBarButtonItem *leftBarButtonItem;
@property (nonatomic, retain) UMEBarButtonItem *rightBarButtonItem;
@property (nonatomic, retain) NSDictionary *pushAnimations;
@property (nonatomic, retain) NSDictionary *popAnimations;
@end

@implementation UMENavigationBar

+ (void)initialize {
    if ([UMENavigationBar class] == self) {
        NSString *path = [[NSBundle bundleForClass:self] pathForImageResource:@"navbar_bg"];
        sBackgroundImage = [[NSImage alloc] initWithContentsOfFile:path];
    }
}


- (id)initWithFrame:(NSRect)r {
    if (self = [super initWithFrame:r]) {
        [self setWantsLayer:YES];
        self.items = [NSMutableArray array];
        
        self.pushAnimations = [NSDictionary dictionaryWithObject:[self pushAnimation] forKey:@"subviews"];
        self.popAnimations  = [NSDictionary dictionaryWithObject:[self popAnimation]  forKey:@"subviews"];
    }
    return self;
}


- (void)dealloc {
    [containerView removeFromSuperview];
    [label removeFromSuperview];
    [leftBarButtonItem.customView removeFromSuperview];
    [rightBarButtonItem.customView removeFromSuperview];
    self.containerView = nil;
    self.items = nil;
    self.delegate = nil;
    self.topItem = nil;
    self.backItem = nil;
    self.label = nil;
    self.leftBarButtonItem = nil;
    self.rightBarButtonItem = nil;
    self.pushAnimations = nil;
    self.popAnimations = nil;
    [super dealloc];
}


- (BOOL)isFlipped {
    return YES;
}


- (NSView *)newContainerView {
    NSView *v = [[UMEFlippedView alloc] initWithFrame:[self bounds]];
    [v setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    return v;
}


- (NSTextField *)newTitleLabel {
    NSTextField *tf = [[NSTextField alloc] initWithFrame:NSMakeRect(0, LABEL_OFFSET_Y, 0, LABEL_HEIGHT)];

    [tf setTextColor:[NSColor whiteColor]];
    [tf setFont:[NSFont boldSystemFontOfSize:LABEL_FONT_SIZE]];
    [tf setBezeled:NO];
    [tf setDrawsBackground:NO];
    [tf setEditable:NO];
    [tf setSelectable:NO];        
    [tf setAlignment:NSCenterTextAlignment];
    [[tf cell] setLineBreakMode:NSLineBreakByTruncatingTail];
    
    NSShadow *shadow = [[[NSShadow alloc] init] autorelease];
    [shadow setShadowColor:[[NSColor blackColor] colorWithAlphaComponent:0.7]];
    [shadow setShadowOffset:NSMakeSize(0, 1)];
    [shadow setShadowBlurRadius:0];
    [tf setShadow:shadow];

    return tf;
}


- (void)pushNavigationItem:(UMENavigationItem *)newItem animated:(BOOL)animated {
    if (delegate && [delegate respondsToSelector:@selector(navigationBar:shouldPushItem:)]) {
        if (![delegate navigationBar:self shouldPushItem:newItem]) {
            return;
        }
    }
    
    [items addObject:newItem];
    [self setTopItem:newItem backItem:topItem isPush:YES animated:animated];
        
    if (delegate && [delegate respondsToSelector:@selector(navigationBar:didPushItem:)]) {
        [delegate navigationBar:self didPushItem:newItem];
    }
}


- (UMENavigationItem *)popNavigationItemAnimated:(BOOL)animated {
    UMENavigationItem *item = [[topItem retain] autorelease];
    
    if (item) {
        if (delegate && [delegate respondsToSelector:@selector(navigationBar:shouldPopItem:)]) {
            if (![delegate navigationBar:self shouldPopItem:item]) {
                return nil;
            }
        }
        
        [items removeLastObject];

        UMENavigationItem *newTopItem = nil;
        UMENavigationItem *newBackItem = nil;

        if ([items count]) {
            newTopItem = [items lastObject];
            if ([items count] > 1) {
                newBackItem = [items objectAtIndex:[items count] - 2];
            }
        }
        [self setTopItem:newTopItem backItem:newBackItem isPush:NO animated:animated];
    }
    
    if (delegate && [delegate respondsToSelector:@selector(navigationBar:didPopItem:)]) {
        [delegate navigationBar:self didPopItem:item];
    }
    
    return item;
}


- (void)setItems:(NSArray *)a animated:(BOOL)animated {
    self.items = a;
}


- (void)setTopItem:(UMENavigationItem *)newTopItem backItem:(UMENavigationItem *)newBackItem isPush:(BOOL)isPush animated:(BOOL)animated {
    //if (newTopItem != topItem) {
        if (backItem) {
            [backItem.backBarButtonItem.customView removeFromSuperview]; // may be nil/noop
        }
        
        if (topItem) {
            [topItem.leftBarButtonItem.customView removeFromSuperview]; // may be nil/noop
            [topItem.rightBarButtonItem.customView removeFromSuperview]; // may be nil/noop
        }
        
        self.backItem = newBackItem;
        self.topItem = newTopItem;

        topItem.navigationBar = self;
        backItem.navigationBar = self;
        
        if (newTopItem) {
            NSView *newContainerView = [[self newContainerView] autorelease];

            NSString *s = newTopItem.title;
            if ([s length]) {
                self.label = [[self newTitleLabel] autorelease];
                [label setStringValue:s];
                [newContainerView addSubview:label];
            }
            
            leftBarButtonItem = newTopItem.leftBarButtonItem;
            if (!leftBarButtonItem && !newTopItem.hidesBackButton && backItem) {
                leftBarButtonItem = backItem.backBarButtonItem;
            }
            
            if (leftBarButtonItem) {
                [newContainerView addSubview:leftBarButtonItem.customView];
            }
            
            rightBarButtonItem = newTopItem.rightBarButtonItem;
            if (rightBarButtonItem) {
                [newContainerView addSubview:rightBarButtonItem.customView];
            }

            [self layout];
            
            if (containerView) {
                if (animated) {
                    [self setAnimations:isPush ? pushAnimations : popAnimations];
                    [[self animator] replaceSubview:containerView with:newContainerView];
                    [self setAnimations:nil];
                } else {
                    [self replaceSubview:containerView with:newContainerView];
                }
            } else {
                [self addSubview:newContainerView];
            }

            self.containerView = newContainerView;
        }
    //}
}


- (void)setBounds:(NSRect)r {
    [super setBounds:r];
    [self layout];
}


- (void)setFrame:(NSRect)frame {
    [super setFrame:frame];
    [self layout];
}


- (void)setFrameSize:(NSSize)size {
    [super setFrameSize:size];
    [self layout];
}


- (void)setNeedsDisplay:(BOOL)flag {
    if (flag) {
        [self layout];
    }
    [super setNeedsDisplay:flag];
}


- (void)layout {
    CGFloat availWidth = NSWidth([self frame]);
    if (0 == availWidth) {
        return;
    }

    [label sizeToFit];
    
    [leftBarButtonItem.customView setAutoresizingMask:NSViewMaxXMargin];
    [rightBarButtonItem.customView setAutoresizingMask:NSViewMinXMargin];

    [leftBarButtonItem sizeToFit];
    [rightBarButtonItem sizeToFit];
        
    CGFloat titleWidth = NSWidth([label bounds]);
    CGFloat maxTitleWidth = availWidth * MAX_TITLE_WIDTH_RATIO;
    if (titleWidth > maxTitleWidth) {
        titleWidth = maxTitleWidth;
        CGFloat titleHeight = NSHeight([label bounds]);
        [label setFrameSize:NSMakeSize(titleWidth, titleHeight)];
    }
    
    CGFloat leftTextWidth = NSWidth([leftBarButtonItem.customView bounds]);
    CGFloat rightTextWidth = NSWidth([rightBarButtonItem.customView bounds]);
    
    CGFloat titleX = availWidth / 2 - titleWidth / 2;
//    CGFloat proposedWidth = SIDE_VIEW_PADDING + leftTextWidth + SIDE_VIEW_PADDING + titleWidth + SIDE_VIEW_PADDING + rightTextWidth + SIDE_VIEW_PADDING;
//    if (proposedWidth > availWidth) {
    BOOL isLeftTextTooWide = SIDE_VIEW_PADDING * 2 + leftTextWidth > titleX;
    BOOL isRightTextTooWide = SIDE_VIEW_PADDING * 2 + rightTextWidth > availWidth - (titleX + titleWidth + SIDE_VIEW_PADDING * 2);
    if (isLeftTextTooWide || isRightTextTooWide) {
        leftTextWidth = (availWidth - (titleWidth + SIDE_VIEW_PADDING * 4)) / 2;
        rightTextWidth = leftTextWidth;
    }

    NSRect maxLeftFrame = NSMakeRect(SIDE_VIEW_PADDING, 0, leftTextWidth, NSHeight([self bounds]));
    NSRect maxRightFrame = NSMakeRect(NSWidth([self bounds]) - rightTextWidth - SIDE_VIEW_PADDING, 0, rightTextWidth, NSHeight([self bounds]));
    
    [label setFrameOrigin:NSMakePoint(titleX, LABEL_OFFSET_Y)];
    
    NSRect curLeftBounds = [leftBarButtonItem.customView bounds];
    NSRect curLeftFrame = NSMakeRect(maxLeftFrame.origin.x, maxLeftFrame.origin.y, curLeftBounds.size.width, curLeftBounds.size.height);
    if (curLeftFrame.size.width > maxLeftFrame.size.width) {
        curLeftFrame.size.width = maxLeftFrame.size.width;
    }
    if (curLeftFrame.size.height < maxLeftFrame.size.height) {
        curLeftFrame.origin.y = maxLeftFrame.size.height / 2 - curLeftFrame.size.height / 2;
    }

    NSRect curRightBounds = [rightBarButtonItem.customView bounds];
    
    NSRect curRightFrame = NSMakeRect(0, maxRightFrame.origin.y, curRightBounds.size.width, curRightBounds.size.height);
    if (curRightFrame.size.width > maxRightFrame.size.width) {
        curRightFrame.size.width = maxRightFrame.size.width;
    }
    if (curRightFrame.size.height < maxRightFrame.size.height) {
        curRightFrame.origin.y = maxRightFrame.size.height / 2 - curRightFrame.size.height / 2;
    }
    CGFloat x = maxRightFrame.origin.x + (maxRightFrame.size.width - curRightFrame.size.width);
    curRightFrame.origin.x = x;

//    CGFloat y = NSMinY([label frame]);
//    [label setFrame:NSMakeRect(SIDE_VIEW_PADDING * 2 + NSWidth(curLeftFrame), y, maxTitleWidth, NSHeight([label frame]))];
    
    [leftBarButtonItem.customView setFrame:curLeftFrame];
    [rightBarButtonItem.customView setFrame:curRightFrame];
    
    [leftBarButtonItem layout];
    [rightBarButtonItem layout];

    [leftBarButtonItem.customView setNeedsDisplay:YES];
    [rightBarButtonItem.customView setNeedsDisplay:YES];
}


- (CAAnimation *)pushAnimation {
    CATransition *trans = [CATransition animation];
    trans.duration = 0.25;
    trans.type = kCATransitionFade;
    trans.subtype = kCATransitionFromRight;
    return trans;
}


- (CAAnimation *)popAnimation {
    CATransition *trans = [CATransition animation];
    trans.duration = 0.25;
    trans.type = kCATransitionFade;
    trans.subtype = kCATransitionFromLeft;
    return trans;
}


#pragma mark -
#pragma mark NSView

// necessary for the first run layout :|
- (void)viewWillDraw {
    if (!layoutDone) {
        layoutDone = YES;
        [self layout];
    }
    [super viewWillDraw];
}


- (void)drawRect:(NSRect)r {
    NSDrawThreePartImage(r, sBackgroundImage, sBackgroundImage, sBackgroundImage, NO, NSCompositeSourceOver, 1, YES);
}

@synthesize containerView;
@synthesize topItem;
@synthesize backItem;
@synthesize barStyle;
@synthesize delegate;
@synthesize items;
@synthesize label;
@synthesize leftBarButtonItem;
@synthesize rightBarButtonItem;
@synthesize pushAnimations;
@synthesize popAnimations;
@end

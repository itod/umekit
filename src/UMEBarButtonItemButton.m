//
//  UMEBarButtonItemButton.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 10/21/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import "UMEBarButtonItemButton.h"
#import "UMEBarButtonItemButtonCell.h"
#import <UMEKit/UMEBarButtonItem.h>

#define MIN_WIDTH 36
#define MIN_HEIGHT 44
#define BACK_TITLE_OFFSET_X 5

@implementation UMEBarButtonItemButton

+ (Class)cellClass {
    return [UMEBarButtonItemButtonCell class];
}


- (id)initWithFrame:(NSRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setButtonType:NSMomentaryPushInButton];
        [self setBordered:NO];
        [self setFocusRingType:NSFocusRingTypeNone];
        [self setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable|NSViewMinXMargin|NSViewMaxXMargin|NSViewMinYMargin|NSViewMaxYMargin];
    }
    return self;
}


- (void)dealloc {
    self.item = nil;
    [super dealloc];
}


- (BOOL)isFlipped {
    return YES;
}


- (void)sizeToFit {
    [super sizeToFit];
    
    NSSize size = [self bounds].size;
    
    size.width += 18;
    if (size.width < MIN_WIDTH) {
        size.width = MIN_WIDTH;
    }
    if (size.height < MIN_HEIGHT) {
        size.height = MIN_HEIGHT;
    }
    
    if (UMEBarButtonItemStyleBack == item.style) {
        size.width += BACK_TITLE_OFFSET_X;
    }
    [self setFrameSize:size];
}


- (BOOL)isEnabled {
    return [super isEnabled];
}


- (void)setEnabled:(BOOL)yn {
    [super setEnabled:yn];
}

@synthesize item;
@end

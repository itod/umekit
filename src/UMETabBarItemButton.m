//
//  UMETabBarItemButton.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 10/21/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import "UMETabBarItemButton.h"
#import "UMETabBarItemButtonCell.h"
#import <UMEKit/UMETabBarItem.h>

@implementation UMETabBarItemButton

+ (Class)cellClass {
    return [UMETabBarItemButtonCell class];
}


- (id)initWithFrame:(NSRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setFont:[NSFont boldSystemFontOfSize:10]];
        [self setButtonType:NSPushOnPushOffButton];
        [self setBordered:NO];
        [self setFocusRingType:NSFocusRingTypeNone];
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

@synthesize item;
@end

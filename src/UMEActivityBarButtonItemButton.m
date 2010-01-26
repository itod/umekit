//
//  UMEActivityBarButtonItemButton.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 10/22/09.
//  Copyright 2009 Yahoo! Inc.. All rights reserved.
//

#import "UMEActivityBarButtonItemButton.h"
#import "UMEActivityBarButtonItemButtonCell.h"

@interface UMEActivityBarButtonItemButton ()
@property (nonatomic, retain) NSTimer *timer;
@end

@implementation UMEActivityBarButtonItemButton

+ (Class)cellClass {
    return [UMEActivityBarButtonItemButtonCell class];
}


- (id)initWithFrame:(NSRect)frame {
    if (self = [super initWithFrame:frame]) { 

    }
    return self;
}


- (void)dealloc {
    self.timer = nil;
    [super dealloc];
}


- (BOOL)isHighlighted {
    return NO;
}


- (void)sizeToFit {
    [self setFrameSize:NSMakeSize(40, 44)];
}

@synthesize timer;
@end

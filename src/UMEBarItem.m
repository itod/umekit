//
//  UMEBarItem.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 10/21/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <UMEKit/UMEBarItem.h>

@implementation UMEBarItem

- (id)init {
    if (self = [super init]) {
        self.enabled = YES;
    }
    return self;
}


- (void)dealloc {
    self.title = nil;
    self.image = nil;
    [super dealloc];
}

@synthesize enabled;
@synthesize title;
@synthesize image;
@synthesize imageInsets;
@synthesize tag;
@end

//
//  UMETabBar.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 9/27/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <UMEKit/UMETabBar.h>

#define TABBAR_HEIGHT 60.0

static NSImage *sBackgroundImage = nil;

@implementation UMETabBar

+ (void)initialize {
    if ([UMETabBar class] == self) {
        NSString *path = [[NSBundle bundleForClass:self] pathForImageResource:@"tabbar_bg"];
        sBackgroundImage = [[NSImage alloc] initWithContentsOfFile:path];
    }
}


- (id)initWithFrame:(NSRect)r {
    if (self = [super initWithFrame:r]) {

    }
    return self;
}


- (void)dealloc {
    [super dealloc];
}


- (BOOL)isFlipped {
    return YES;
}


- (void)drawRect:(NSRect)r {
    NSDrawThreePartImage(r, sBackgroundImage, sBackgroundImage, sBackgroundImage, NO, NSCompositeSourceOver, 1, YES);
}

@end

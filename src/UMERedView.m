//
//  UMERedView.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 9/30/09.
//  Copyright 2009 Yahoo! Inc.. All rights reserved.
//

#import "UMERedView.h"

@implementation UMERedView

- (id)initWithFrame:(NSRect)frame {
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}


- (BOOL)isOpaque {
    return YES;
}


- (void)drawRect:(NSRect)r {
    NSDrawWindowBackground(r);
    [super drawRect:r];
//    [[NSColor redColor] set];
//    NSRectFill(r);
}

@end

//
//  UMEToolbar.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 2/16/10.
//  Copyright 2010 Todd Ditchendorf. All rights reserved.
//

#import "UMEToolbar.h"

@interface UMEToolbar ()
- (void)layoutSubviews;
@end

@implementation UMEToolbar

- (id)initWithFrame:(NSRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code here.
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

- (void)resizeSubviewsWithOldSize:(NSSize)oldSize {
    [self layoutSubviews];
}


- (void)drawRect:(NSRect)dirtyRect {
    
}


#pragma mark -
#pragma mark Public

- (void)setItems:(NSArray *)a animated:(BOOL)animated {
    self.items = a;
}


#pragma mark -
#pragma mark Private

- (void)layoutSubviews {
    
}

@synthesize barStyle;
@synthesize items;
@synthesize tintColor;
@synthesize translucent;
@end

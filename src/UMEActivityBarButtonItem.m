//
//  UMEActivityBarButtonItem.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 10/22/09.
//  Copyright 2009 Yahoo! Inc.. All rights reserved.
//

#import <UMEKit/UMEActivityBarButtonItem.h>
#import "UMEActivityBarButtonItemButton.h"

@interface UMEBarButtonItem ()
@property (nonatomic, retain) NSButton *button;
@end

@implementation UMEActivityBarButtonItem

- (id)init {
    return [self initWithTitle:nil style:UMEBarButtonItemStylePlain target:nil action:nil];
}


- (id)initWithTitle:(NSString *)aTitle style:(UMEBarButtonItemStyle)aStyle target:(id)aTarget action:(SEL)sel {
    if (self = [super initWithTitle:aTitle style:aStyle target:aTarget action:sel]) {
        self.button = [[[UMEActivityBarButtonItemButton alloc] initWithFrame:NSZeroRect] autorelease];
        [(UMEBarButtonItemButton *)button setItem:self];
        [customView addSubview:button];
    }
    return self;
}


- (void)dealloc {
    [super dealloc];
}


- (void)sizeToFit {
    [button setFrame:NSMakeRect(0, 0, 40, 44)];
    [customView setFrame:[button frame]];
}

@end

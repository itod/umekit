//  Copyright 2010 Todd Ditchendorf
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

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

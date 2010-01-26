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

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

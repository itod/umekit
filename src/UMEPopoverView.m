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

#import "UMEPopoverView.h"

static NSImage *sTopLeftImage = nil;
static NSImage *sTopLeftMiddleImage = nil;
static NSImage *sTopMiddleImage = nil;
static NSImage *sTopRightImage = nil;
static NSImage *sTopRightMiddleImage = nil;

static NSImage *sMiddleLeftImage = nil;
static NSImage *sMiddleRightImage = nil;

static NSImage *sBottomLeftImage = nil;
static NSImage *sBottomMiddleImage = nil;
static NSImage *sBottomRightImage = nil;

@implementation UMEPopoverView

+ (void)initialize {
    if ([UMEPopoverView class] == self) {
        
        NSBundle *b = [NSBundle bundleForClass:[UMEPopoverView class]];
                
        sTopLeftImage           = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"popover_top_left"]];
        sTopLeftMiddleImage     = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"popover_top_left_middle"]];
        sTopMiddleImage         = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"popover_top_middle"]];
        sTopRightImage          = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"popover_top_right"]];
        sTopRightMiddleImage    = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"popover_top_right_middle"]];
        
        sMiddleLeftImage        = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"popover_middle_left"]];
        sMiddleRightImage       = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"popover_middle_right"]];
        
        sBottomLeftImage        = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"popover_bottom_left"]];
        sBottomMiddleImage      = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"popover_bottom_middle"]];
        sBottomRightImage       = [[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:@"popover_bottom_right"]];
    }
}


- (id)initWithFrame:(NSRect)frame {
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}


- (void)dealloc {

    [super dealloc];
}


#pragma mark -
#pragma mark NSView

- (BOOL)isFlipped {
    return YES;
}


- (void)drawRect:(NSRect)dirtyRect {
    NSRect bounds = [self bounds];
    BOOL isFlipped = [self isFlipped];

    CGFloat w = bounds.size.width;
    
    // top
    CGFloat y = 0;
    CGFloat topHeight = [sTopLeftImage size].height;
    NSRect r = NSMakeRect(0, y, w, topHeight);
    NSDrawThreePartImage(r, sTopLeftImage, sTopLeftMiddleImage, sTopRightImage, NO, NSCompositeSourceOver, 1.0, isFlipped);

    // bottom
    CGFloat bottomHeight = [sBottomLeftImage size].height;
    y = NSMaxY(bounds) - bottomHeight;
    r = NSMakeRect(0, y, w, bottomHeight);
    NSDrawThreePartImage(r, sBottomLeftImage, sBottomMiddleImage, sBottomRightImage, NO, NSCompositeSourceOver, 1.0, isFlipped);
    
    // left middle
    y = topHeight;
    CGFloat leftWidth = [sMiddleLeftImage size].width;
    CGFloat h = NSHeight(bounds) - (bottomHeight + topHeight);
    r = NSMakeRect(0, y, leftWidth, h);
    NSDrawThreePartImage(r, sMiddleLeftImage, sMiddleLeftImage, sMiddleLeftImage, YES, NSCompositeSourceOver, 1.0, isFlipped);

    // right middle
    CGFloat rightWidth = [sMiddleRightImage size].width;
    r = NSMakeRect(NSMaxX(bounds) - rightWidth, y, rightWidth, h);
    NSDrawThreePartImage(r, sMiddleRightImage, sMiddleRightImage, sMiddleRightImage, YES, NSCompositeSourceOver, 1.0, isFlipped);
}

@end

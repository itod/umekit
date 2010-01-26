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

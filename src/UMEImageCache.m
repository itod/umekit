//
//  UMEImageCache.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 6/27/10.
//  Copyright 2010 Todd Ditchendorf. All rights reserved.
//

#import "UMEImageCache.h"
#import <UMEKit/UMEToolbar.h>

NSImage *UMEImageNamed(NSString *name) {
    static NSMutableDictionary *sImageCache = nil;

    if (!sImageCache) {
        sImageCache = [[NSMutableDictionary alloc] init];
    }
    
    NSImage *img = [sImageCache objectForKey:name];
    if (!img) {
        NSBundle *b = [NSBundle bundleForClass:[UMEToolbar class]];
        
        img = [[[NSImage alloc] initWithContentsOfFile:[b pathForImageResource:name]] autorelease];
        [sImageCache setObject:img forKey:name];
    }
    
    return img;
}
//
//  UMEImageCache.h
//  UMEKit
//
//  Created by Todd Ditchendorf on 6/27/10.
//  Copyright 2010 Todd Ditchendorf. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSImage *UMEImageNamed(NSString *name);

#define UMEIMG(name) UMEImageNamed((name))

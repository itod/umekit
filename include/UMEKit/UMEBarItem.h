//
//  UMEBarItem.h
//  UMEKit
//
//  Created by Todd Ditchendorf on 10/21/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <UMEKit/UMEGeometry.h>

@interface UMEBarItem : NSObject {
    BOOL enabled;
    NSString *title;
    NSImage *image;
    UMEEdgeInsets imageInsets;
    NSInteger tag;
}

@property (nonatomic, getter=isEnabled) BOOL enabled;       // default is YES
@property (nonatomic, copy) NSString *title;                // default is nil
@property (nonatomic, retain) NSImage *image;               // default is nil
@property (nonatomic) UMEEdgeInsets imageInsets;            // default is UMEEdgeInsetsZero
@property (nonatomic) NSInteger tag;                        // default is 0
@end

//
//  UMEBarButtonItemButton.h
//  UMEKit
//
//  Created by Todd Ditchendorf on 10/21/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class UMEBarButtonItem;

@interface UMEBarButtonItemButton : NSButton {
    UMEBarButtonItem *item;
}

@property (nonatomic, assign) UMEBarButtonItem *item;
@end

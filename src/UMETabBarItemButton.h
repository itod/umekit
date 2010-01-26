//
//  UMETabBarItemButton.h
//  UMEKit
//
//  Created by Todd Ditchendorf on 10/21/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class UMETabBarItem;

@interface UMETabBarItemButton : NSButton {
    UMETabBarItem *item;
}

@property (nonatomic, retain) UMETabBarItem *item;
@end

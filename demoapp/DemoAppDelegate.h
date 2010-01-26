//
//  DemoAppDelegate.h
//  UMEKit
//
//  Created by Todd Ditchendorf on 9/30/09.
//  Copyright 2009 Yahoo! Inc.. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <UMEKit/UMEKit.h>

@interface DemoAppDelegate : NSObject {
    IBOutlet NSWindow *window;
    UMETabBarController *tabBarController;
}

@property (nonatomic, retain) UMETabBarController *tabBarController;
@end

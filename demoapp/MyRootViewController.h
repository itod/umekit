//
//  MyRootViewController.h
//  UMEKit
//
//  Created by Todd Ditchendorf on 10/11/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <UMEKit/UMEKit.h>

@interface MyRootViewController : UMEViewController {
    IBOutlet NSButton *button;
}

- (IBAction)click:(id)sender;
- (IBAction)pop:(id)sender;
@end

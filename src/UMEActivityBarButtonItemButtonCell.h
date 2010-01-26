//
//  UMEActivityBarButtonItemButtonCell.h
//  UMEKit
//
//  Created by Todd Ditchendorf on 10/22/09.
//  Copyright 2009 Yahoo! Inc.. All rights reserved.
//

#import "UMEBarButtonItemButtonCell.h"

@interface UMEActivityBarButtonItemButtonCell : UMEBarButtonItemButtonCell {
	NSTimer *timer;
	NSControl *parentControl;

	double doubleValue;
	NSTimeInterval animationDelay;
	BOOL spinning;
}

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) NSControl *parentControl;

@property (nonatomic) double doubleValue;
@property (nonatomic) NSTimeInterval animationDelay;
@property (nonatomic, getter=isSpinning) BOOL spinning;
@end

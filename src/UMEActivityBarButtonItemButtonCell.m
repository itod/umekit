//
//  UMEActivityBarButtonItemButtonCell.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 10/22/09.
//  Copyright 2009 Yahoo! Inc.. All rights reserved.
//
//  Based on code by Dallas Brown on 12/23/08.
//  http://www.CodeGenocide.com
//  Copyright 2008 Code Genocide. All rights reserved.
//
//  Based on AMIndeterminateProgressIndicatorCell created by Andreas, version date 2007-04-03.
//  http://www.harmless.de
//  Copyright 2007 Andreas Mayer. All rights reserved.

#import "UMEActivityBarButtonItemButtonCell.h"
#import "UMEBarButtonItemButton.h"

#define ConvertAngle(a) (fmod((90.0-(a)), 360.0))

#define DEG2RAD  0.017453292519943295

@interface UMEBarButtonItemButtonCell ()
- (void)commonInit;
- (void)drawBackgroundWithFrame:(NSRect)r inView:(NSView *)cv;
@end

@interface UMEActivityBarButtonItemButtonCell ()
- (void)timerFired:(NSTimer *)t;
@end

@implementation UMEActivityBarButtonItemButtonCell

- (void)commonInit {
    [super commonInit];
    [self setAnimationDelay:4.0/60.0];
    [self setDoubleValue:0.0];
    [self setSpinning:YES];
}


- (void)dealloc {
    self.parentControl = nil;
    self.timer = nil;
	[super dealloc];
}


- (BOOL)isHighlighted {
    return NO;
}


- (void)setDoubleValue:(double)value {
	if (doubleValue != value) {
		doubleValue = value;
		if (doubleValue > 1.0) {
			doubleValue = 1.0;
		} else if (doubleValue < 0.0) {
			doubleValue = 0.0;
		}
	}
}


- (void)setSpinning:(BOOL)value {
	if (spinning != value) {
		spinning = value;
        
		if (value) {
			if (!timer) {
				self.timer = [[NSTimer scheduledTimerWithTimeInterval:animationDelay target:self selector:@selector(timerFired:) userInfo:NULL repeats:YES] retain];
			} else {
				[timer fire];
			}
		} else {
			[timer invalidate];
		}
	}
}


- (void)timerFired:(NSTimer *)t {
	double value = fmod(([self doubleValue] + (5.0/60.0)), 1.0);
    
	[self setDoubleValue:value];
    
	if (parentControl) {
		[parentControl setNeedsDisplay:YES];
	}
}


- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    if (!parentControl) {
        self.parentControl = (NSControl *)controlView;
    }
    
    [super drawBackgroundWithFrame:cellFrame inView:controlView];
    
    cellFrame = NSInsetRect(cellFrame, 11.5, 11.5);

	if ([self isSpinning]) {
		float flipFactor = ([controlView isFlipped] ? 1.0 : -1.0);
		int step = round([self doubleValue]/(5.0/60.0));
		float cellSize = MIN(cellFrame.size.width, cellFrame.size.height);
		NSPoint center = cellFrame.origin;
		center.x += cellSize/2.0;
		center.y += cellFrame.size.height/2.0;
		float outerRadius;
		float innerRadius;
		float strokeWidth = cellSize*0.08;
		if (cellSize >= 32.0) {
			outerRadius = cellSize*0.38;
			innerRadius = cellSize*0.23;
		} else {
			outerRadius = cellSize*0.48;
			innerRadius = cellSize*0.27;
		}
		float a; // angle
		NSPoint inner;
		NSPoint outer;
		[NSBezierPath setDefaultLineCapStyle:NSRoundLineCapStyle];
		[NSBezierPath setDefaultLineWidth:strokeWidth];
		if ([self isSpinning]) {
			a = (270+(step* 30))*DEG2RAD;
		} else {
			a = 270*DEG2RAD;
		}
		a = flipFactor*a;
		int i;
        
		for (i = 0; i < 12; i++) {
			if (i == 0) {
				[[NSColor colorWithCalibratedWhite:1.0 alpha:1.0] set];
			} else {
				[[NSColor colorWithCalibratedWhite:MIN(sqrt(i)*0.5, 0.8) alpha:1.0] set];
			}
			
			outer = NSMakePoint(center.x+cos(a)*outerRadius, center.y+sin(a)*outerRadius);
			inner = NSMakePoint(center.x+cos(a)*innerRadius, center.y+sin(a)*innerRadius);
			[NSBezierPath strokeLineFromPoint:inner toPoint:outer];
			a -= flipFactor*30*DEG2RAD;
		}
	}
}


- (void)setObjectValue:(id)value {
	if ([value respondsToSelector:@selector(boolValue)]) {
		[self setSpinning:[value boolValue]];
	} else {
		[self setSpinning:NO];
	}
}

@synthesize timer;
@synthesize parentControl;
@synthesize doubleValue;
@synthesize animationDelay;
@synthesize spinning;
@end

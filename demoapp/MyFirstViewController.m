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

#import "MyFirstViewController.h"
#import "MySecondViewController.h"
#import "MyThirdViewController.h"

@implementation MyFirstViewController

- (id)init {
    if (self = [super initWithNibName:@"FirstView" bundle:nil]) {
        self.title = @"First";
    }
    return self;
}


- (void)dealloc {
    
    [super dealloc];
}


- (void)viewDidLoad {
//    self.navigationItem.leftBarButtonItem = [[[UMEBarButtonItem alloc] initWithTitle:@"1 left" 
//                                                                               style:UMEBarButtonItemStylePlain 
//                                                                              target:self 
//                                                                              action:@selector(back:)] autorelease];
    
    self.navigationItem.rightBarButtonItem = [[[UMEBarButtonItem alloc] initWithTitle:@"BARRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR" 
                                                                                style:UMEBarButtonItemStylePlain 
                                                                               target:self 
                                                                               action:@selector(home:)] autorelease];
}


- (void)viewDidUnload {
    
}


- (void)viewWillAppear:(BOOL)animated {
    
}


- (void)viewDidAppear:(BOOL)animated {
    
}


- (void)viewWillDisappear:(BOOL)animated {
    
}


- (void)viewDidDisappear:(BOOL)animated {
    
}


- (IBAction)click:(id)sender {
//    MyFirstViewController *vc = [[[MyFirstViewController alloc] init] autorelease];
//    [self.navigationController pushViewController:vc animated:YES];

    MySecondViewController *vc = [[[MySecondViewController alloc] init] autorelease];
    [self.navigationController pushViewController:vc animated:YES];
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)home:(id)sender {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

@end

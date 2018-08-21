//
//  PresentingViewController.m
//  Texture
//
//  Copyright (c) 2017-present, Pinterest, Inc.  All rights reserved.
//  Licensed under the Apache License, Version 2.0 (the "License").
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//

#import "PresentingViewController.h"
#import "ViewController.h"

@interface PresentingViewController ()

@end

@implementation PresentingViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Push Details"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(pushNewViewController)];
}

- (void)pushNewViewController
{
  ViewController *controller = [[ViewController alloc] init];
  [self.navigationController pushViewController:controller animated:true];
}

@end

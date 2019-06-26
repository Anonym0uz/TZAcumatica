//
//  InitialViewController.m
//  TZAcumatica
//
//  Created by Alexander Orlov on 25/06/2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import "InitialViewController.h"
#import "InitialModel.h"
#import "InitialView.h"

@interface InitialViewController () <InitViewDelegate>
@property NSMutableArray *dataArray;
@property NSMutableArray *schemeArray;
@property InitialView *initialView;
@end

@implementation InitialViewController
// Swift like syntax
@synthesize dataArray;
@synthesize schemeArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self createMainElements];
}

- (void)createMainElements {
    
    self.initialView = [[InitialView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.initialView.delegate = self;
    [self.view addSubview:self.initialView];
    
    dataArray = [NSMutableArray new];
    schemeArray = [NSMutableArray new];
    
    [self getDataFromModel];
}

- (void)getDataFromModel {
    [[InitialModel sharedModel] loadDataFromPlist:^(BOOL success, NSDictionary *data) {
        [self->dataArray addObjectsFromArray:[data objectForKey:@"data"]];
        [self->schemeArray addObjectsFromArray:[data objectForKey:@"scheme"]];
        
        [self.initialView updateData:self->dataArray];
    }];
}


- (void)cellDidSelect {
    NSLog(@"Cell selected!");
}

@end

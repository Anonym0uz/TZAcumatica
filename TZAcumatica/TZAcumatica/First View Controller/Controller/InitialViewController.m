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
#import "InfoViewController.h"

@interface InitialViewController () <InitViewDelegate>
@property NSMutableArray *dataArray;
@property NSMutableArray *schemeArray;
@property InitialView *initialView;
@property NSInteger selectedIndex;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoViewDismissed:) name:@"InfoVCDismissed" object:nil];
    
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


- (void)cellDidSelect:(NSInteger)selectedCellIndex {
    NSLog(@"Cell selected!");
    InfoViewController *infoVC = [[InfoViewController alloc] init];
    infoVC.dataDict = self.dataArray[selectedCellIndex];
    self.selectedIndex = selectedCellIndex;
    infoVC.schemeArray = self.schemeArray;
    UINavigationController *navCtr = [[UINavigationController alloc] initWithRootViewController:infoVC];
    [self presentViewController:navCtr animated:true completion:nil];
}

- (void)cellRemoveByIndex:(NSInteger)indexRemoveCell {
    [self.dataArray removeObjectAtIndex:indexRemoveCell];
}

- (void)infoViewDismissed:(NSNotification *)notification {
    if (notification.userInfo != nil) {
        [self.dataArray replaceObjectAtIndex:self.selectedIndex withObject:[notification.userInfo objectForKey:@"newModel"]];
        [self.initialView updateData:self.dataArray];
        [self.initialView.tableView reloadData];
    }
}

@end

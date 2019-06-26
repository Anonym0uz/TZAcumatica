//
//  InitialView.h
//  TZAcumatica
//
//  Created by Alexander Orlov on 25/06/2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InitViewDelegate <NSObject>
- (void)cellDidSelect;
@end

@interface InitialTBCell : UITableViewCell

@property UILabel *nameModelField;
@property UILabel *lastNameModelField;
@property UILabel *birthdayModelField;
@property UILabel *childrenModelField;

@property UILabel *nameField;
@property UILabel *lastNameField;
@property UILabel *birthdayField;
@property UILabel *childrenField;
@end

@interface InitialView : UIView <UITableViewDelegate, UITableViewDataSource>
@property id<InitViewDelegate> delegate;
@property UITableView *tableView;
@property NSArray *datas;
- (id)initWithFrame:(CGRect)frame;
- (void)updateData:(NSArray *)arr;
@end

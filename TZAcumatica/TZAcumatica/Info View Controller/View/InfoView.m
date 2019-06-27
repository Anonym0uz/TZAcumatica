//
//  InfoView.m
//  TZAcumatica
//
//  Created by Alexander Orlov on 26/06/2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import "InfoView.h"

@implementation InfoView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createElements];
    }
    return self;
}

- (void)createElements {
    self.tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[InfoTBCell class] forCellReuseIdentifier:@"TBCell"];
    [self addSubview:self.tableView];
}

- (void)updateData:(NSArray *)arr {
    self.datas = [NSArray arrayWithArray:arr];
    [self.tableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    InfoTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TBCell" forIndexPath:indexPath];
    NSDictionary *dict = self.datas[indexPath.row];
    if ([[dict objectForKey:@"name"]  isEqual: @""]) { cell.nameField.text = @"-"; }
    else { cell.nameField.text = [dict objectForKey:@"name"]; }
    if ([[dict objectForKey:@"lastName"]  isEqual: @""]) { cell.lastNameField.text = @"-"; }
    else { cell.lastNameField.text = [dict objectForKey:@"lastName"]; }
    if ([[dict objectForKey:@"birthdate"]  isEqual: @""]) { cell.birthdayField.text = @"-"; }
    else { cell.birthdayField.text = [dict objectForKey:@"birthdate"]; }
    if ([[dict objectForKey:@"childrenCount"]  isEqual: @""]) { cell.childrenField.text = @"-"; }
    else { cell.childrenField.text = [dict objectForKey:@"childrenCount"]; }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self.delegate cellDidSelect];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datas count];
}

@end

@implementation InfoTBCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createElements];
    }
    return self;
}

- (void)createElements {
    
    self.nameModelField = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nameModelField.text = @"Имя:";
    self.nameModelField.translatesAutoresizingMaskIntoConstraints = false;
    self.lastNameModelField = [[UILabel alloc] initWithFrame:CGRectZero];
    self.lastNameModelField.text = @"Фамилия:";
    self.lastNameModelField.translatesAutoresizingMaskIntoConstraints = false;
    self.birthdayModelField = [[UILabel alloc] initWithFrame:CGRectZero];
    self.birthdayModelField.text = @"Дата рождения:";
    self.birthdayModelField.translatesAutoresizingMaskIntoConstraints = false;
    self.childrenModelField = [[UILabel alloc] initWithFrame:CGRectZero];
    self.childrenModelField.text = @"Количество детей:";
    self.childrenModelField.translatesAutoresizingMaskIntoConstraints = false;
    
    self.nameField = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nameField.translatesAutoresizingMaskIntoConstraints = false;
    self.lastNameField = [[UILabel alloc] initWithFrame:CGRectZero];
    self.lastNameField.translatesAutoresizingMaskIntoConstraints = false;
    self.birthdayField = [[UILabel alloc] initWithFrame:CGRectZero];
    self.birthdayField.translatesAutoresizingMaskIntoConstraints = false;
    self.childrenField = [[UILabel alloc] initWithFrame:CGRectZero];
    self.childrenField.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.contentView addSubview:self.nameModelField];
    [self.contentView addSubview:self.lastNameModelField];
    [self.contentView addSubview:self.birthdayModelField];
    [self.contentView addSubview:self.childrenModelField];
    
    [self.contentView addSubview:self.nameField];
    [self.contentView addSubview:self.lastNameField];
    [self.contentView addSubview:self.birthdayField];
    [self.contentView addSubview:self.childrenField];
    
    [self.nameModelField.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10].active = true;
    [self.nameModelField.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10].active = true;
    
    [self.lastNameModelField.topAnchor constraintEqualToAnchor:self.nameModelField.bottomAnchor constant:10].active = true;
    [self.lastNameModelField.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10].active = true;
    
    [self.birthdayModelField.topAnchor constraintEqualToAnchor:self.lastNameModelField.bottomAnchor constant:10].active = true;
    [self.birthdayModelField.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10].active = true;
    
    [self.childrenModelField.topAnchor constraintEqualToAnchor:self.birthdayModelField.bottomAnchor constant:10].active = true;
    [self.childrenModelField.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10].active = true;
    
    [self.nameField.centerYAnchor constraintEqualToAnchor:self.nameModelField.centerYAnchor].active = true;
    [self.nameField.leadingAnchor constraintEqualToAnchor:self.nameModelField.trailingAnchor constant:10].active = true;
    
    [self.lastNameField.centerYAnchor constraintEqualToAnchor:self.lastNameModelField.centerYAnchor].active = true;
    [self.lastNameField.leadingAnchor constraintEqualToAnchor:self.lastNameModelField.trailingAnchor constant:10].active = true;
    
    [self.birthdayField.centerYAnchor constraintEqualToAnchor:self.birthdayModelField.centerYAnchor].active = true;
    [self.birthdayField.leadingAnchor constraintEqualToAnchor:self.birthdayModelField.trailingAnchor constant:10].active = true;
    
    [self.childrenField.centerYAnchor constraintEqualToAnchor:self.childrenModelField.centerYAnchor].active = true;
    [self.childrenField.leadingAnchor constraintEqualToAnchor:self.childrenModelField.trailingAnchor constant:10].active = true;
}
@end

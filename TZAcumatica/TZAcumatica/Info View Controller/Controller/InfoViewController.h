//
//  InfoViewController.h
//  TZAcumatica
//
//  Created by Alexander Orlov on 26/06/2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController
@property NSDictionary *dataDict;
@property NSArray *schemeArray;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UITextField *nameField;
@property (nonatomic, weak) IBOutlet UILabel *lastNameLabel;
@property (nonatomic, weak) IBOutlet UITextField *lastNameField;
@property (nonatomic, weak) IBOutlet UILabel *birthdayLabel;
@property (nonatomic, weak) IBOutlet UITextField *birthdayField;
@property (nonatomic, weak) IBOutlet UILabel *childrenLabel;
@property (nonatomic, weak) IBOutlet UITextField *childrenField;
@end

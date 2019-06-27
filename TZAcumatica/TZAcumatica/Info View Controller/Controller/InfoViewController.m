//
//  InfoViewController.m
//  TZAcumatica
//
//  Created by Alexander Orlov on 26/06/2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import "InfoViewController.h"
#import "InitialModel.h"

@interface InfoViewController () <UITextFieldDelegate>
@property UIBarButtonItem *rightButton;
@property NSMutableDictionary *internalDataDict;
@property NSArray *internalSchemeArray;
@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = self.rightButton;
    
    [self createViewElements];
}

- (void)createViewElements {
    self.internalDataDict = [[NSMutableDictionary alloc] initWithDictionary:self.dataDict];
    self.internalSchemeArray = self.schemeArray;
    
    for (int i=0; i<4; i++) {
        if ([[self.internalSchemeArray[i] objectForKey:@"id"] isEqualToString:@"name"]) {
            self.nameLabel = [self
                              labelWithTitle:[self.internalSchemeArray[i] objectForKey:@"title"]
                              Id:[self.internalSchemeArray[i] objectForKey:@"id"]
                              childrenCount:[self.internalSchemeArray[i] objectForKey:@"childrenCount"]
                              require:[[self.internalSchemeArray[i] objectForKey:@"required"] boolValue]];
            self.nameField = [self
                              fieldWithText:[self.internalDataDict objectForKey:@"name"]
                              placeholder:[self.internalSchemeArray[i] objectForKey:@"title"]
                              tagField:1
                              require:[[self.internalSchemeArray[i] objectForKey:@"required"] boolValue]];
        } else if ([[self.internalSchemeArray[i] objectForKey:@"id"] isEqualToString:@"lastName"]) {
            self.lastNameLabel = [self
                                  labelWithTitle:[self.internalSchemeArray[i] objectForKey:@"title"]
                                  Id:[self.internalSchemeArray[i] objectForKey:@"id"]
                                  childrenCount:[self.internalSchemeArray[i] objectForKey:@"childrenCount"]
                                  require:[[self.internalSchemeArray[i] objectForKey:@"required"] boolValue]];
            self.lastNameField = [self
                                  fieldWithText:[self.internalDataDict objectForKey:@"lastName"]
                                  placeholder:[self.internalSchemeArray[i] objectForKey:@"title"]
                                  tagField:2
                                  require:[[self.internalSchemeArray[i] objectForKey:@"required"] boolValue]];
        } else if ([[self.internalSchemeArray[i] objectForKey:@"id"] isEqualToString:@"birthdate"]) {
            self.birthdayLabel = [self
                                  labelWithTitle:[self.internalSchemeArray[i] objectForKey:@"title"]
                                  Id:[self.internalSchemeArray[i] objectForKey:@"id"]
                                  childrenCount:[self.internalSchemeArray[i] objectForKey:@"childrenCount"]
                                  require:[[self.internalSchemeArray[i] objectForKey:@"required"] boolValue]];
            self.birthdayField = [self
                                  fieldWithText:[self.internalDataDict objectForKey:@"birthdate"]
                                  placeholder:[self.internalSchemeArray[i] objectForKey:@"title"]
                                  tagField:3
                                  require:[[self.internalSchemeArray[i] objectForKey:@"required"] boolValue]];
        } else if ([[self.internalSchemeArray[i] objectForKey:@"id"] isEqualToString:@"childrenCount"]) {
            self.childrenLabel = [self
                                  labelWithTitle:[self.internalSchemeArray[i] objectForKey:@"title"]
                                  Id:[self.internalSchemeArray[i] objectForKey:@"id"]
                                  childrenCount:[self.internalSchemeArray[i] objectForKey:@"childrenCount"]
                                  require:[[self.internalSchemeArray[i] objectForKey:@"required"] boolValue]];
            self.childrenField = [self
                                  fieldWithText:[self.internalDataDict objectForKey:@"childrenCount"]
                                  placeholder:[self.internalSchemeArray[i] objectForKey:@"title"]
                                  tagField:4
                                  require:[[self.internalSchemeArray[i] objectForKey:@"required"] boolValue]];
        }
    }
    
    [self setupConstraints];
}

- (void)saveAction {
    for (int i=0; i<3; i++) {
        [self checkTF:i+1];
    }
    
    if (self.nameField.layer.borderColor == UIColor.blackColor.CGColor &&
        self.lastNameField.layer.borderColor == UIColor.blackColor.CGColor &&
        self.birthdayField.layer.borderColor == UIColor.blackColor.CGColor &&
        self.childrenField.layer.borderColor == UIColor.blackColor.CGColor) {
        NSLog(@"Save!");
        
        if ([self.nameField.text isEqualToString:@""]) { [self.internalDataDict setValue:@"-" forKey:@"name"]; }
        else { [self.internalDataDict setValue:self.nameField.text forKey:@"name"]; }
        
        if ([self.lastNameField.text isEqualToString:@""]) { [self.internalDataDict setValue:@"-" forKey:@"lastName"]; }
        else { [self.internalDataDict setValue:self.lastNameField.text forKey:@"lastName"]; }
        
        if ([self.birthdayField.text isEqualToString:@""]) { [self.internalDataDict setValue:@"-" forKey:@"birthdate"]; }
        else { [self.internalDataDict setValue:self.birthdayField.text forKey:@"birthdate"]; }
        
        if ([self.childrenField.text isEqualToString:@""]) { [self.internalDataDict setValue:@"-" forKey:@"childrenCount"]; }
        else { [self.internalDataDict setValue:self.childrenField.text forKey:@"childrenCount"]; }
        
        [self dismissViewControllerAnimated:true completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"InfoVCDismissed" object:nil userInfo:@{@"newModel" : self.internalDataDict}];
        }];
    }
}

- (void)checkTF:(NSInteger)tfTag {
    if (tfTag == 1 && [[self.internalSchemeArray[tfTag] objectForKey:@"required"] boolValue]) {
        if ([self.nameField.text isEqual: @""]) { self.nameField.layer.borderColor = UIColor.redColor.CGColor; }
        else { self.nameField.layer.borderColor = UIColor.blackColor.CGColor; }
    } else if (tfTag == 2 && [[self.internalSchemeArray[tfTag] objectForKey:@"required"] boolValue]) {
        if ([self.lastNameField.text isEqual: @""]) { self.lastNameField.layer.borderColor = UIColor.redColor.CGColor; }
        else { self.lastNameField.layer.borderColor = UIColor.blackColor.CGColor; }
    } else if (tfTag == 3 && [[self.internalSchemeArray[tfTag] objectForKey:@"required"] boolValue]) {
        if ([self.birthdayField.text isEqual: @""]) { self.birthdayField.layer.borderColor = UIColor.redColor.CGColor; }
        else { self.birthdayField.layer.borderColor = UIColor.blackColor.CGColor; }
    } else if (tfTag == 4 && [[self.internalSchemeArray[tfTag] objectForKey:@"required"] boolValue]) {
        if ([self.childrenField.text isEqual: @""]) { self.childrenField.layer.borderColor = UIColor.redColor.CGColor; }
        else { self.childrenField.layer.borderColor = UIColor.blackColor.CGColor; }
    }
}

- (void)setupConstraints {
    [self.nameLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20].active = true;
    [self.nameLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = true;
    [self.nameLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = true;
    
    [self.nameField.topAnchor constraintEqualToAnchor:self.nameLabel.bottomAnchor constant:5].active = true;
    [self.nameField.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = true;
    [self.nameField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = true;
    [self.nameField.heightAnchor constraintEqualToConstant:40].active = true;
    
    
    
    [self.lastNameLabel.topAnchor constraintEqualToAnchor:self.nameField.bottomAnchor constant:10].active = true;
    [self.lastNameLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = true;
    [self.lastNameLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = true;
    
    [self.lastNameField.topAnchor constraintEqualToAnchor:self.lastNameLabel.bottomAnchor constant:5].active = true;
    [self.lastNameField.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = true;
    [self.lastNameField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = true;
    [self.lastNameField.heightAnchor constraintEqualToConstant:40].active = true;
    
    
    
    [self.birthdayLabel.topAnchor constraintEqualToAnchor:self.lastNameField.bottomAnchor constant:10].active = true;
    [self.birthdayLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = true;
    [self.birthdayLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = true;
    
    [self.birthdayField.topAnchor constraintEqualToAnchor:self.birthdayLabel.bottomAnchor constant:5].active = true;
    [self.birthdayField.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = true;
    [self.birthdayField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = true;
    [self.birthdayField.heightAnchor constraintEqualToConstant:40].active = true;
    
    
    
    [self.childrenLabel.topAnchor constraintEqualToAnchor:self.birthdayField.bottomAnchor constant:10].active = true;
    [self.childrenLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = true;
    [self.childrenLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = true;
    
    [self.childrenField.topAnchor constraintEqualToAnchor:self.childrenLabel.bottomAnchor constant:5].active = true;
    [self.childrenField.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = true;
    [self.childrenField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = true;
    [self.childrenField.heightAnchor constraintEqualToConstant:40].active = true;
}

- (UILabel *)labelWithTitle:(NSString *)title Id:(NSString *)Id childrenCount:(NSString *)childrenCount require:(BOOL)required {
    UILabel *lbl = [UILabel new];
    lbl.translatesAutoresizingMaskIntoConstraints = false;
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.text = title;
    [self.view addSubview:lbl];
    return lbl;
}

- (UITextField *)fieldWithText:(NSString *)text placeholder:(NSString *)placeholder tagField:(NSInteger)tag require:(BOOL)required {
    UITextField *tf = [UITextField new];
    tf.translatesAutoresizingMaskIntoConstraints = false;
    tf.text = text;
    if ([text isEqual:@""]) { tf.placeholder = placeholder; }
    tf.tag = tag;
    tf.delegate = self;
    tf.clipsToBounds = true;
    tf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 40)];
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 40)];
    tf.rightViewMode = UITextFieldViewModeAlways;
    tf.layer.cornerRadius = 10;
    tf.layer.borderColor = UIColor.blackColor.CGColor;
    tf.layer.borderWidth = 1.0f;
    [tf addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:tf];
    return tf;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        
    } else if (textField.tag == 2) {
        
    } else if (textField.tag == 3) {
        
    } else if (textField.tag == 4) {
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        
    } else if (textField.tag == 2) {
        
    } else if (textField.tag == 3) {
        
    } else if (textField.tag == 4) {
        
    }
}

- (void)textFieldChanged:(UITextField *)textField {
    if (textField.tag == 1) {
        
    } else if (textField.tag == 2) {
        
    } else if (textField.tag == 3) {
        
    } else if (textField.tag == 4) {
        
    }
}

@end

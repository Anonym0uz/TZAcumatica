//
//  InitialModel.h
//  TZAcumatica
//
//  Created by Alexander Orlov on 25/06/2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NameModel : NSObject
@property(nonatomic, strong) NSString *Id;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *type;
@property BOOL required;

- (id)initWithId:(NSString *)Id title:(NSString *)title type:(NSString *)type required:(BOOL)required;
@end

@interface LastNameModel : NSObject
@property(nonatomic, strong) NSString *Id;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *type;
@property BOOL required;

- (id)initWithId:(NSString *)Id title:(NSString *)title type:(NSString *)type required:(BOOL)required;
@end

@interface BirthdayModel : NSObject
@property(nonatomic, strong) NSString *Id;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *type;
@property BOOL required;

- (id)initWithId:(NSString *)Id title:(NSString *)title type:(NSString *)type required:(BOOL)required;
@end

@interface ChildrenModel : NSObject
@property(nonatomic, strong) NSString *Id;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *type;
@property BOOL required;

- (id)initWithId:(NSString *)Id title:(NSString *)title type:(NSString *)type required:(BOOL)required;
@end

@interface SchemeMain : NSObject
@property (nonatomic, strong) NameModel *name;
@property (nonatomic, strong) LastNameModel *lastName;
@property (nonatomic, strong) BirthdayModel *birthday;
@property (nonatomic, strong) ChildrenModel *children;
@end

@interface InitialModel : NSObject
+ (InitialModel *)sharedModel;
- (void)loadDataFromPlist:(void(^)(BOOL success, NSDictionary *data))completeHandler;

@end

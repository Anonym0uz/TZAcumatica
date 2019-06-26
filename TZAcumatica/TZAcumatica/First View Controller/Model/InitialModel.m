//
//  InitialModel.m
//  TZAcumatica
//
//  Created by Alexander Orlov on 25/06/2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import "InitialModel.h"
#import "InitialViewController.h"

@implementation NameModel
- (id)initWithId:(NSString *)Id title:(NSString *)title type:(NSString *)type required:(BOOL)required {
    self.Id = Id;
    self.title = title;
    self.type = type;
    self.required = required;
    return self;
}
@end

@implementation LastNameModel
- (id)initWithId:(NSString *)Id title:(NSString *)title type:(NSString *)type required:(BOOL)required {
    self.Id = Id;
    self.title = title;
    self.type = type;
    self.required = required;
    return self;
}
@end

@implementation BirthdayModel
- (id)initWithId:(NSString *)Id title:(NSString *)title type:(NSString *)type required:(BOOL)required {
    self.Id = Id;
    self.title = title;
    self.type = type;
    self.required = required;
    return self;
}
@end

@implementation ChildrenModel
- (id)initWithId:(NSString *)Id title:(NSString *)title type:(NSString *)type required:(BOOL)required {
    self.Id = Id;
    self.title = title;
    self.type = type;
    self.required = required;
    return self;
}
@end

@implementation SchemeMain
@end

@implementation InitialModel

+ (InitialModel *)sharedModel {
    static InitialModel *_sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedModel = [[InitialModel alloc] init];
    });
    return _sharedModel;
}

- (void)loadDataFromPlist:(void(^)(BOOL success, NSDictionary *data))completeHandler {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"input" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSDictionary *dictSchemes = [NSDictionary new];
    NSArray *arraySchemes = [dict objectForKey:@"scheme"];
    for (int i=0; i<[[dict objectForKey:@"scheme"] count]; i++) {
        dictSchemes = arraySchemes[i];
        SchemeMain *scheme = [self putToModel:[dictSchemes objectForKey:@"id"] title:[dictSchemes objectForKey:@"title"] type:[dictSchemes objectForKey:@"type"] required:[[dictSchemes objectForKey:@"required"] boolValue]];
        NSLog(@"%@", scheme);
    }
    completeHandler(true, dict);
}

- (SchemeMain *)putToModel:(NSString *)Id title:(NSString *)title type:(NSString *)type required:(BOOL)required {
    SchemeMain *scheme = [SchemeMain new];
    if ([Id isEqualToString:@"name"]) {
        scheme.name = [[NameModel alloc] initWithId:Id title:title type:type required:required];
    } else if ([Id isEqualToString:@"lastName"]) {
        scheme.lastName = [[LastNameModel alloc] initWithId:Id title:title type:type required:required];
    } else if ([Id isEqualToString:@"birthdate"]) {
        scheme.birthday = [[BirthdayModel alloc] initWithId:Id title:title type:type required:required];
    } else if ([Id isEqualToString:@"childrenCount"]) {
        scheme.children = [[ChildrenModel alloc] initWithId:Id title:title type:type required:required];
    }
    return scheme;
}

@end

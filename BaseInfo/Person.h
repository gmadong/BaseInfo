//
//  Person.h
//  DBTool
//
//  Created by caodong on 16/5/20.
//  Copyright © 2016年 caodong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseInfo.h"

@interface Person : BaseInfo

@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)int age;

+(instancetype)initName:(NSString*)name age:(int)age;

@end

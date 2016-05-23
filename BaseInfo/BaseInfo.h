//
//  BaseInfo.h
//  BaseInfo
//
//  Created by caodong on 16/5/23.
//  Copyright © 2016年 caodong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseInfo : NSObject<NSCoding>

+(void)save:(BaseInfo*)info;
+(BaseInfo *)initInfoWithClass:(Class)clazz;

@end

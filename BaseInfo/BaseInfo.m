//
//  BaseInfo.m
//  BaseInfo
//
//  Created by caodong on 16/5/23.
//  Copyright © 2016年 caodong. All rights reserved.

#import "BaseInfo.h"
#import <objc/runtime.h>

@implementation BaseInfo

-(void)encodeWithCoder:(NSCoder *)encoder
{
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([self class],&count);
    for (int i=0; i<count; i++)
    {
        Ivar ivar =  ivarList[i];
        NSString *key =  [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        id value = [self valueForKey:key];
        [encoder encodeObject:value forKey:key];
    }
    free(ivarList);
}
-(instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        unsigned int count = 0;
        Ivar *ivarList = class_copyIvarList([self class],&count);
        for (int i=0; i<count; i++)
        {
            Ivar ivar =  ivarList[i];
            NSString *key =  [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
            id value = [decoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivarList);
    }
    return self;
}
+(void)save:(BaseInfo *)info
{
    const char *className = class_getName([info class]);
    NSString *classNameStr =[[NSString alloc] initWithUTF8String:className];
    NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",classNameStr]];
    [NSKeyedArchiver archiveRootObject:info toFile:path];
}

+(BaseInfo *)initInfoWithClass:(Class)clazz
{
    const char *className = class_getName(clazz);
    NSString *classNameStr =[[NSString alloc] initWithUTF8String:className];
    NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",classNameStr]];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

@end

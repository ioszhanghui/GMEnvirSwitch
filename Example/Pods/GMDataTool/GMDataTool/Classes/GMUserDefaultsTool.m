//
//  GMUserDefaultsTool.m
//  FBSnapshotTestCase
//
//  Created by 小飞鸟 on 2019/09/30.
//

#import "GMUserDefaultsTool.h"

@implementation GMUserDefaultsTool

//保存对象类型
+(void)setUserDefaultsValue:(id)value forKey:(NSString*)key{
    
    NSUserDefaults * defalut = [NSUserDefaults standardUserDefaults];
    [defalut setObject:value forKey:key];
    [defalut synchronize];
}
//获取对应的value值
-(id)getUserDefaultsVlaueForKey:(NSString*)key{
    
    if (!key) {
        return nil;
    }
    NSUserDefaults * defalut = [NSUserDefaults standardUserDefaults];
   id value = [defalut objectForKey:key];
    return value;
}

//保存bool类型
+(void)setUserDefaultsBoolValue:(BOOL)value forKey:(NSString*)key{
    NSUserDefaults * defalut = [NSUserDefaults standardUserDefaults];
    [defalut setBool:value forKey:key];
    [defalut synchronize];
}
//获取对应的value值
-(BOOL)getUserDefaultsBoolValueForKey:(NSString*)key{
    if (!key) {
        return NO;
    }
    NSUserDefaults * defalut = [NSUserDefaults standardUserDefaults];
    BOOL value = [defalut boolForKey:key];
    return value;
}

//保存基本数据类型
+(void)setUserDefaultIntegerValue:(NSInteger)value forKey:(NSString*)key{
    NSUserDefaults * defalut = [NSUserDefaults standardUserDefaults];
    [defalut setInteger:value forKey:key];
    [defalut synchronize];
}
//获取对应的value值
-(NSInteger)getUserDefaultsIntegerValueForKey:(NSString*)key{
    if (!key) {
        return 0;
    }
    NSUserDefaults * defalut = [NSUserDefaults standardUserDefaults];
    NSInteger value = [defalut integerForKey:key];
    return value;
}

//清楚所有的 UserDefaults缓存
-(void)removeUserDefaultsForKey:(NSString*)key{
    NSUserDefaults * defalut = [NSUserDefaults standardUserDefaults];
    [defalut removeObjectForKey:key];
    [defalut synchronize];
}

//清除 所有的userDefaults保存
+(void)removeAllUserDefaults{
    [NSUserDefaults resetStandardUserDefaults];
}

@end

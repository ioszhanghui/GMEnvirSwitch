//
//  GMUserDefaultsTool.h
//  FBSnapshotTestCase
//
//  Created by 小飞鸟 on 2019/09/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMUserDefaultsTool : NSObject
//保存对象类型
+(void)setUserDefaultsObjectValue:(id)value forKey:(NSString*)key;
//获取对应的value值
+(id)getUserDefaultsObjectValueForKey:(NSString*)key;


//保存bool类型
+(void)setUserDefaultsBoolValue:(BOOL)value forKey:(NSString*)key;
//获取对应的value值
-(BOOL)getUserDefaultsBoolValueForKey:(NSString*)key;

//保存基本数据类型
+(void)setUserDefaultIntegerValue:(NSInteger)value forKey:(NSString*)key;
//获取对应的value值
+(NSInteger)getUserDefaultsIntegerValueForKey:(NSString*)key;

//清楚所有的 UserDefaults缓存
+(void)removeUserDefaultsForKey:(NSString*)key;

//清除 所有的userDefaults保存
+(void)removeAllUserDefaults;

@end

NS_ASSUME_NONNULL_END

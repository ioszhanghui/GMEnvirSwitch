//
//  NSObject+ProtocolMethod.h
//  FBSnapshotTestCase
//
//  Created by 小飞鸟 on 2019/09/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CategoryMethod)

/*为某一个类 添加协议*/
+ (void)addProtocol:(NSString *)protocolName toClass:(Class)className;

/*替换某一个方法的实现*/
+(void)swizzleObjectMethod:(SEL)originSel SwizzleSel:(SEL)swizzleSel;
/*为某一个类 添加实例方法*/
+(void)addMethod:(SEL)sel Toclass:(Class)class FuncClass:(Class)funcClass;

@end

NS_ASSUME_NONNULL_END

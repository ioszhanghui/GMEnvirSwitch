//
//  GMEnvirSwitch.h
//  FBSnapshotTestCase
//
//  Created by 小飞鸟 on 2019/09/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMEnvirSwitch : UIView
/*单例*/
@property(nonatomic,class,readonly)GMEnvirSwitch * envirSwitch;
/*初始化环境切换*/
+(void)setUpEnvirSwitchDelegate:(id)delegate;
/*获取当前的环境类型*/
+(NSString*)currentEnvirType;
/*获取当前的URL 环境配置*/
+(NSArray*)currentEnvirConfig;
/*获取当前某一个模块的 dormain域名*/
+(NSString*)getURLForModule:(NSString*)module;

@end

NS_ASSUME_NONNULL_END

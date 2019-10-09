//
//  macros.h
//  GomeShop
//
//  Created by ued1 on 2018/6/26.
//  Copyright © 2018年 mshop. All rights reserved.
//

#ifndef macros_h
#define macros_h

//适配iOS11的代码
#define  adjustsScrollViewInsets(scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)

#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define TSLog(format, ...) printf("\nclass: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define NSLog(fmt, ...) do { } while(0);
#define TSLog(...);/** 防止控制台打印数据不全 */
#endif

/** 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width
/** 适配比例 */
#define kWidthRatio ScreenW/375.f


/****************************************字体适配*******************************/
#define AdapterFont(fontSize) ScreenW/375.0*fontSize

/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;
#define BLOCKSELF __block typeof(self) blockSelf = self;

/**判断字符串是否为空*/
#define NULLString(string) ((string == nil) || [string isKindOfClass:[NSNull class]]||[string isEqualToString:@""] ||[string isEqual:[NSNull null]]||([string length] == 0)  || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0 )

#define TO_STR(obj) ((obj==NULL||[[NSString stringWithFormat:@"%@",obj] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",obj] isEqualToString:@"null"])?@"":[NSString stringWithFormat:@"%@",obj])

//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]])
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || ![dic isKindOfClass:[NSDictionary class]] || dic.allKeys.count == 0)


/*****************  屏幕适配  ******************/
#define iPhoneX  (ScreenH == 812)
#define iphone6p (ScreenH == 763)
#define iphone6 (ScreenH == 667)
#define iphone5 (ScreenH == 568)
#define iphone4 (ScreenH == 480)

/*
iPhoneX 的分辨率：2436 * 1125 || pt: 812 * 375
iPhoneXr的分辨率：1792 * 828 || pt: 896 * 414  这个是官网数据  模拟器分辨率为1624 * 750
iPhoneXs 的分辨率： 2436 * 1125 || pt: 812 * 375
iPhoneXs Max 的分辨率：2688 * 1242 || pt: 896 * 414
 */
#define isPadDevice ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//iphonex
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPadDevice : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPadDevice : NO)
//判断iPHoneXr 模拟器
#define IS_IPHONE_Xr_MN ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) && !isPadDevice : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPadDevice : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPadDevice : NO)


#define  kStatusBarHeight      ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES || IS_IPHONE_Xr_MN == YES) ? 44.0 : 20.0)
#define  kTabbarHeight        ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES || IS_IPHONE_Xr_MN == YES) ? 83.0 : 49.0)
#define  kStatusBarAndNavigationBarHeight  ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES || IS_IPHONE_Xr_MN == YES) ? 88.0 : 64.0)
#define  kTabbarSafeBottomMargin        ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES || IS_IPHONE_Xr_MN == YES) ? 34.f : 0.f)
#define  kSlideSwitchHeight 40*kWidthRatio
#define  kHomePageNavHeight 40

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

#define HEXCOLORAlPA(hex,apla) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:apla]

#define GM_Clear_Color [UIColor clearColor]

#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"
#define PFHK [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangHK-Medium" : @"PingFang SC"
#define PFM [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Medium" : @"PingFang SC"

//平方中等字体 PingFangSC-Medium
#define GMFontMediumSize(fontsize) [UIFont fontWithName:PFM size:fontsize]
//平方中等字体 PingFangHK-Medium
#define GMFontMediumHKSize(fontsize) [UIFont fontWithName:PFHK size:fontsize]

#define PFRFont(fontSize) [UIFont fontWithName:PFR size:fontSize*kWidthRatio]//可适配
#define BoldFont(fontSize) [UIFont boldSystemFontOfSize:fontSize*kWidthRatio]  //系统加粗字体

#define PFR24Font [UIFont fontWithName:PFR size:24]
#define PFR22Font [UIFont fontWithName:PFR size:22]
#define PFR23Font [UIFont fontWithName:PFR size:23]
#define PFR20Font [UIFont fontWithName:PFR size:20]
#define PFR18Font [UIFont fontWithName:PFR size:18]
#define PFR16Font [UIFont fontWithName:PFR size:16]
#define PFR15Font [UIFont fontWithName:PFR size:15]
#define PFR14Font [UIFont fontWithName:PFR size:14]
#define PFR13Font [UIFont fontWithName:PFR size:13]
#define PFR12Font [UIFont fontWithName:PFR size:12]
#define PFR11Font [UIFont fontWithName:PFR size:11]
#define PFR10Font [UIFont fontWithName:PFR size:10]
#define PFR9Font [UIFont fontWithName:PFR size:9]
#define PFR8Font [UIFont fontWithName:PFR size:8]

#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define KEYWINDOW  [UIApplication sharedApplication].keyWindow


//获取当前版本号
#define BUNDLE_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
//获取当前版本的biuld
#define BIULD_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
//获取当前设备的UDID
#define DIV_UUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]
//获取当前设备的版本号
#define DIV_VERSION [[UIDevice currentDevice] systemVersion]
//获取当前设备类型 iOS
#define DIV_SYSNAME [[UIDevice currentDevice] systemName]

//图片链接出路
#define Url(urlStr)  [NSURL URLWithString:urlStr]



//*****************************************************************
// MARK: - Getter
//*****************************************************************

//baseif
#define ws_if_(name, ...) \
if (name) { \
__VA_ARGS__\
}
//baseLazy
#define ws_lazy_(name, ...)\
if (!_##name) { \
_##name = ({ \
__VA_ARGS__\
}); \
} \
return _##name; \

#define getter_view(name, ...) \
- (UIView *)name { \
ws_lazy_(name, \
UIView *obj = [UIView new]; \
__VA_ARGS__ \
obj; \
) \
}

#define getter_button(name, ...) \
- (UIButton *)name { \
ws_lazy_(name, \
UIButton *obj = [UIButton new]; \
__VA_ARGS__ \
obj; \
) \
}

#define getter_imageview(name, ...) \
- (UIImageView *)name { \
ws_lazy_(name, \
UIImageView *obj = [UIImageView new]; \
obj.contentMode = UIViewContentModeScaleAspectFit; \
obj.layer.masksToBounds = YES; \
__VA_ARGS__ \
obj; \
) \
}

#define getter_label(name, ...) \
- (UILabel *)name { \
ws_lazy_(name, \
UILabel *obj = [UILabel new]; \
__VA_ARGS__ \
obj; \
) \
}

#define getter_textfield(name, ...) \
- (UITextField *)name { \
ws_lazy_(name, \
UITextField *obj = [UITextField new]; \
__VA_ARGS__ \
obj; \
) \
}

#define getter_coll_hor_layout(name, _height, _padding, _inset, _line, _ratio) \
- (UICollectionViewFlowLayout *)name { \
CGFloat itemHeight = (_height - _padding * (_line - 1) - (_inset.top + _inset.bottom)) / _line;\
\
UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new]; \
flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal; \
flowLayout.minimumInteritemSpacing = _padding; \
flowLayout.minimumLineSpacing = _padding; \
flowLayout.sectionInset = _inset; \
flowLayout.itemSize = CGSizeMake((itemHeight / (_ratio)), itemHeight); \
\
return flowLayout; \
}

#define getter_collection(name, layout, ...) \
- (UICollectionView *)name { \
ws_lazy_(name, \
UICollectionView *obj = [[UICollectionView alloc] initWithFrame:(CGRect){CGPointZero,CGSizeZero} collectionViewLayout:layout? : [UICollectionViewLayout new]]; \
__VA_ARGS__ \
obj; \
) \
}


#define getter_textview(name, ...) \
- (UITextView *)name { \
ws_lazy_(name, \
UITextView *obj = [UITextView new]; \
__VA_ARGS__ \
obj; \
) \
}

#define getter_table(name, ...) \
- (UITableView *)name \
{ \
ws_lazy_(name, \
UITableView *obj = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain]; \
__VA_ARGS__ \
obj; \
) \
}

#define getter_group_table(name, ...) \
- (UITableView *)name { \
ws_lazy_(name, \
UITableView *obj = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped]; \
__VA_ARGS__ \
obj; \
) \
}

#define getter_custom(class, name, ...) \
- (class *)name \
{ \
ws_lazy_(name, \
class *obj = [[class alloc] init]; \
__VA_ARGS__ \
obj ; \
)\
}

#define getter_layer(name, ... ) \
- (CAShapeLayer *)name { \
ws_lazy_(name, \
CAShapeLayer *obj = [CAShapeLayer layer]; \
__VA_ARGS__ \
obj ; \
)\
}



#endif /* macros_h */

//
//  GMEnvirSwitch.m
//  FBSnapshotTestCase
//
//  Created by 小飞鸟 on 2019/09/26.
//

#import "GMEnvirSwitch.h"
#import "GMEnvirPopView.h"
#import "GMURLProtocol.h"


#define KWindow     [UIApplication sharedApplication].delegate.window

@interface  GMEnvirSwitch()
/*配置 URL路径的代理*/
@property(nonatomic,weak)id<GMURLConfigProtocol>delegate;
@end

@implementation GMEnvirSwitch{
    
    UIButton * _switchBtn;
    CGFloat maxBottomHight;
    CGFloat minTopHight;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setUpView];
        [self setupBianliang];
    }
    return self;
}

/*初始化环境切换*/
+(void)setUpEnvirSwitchDelegate:(id)delegate;{
    [GMEnvirSwitch envirSwitch];
    [GMEnvirSwitch envirSwitch].delegate =delegate;
}
/*初始化View*/
-(void)setUpView{
    _switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_switchBtn setImage:[UIImage imageNamed:@"Artboard Copy"] forState:UIControlStateNormal];
    [_switchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _switchBtn.layer.cornerRadius = 8;
    _switchBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _switchBtn.clipsToBounds = YES;
    UIView * superView = [self getSuperView].view;
    [superView addSubview:_switchBtn];
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panSwitchBtn:)];
    [_switchBtn addGestureRecognizer:pan];
        
    [_switchBtn addTarget:self action:@selector(clickSwitch) forControlEvents:UIControlEventTouchUpInside];
    
    [_switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superView).offset(-40);
        make.right.equalTo(superView).offset(-15);
        make.width.mas_equalTo(95);
        make.height.mas_equalTo(95);
    }];
}

/*获取当前的环境类型*/
+(NSString*)currentEnvirType{
    
   __block NSString * envirType = nil;
    NSArray * localList = [GMKeyedArchiverTool getKeyedArchiverValueForFilePath:[self filePath]];
    [localList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[obj  objectForKey:@"select"] integerValue]) {
            envirType = [obj objectForKey:@"envirType"];
        }
    }];
    return  envirType;
}

/*获取当前的URL 环境配置*/
+(NSArray*)currentEnvirConfig{
    return [GMKeyedArchiverTool getKeyedArchiverValueForFilePath:[self filePath]];
}

//URL 路径归档的文件位置
+(NSString*)filePath{
    
    return [[GMFileUtil getSandboxDocutment]stringByAppendingPathComponent:@"URL.achive"];
}

/*获取当前某一个模块的 dormain域名*/
+(NSString*)getURLForModule:(NSString*)module{
    //当前的环境类型
    NSString * envirType = [self currentEnvirType];
    if (!envirType||!module) {
        NSLog(@"当前 没有设置环境类型");
        return  nil;
    }
   __block NSArray * currentEnvirList = @[];
    __block NSString * dormain = nil;
    NSArray * localList = [GMKeyedArchiverTool getKeyedArchiverValueForFilePath:[self filePath]];
    [localList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[obj  objectForKey:@"envirType"] isEqualToString:envirType]) {
            currentEnvirList = [obj objectForKey:@"list"];
        }
    }];
    
    [currentEnvirList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[obj objectForKey:@"funcName"] isEqualToString:module]) {
            dormain = [obj objectForKey:@"dormain"];
        }
    }];
    return dormain;
}

#pragma mark 点击切换弹窗视图
-(void)clickSwitch{
    
    GMEnvirPopView * popView = [[GMEnvirPopView alloc]initWithFrame:CGRectZero];
    //缓存的本地 保存数据
    NSArray * localList = [GMKeyedArchiverTool getKeyedArchiverValueForFilePath:[[self class] filePath]];
    if (!localList||!localList.count) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(configEnvirURL)]) {
            popView.URLList = [[self.delegate configEnvirURL] mutableCopy];
        }
    }else{
        //使用本地已经缓存的数据
        popView.URLList= [localList mutableCopy];
    }
    [KWindow addSubview:popView];
}

#pragma mark 初始化变量问题
-(void)setupBianliang{
    
    UIViewController * root =[self getSuperView];
    if ([root isKindOfClass:[UITabBarController class]]){
        maxBottomHight =  kTabbarHeight;
        minTopHight = kStatusBarHeight+44;
    }else if ([root isKindOfClass:[UINavigationController class]]){
        minTopHight = kStatusBarHeight+44;
        maxBottomHight =0;
        
    }else if ([root isKindOfClass:[UIViewController class]]) {
        maxBottomHight =0;
        minTopHight =0;
    }
}

#pragma mark 拖动手势
-(void)panSwitchBtn:(UIPanGestureRecognizer*)pan{
    
    CGPoint point = [pan locationInView:self];
    CGFloat bottomVlaue = maxBottomHight+47;
    CGFloat topValue = minTopHight+47;
    if (point.x-50<0||point.x+50>ScreenW||point.y-topValue<0||point.y+bottomVlaue>ScreenH) {
        return;
    }
    _switchBtn.center = point;
    NSLog(@"point***%@",NSStringFromCGPoint(point));
}

-(UIViewController*)getSuperView{
    
    UIWindow * window = KWindow;
    UIViewController * root =window.rootViewController;
    return  root;
}

+ (GMEnvirSwitch *)envirSwitch{
    
    static dispatch_once_t onceToken;
    static GMEnvirSwitch * envirSwitch = nil;
    dispatch_once(&onceToken, ^{
        envirSwitch = [[GMEnvirSwitch alloc]init];
    });
    return  envirSwitch;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];

    //1.获取手指对象
    UITouch *touch = [touches anyObject];
    //2.获取手指当前位置
    CGPoint currentPoint = [touch locationInView:self];
    //3.获取手指之前的位置
    CGPoint previousPoint = [touch previousLocationInView:self];
    
    //4.计算移动的增量
    CGFloat dx = currentPoint.x - previousPoint.x;
    CGFloat dy = currentPoint.y - previousPoint.y;
    //修改视图位置
    self.center = CGPointMake(self.center.x + dx, self.center.y + dy);
    
}

@end

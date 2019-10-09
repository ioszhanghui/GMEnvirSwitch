//
//  GMEnvirPopView.m
//  FBSnapshotTestCase
//
//  Created by 小飞鸟 on 2019/09/26.
//

#import "GMEnvirPopView.h"

@interface GMEnvirModel : NSObject
/*环境类型*/
@property(nonatomic,copy)NSString * envirType;
@property(nonatomic,strong)NSArray * list;
/*是否是选中*/
@property(nonatomic,copy)NSString * select;

@end

@interface GMURLInterface : NSObject
/*功能模块*/
@property(nonatomic,copy)NSString * funcName;
/*所用的域名*/
@property(nonatomic,copy)NSString * dormain;

@end

@implementation GMURLInterface

@end

@implementation GMEnvirModel

/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"list":@"GMURLInterface"};
}
@end

@interface GMEnvirCell : UITableViewCell
/*环境类型*/
@property(nonatomic,strong)UILabel * envirLabel;
/*环境地址*/
@property(nonatomic,strong)UILabel * URLLabel;
/*切换按钮*/
@property(nonatomic,strong)UIButton * checkBtn;
/*环境模型*/
@property(nonatomic,strong)GMEnvirModel * envirModel;

@end

@interface GMEnvirPopView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
/*背景视图*/
@property(nonatomic,strong)UIView * bgView;
/*tableView视图*/
@property(nonatomic,strong)UITableView * tableView;

@end

@implementation GMEnvirCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

#pragma mark 初始化View
-(void)setupSubViews{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //环境类型
    self.envirLabel = [[UILabel alloc]init];
    self.envirLabel.textColor = HEXCOLOR(0x333333);
    self.envirLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.envirLabel];
    //URL
    self.URLLabel = [[UILabel alloc]init];
    self.URLLabel.textColor = HEXCOLOR(0x333333);
    self.URLLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.URLLabel];
    
    //选择按钮
    self.checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkBtn setImage:[UIImage imageNamed:@"icon_duigou0101"] forState:UIControlStateNormal];
    [self.checkBtn setImage:[UIImage imageNamed:@"icon_duigou0102"] forState:UIControlStateSelected];
    [self.contentView addSubview:self.checkBtn];
}


-(void)setEnvirModel:(GMEnvirModel *)envirModel{
    _envirModel = envirModel;
    
    self.envirLabel.text = envirModel.envirType;
    if (envirModel.list.count) {
        GMURLInterface * urlInterface = [envirModel.list firstObject];
        self.URLLabel.text = urlInterface.dormain;
    }
    BOOL select = [_envirModel.select integerValue];
    self.checkBtn.selected = select;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    
    [self.envirLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkBtn.mas_right).offset(5);
        make.top.offset(15);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];
    
    [self.URLLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkBtn.mas_right).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];
}

@end

#define CellHight 75
static NSString * cellID = @"EnvieCellID";

@implementation GMEnvirPopView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0,  ScreenW, ScreenH);
        [self setupSubViews];
        _URLList = [NSMutableArray array];
    }
    return self;
}

-(void)setURLList:(NSMutableArray *)URLList{
    if (URLList) {
        _URLList = [GMEnvirModel mj_objectArrayWithKeyValuesArray:URLList];
    }
}

#pragma mark 初始化 子视图
-(void)setupSubViews{
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius =8;
    self.bgView.clipsToBounds = YES;
    [self addSubview:self.bgView];
    
    UILabel * label = [[UILabel alloc]init];
    label.text =@"环境切换";
    label.textColor = HEXCOLOR(0x333333);
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment= NSTextAlignmentCenter;
    [self.bgView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.top.equalTo(self.bgView).offset(10);
        make.height.mas_equalTo(15);
        make.right.equalTo(self.bgView);
    }];
    
    CGFloat offsetX =30;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(ScreenW-2*offsetX);
        make.height.mas_equalTo(350);
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = nil;
    //去掉头部留白
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 0.001)];
    self.tableView.tableHeaderView = view;
    
    [self.tableView registerClass:[GMEnvirCell class] forCellReuseIdentifier:cellID];
    
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:sureBtn];
    sureBtn.layer.cornerRadius = 20;
    sureBtn.clipsToBounds = YES;
    sureBtn.backgroundColor = HEXCOLOR(0xF6004F);
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchDown];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(180);
        make.centerX.equalTo(self.bgView);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-10);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(sureBtn.mas_top).offset(-10);
        make.left.equalTo(self.bgView);
        make.right.equalTo(self.bgView);
        make.height.mas_equalTo(250);
    }];
    
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundClickAction)];
    [self addGestureRecognizer:tap];
    tap.delegate = self;
}

#pragma mark 移除
- (void)backgroundClickAction {
    [self removeFromSuperview];
}

#pragma mark 点击范围的代理方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
    if (CGRectContainsPoint(self.bgView.frame, point)){
        return NO;
    }
    return YES;
}


#pragma mark 点击确定
-(void)sureAction{
    
    NSArray * jsonList = [GMEnvirModel mj_keyValuesArrayWithObjectArray:self.URLList];
    NSString * filePath = [[GMFileUtil getSandboxDocutment]stringByAppendingPathComponent:@"URL.achive"];
    [GMKeyedArchiverTool setKeyedArchiverValue:jsonList FilePath:filePath];
    exit(0);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.URLList.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GMEnvirCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.envirModel = [self.URLList objectAtIndex:indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CellHight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GMEnvirModel * model = [self.URLList objectAtIndex:indexPath.row];
    [self resetSlect];
    model.select = @"1";
    [self.tableView reloadData];
}

/*重置选择*/
-(void)resetSlect{
    [self.URLList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GMEnvirModel * model = obj;
        model.select = @"0";
    }];
}
@end

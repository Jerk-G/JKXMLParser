//
//  JKAddressPickerView.m
//  JKXml
//
//  Created by apple on 16/11/24.
//  Copyright © 2016年 faNaiSheng. All rights reserved.
//

#import "JKAddressPickerView.h"
#import "JKAnalyzingXml.h"
#import "MJExtension.h"
#import "JKAddressList.h"


@interface JKAddressPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString *provinceName, *cityName, *areaName;
}

@property (nonatomic ,strong) NSMutableArray * provincesArr;/**< 省份名称数组*/
@property (nonatomic ,strong) NSMutableArray   * citysArr;/**< 所有城市的数组*/
@property (nonatomic ,strong) NSMutableArray   * areasArr;/**< 所有地区的数组*/
@property (nonatomic ,strong) NSMutableArray   * finalCitysArr;/**< 所在城市的数组*/
@property (nonatomic ,strong) NSMutableArray   * finalAreasArr;/**< 所在地区的数组*/

@property (nonatomic ,strong) UIView   * titleBackgroundView;/**< 标题栏背景*/
@property (nonatomic ,strong) UIButton * cancelBtn;/**< 取消按钮*/
@property (nonatomic, strong) UIButton * sureBtn;/**< 完成按钮*/
@property (nonatomic ,strong) UIPickerView   * addressPickerView;/**< 选择器*/

@end

@implementation JKAddressPickerView

- (NSMutableArray *)provincesArr {
    if (!_provincesArr) {
        _provincesArr = [NSMutableArray array];
    }
    return _provincesArr;
}
- (NSMutableArray *)citysArr {
    if (!_citysArr) {
        _citysArr = [NSMutableArray array];
    }
    return _citysArr;
}
- (NSMutableArray *)areasArr {
    if (!_areasArr) {
        _areasArr = [NSMutableArray array];
    }
    return _areasArr;
}
- (NSMutableArray *)finalCitysArr {
    if (!_finalCitysArr) {
        _finalCitysArr = [NSMutableArray array];
    }
    return _finalCitysArr;
}
- (NSMutableArray *)finalAreasArr {
    if (!_finalAreasArr) {
        _finalAreasArr = [NSMutableArray array];
    }
    return _finalAreasArr;
}

#define SELFSIZE self.bounds.size
static CGFloat const TITLEHEIGHT = 50.0;
static CGFloat const TITLEBUTTONWIDTH = 75.0;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //加载地址数据源
        [self loadAddressData];
        //加载标题栏
        [self loadTitle];
        //加载选择器
        [self loadPickerView];
    }
    return self;
}

- (NSArray *)listDataArr {
    if (!_listDataArr) {
        _listDataArr = [NSArray array];
    }
    return _listDataArr;
}

- (UIView *)titleBackgroundView{
    if (!_titleBackgroundView) {
        _titleBackgroundView = [[UIView alloc]initWithFrame:
                                CGRectMake(0, 0, SELFSIZE.width, TITLEHEIGHT)];
        _titleBackgroundView.backgroundColor = [UIColor grayColor];
    }
    return _titleBackgroundView;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:
                      CGRectMake(0, 0, TITLEBUTTONWIDTH, TITLEHEIGHT)];
        [_cancelBtn setTitle:@"清除"
                    forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor]
                         forState:UIControlStateNormal];
        [_cancelBtn addTarget:self
                       action:@selector(cancelBtnClicked)
             forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc]initWithFrame:
                    CGRectMake(SELFSIZE.width - TITLEBUTTONWIDTH, 0, TITLEBUTTONWIDTH, TITLEHEIGHT)];
        [_sureBtn setTitle:@"完成"
                  forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor blackColor]
                       forState:UIControlStateNormal];
        [_sureBtn addTarget:self
                     action:@selector(sureBtnClicked)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIPickerView *)addressPickerView{
    if (!_addressPickerView) {
        _addressPickerView = [[UIPickerView alloc]initWithFrame:
                              CGRectMake(0, TITLEHEIGHT, SELFSIZE.width, 165)];
        _addressPickerView.backgroundColor = [UIColor colorWithRed:239/255.f
                                                             green:239/255.f
                                                              blue:244.0/255.f
                                                             alpha:1.0];
        _addressPickerView.delegate = self;
        _addressPickerView.dataSource = self;
    }
    return _addressPickerView;
}

#pragma mark - 加载标题栏
- (void)loadTitle{
    [self addSubview:self.titleBackgroundView];
    [self.titleBackgroundView addSubview:self.cancelBtn];
    [self.titleBackgroundView addSubview:self.sureBtn];
}

#pragma mark  加载PickerView
- (void)loadPickerView{
    [self addSubview:self.addressPickerView];
}

#pragma mark - 加载地址数据
- (void)loadAddressData{
    
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(reloadView:) name:@"reloadViewNotification" object:nil];
    
    NSLog(@"viewDidLoad");
    
    // 苹果自带解析
    JKAnalyzingXml * parser = [JKAnalyzingXml new];
    //开始解析
    [parser start];
    
}

#pragma mark - 处理通知
-(void)reloadView:(NSNotification*)notification {
    
    NSMutableArray *resList = [notification object];
    self.listdata  = resList;
    
    self.listDataArr = [JKAddressList mj_objectArrayWithKeyValuesArray:self.listdata];
    
    
    NSLog(@"开始");
    
    for (JKAddressList *areaList in self.listDataArr) {
        
        if ([areaList.level isEqualToString:@"1"]) {// 所有省
            [self.provincesArr addObject:areaList];
        }
        if ([areaList.level isEqualToString:@"2"]) {// 所有城市
            
            [self.citysArr addObject:areaList];
        }
        if ([areaList.level isEqualToString:@"3"]) {// 所有地区
            [self.areasArr addObject:areaList];
        }
    }
    NSLog(@"完成");
    
    
    [self.finalCitysArr removeAllObjects];
    [self.finalAreasArr removeAllObjects];
    
    // 初始化省市区
    [self getAddressWithProvinceIndex:0 cityIndex:0];
    
    JKAddressList *cList = self.finalCitysArr[0];
    JKAddressList *pList = self.provincesArr[0];
    
    provinceName = pList.name;
    cityName = cList.name;
    areaName = @"";
    if (self.finalAreasArr.count != 0) { // 处理没有区的时候报错数组越界
        JKAddressList *aList = self.finalAreasArr[0];
        areaName = aList.name;
    }
    
    NSLog(@"pro--%@  cit--%@  are--%@", provinceName, cityName, areaName);
}


#pragma mark - UIPickerDatasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        
        return self.provincesArr.count;
        
    } else if (component == 1){
        
        return self.finalCitysArr.count;
        
    } else if (component == 2){
        
        return self.finalAreasArr.count;
    }
    
    return 0;
}

#pragma mark - UIPickerViewDelegate
#pragma mark 填充文字
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        
        JKAddressList *pList = self.provincesArr[row];
        return pList.name;
    } else if (component == 1) {
        
        JKAddressList *cList = self.finalCitysArr[row];
        return cList.name;
    
    } else if (component == 2) {
        
        JKAddressList *aList = self.finalAreasArr[row];
        return aList.name;
    }
    return nil;
}

#pragma mark pickerView被选中
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {// 选择省份
        
        [self getAddressWithProvinceIndex:row cityIndex:0];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    } else if (component == 1){ // 选择城市
        
        NSInteger selectProvince = [pickerView selectedRowInComponent:0];
        
        [self getAddressWithProvinceIndex:selectProvince cityIndex:row];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    
    // 获取选中后的省市区
    provinceName =[self pickerView:pickerView titleForRow:[pickerView selectedRowInComponent:0] forComponent:0];
    cityName =[self pickerView:pickerView titleForRow:[pickerView selectedRowInComponent:1] forComponent:1];
    areaName = @"";
    if (self.finalAreasArr.count != 0) { // 处理没有区的时候报错数组越界
        areaName = [self pickerView:pickerView titleForRow:[pickerView selectedRowInComponent:2] forComponent:2];
    }
    
    NSLog(@"pro--%@  cit--%@  are--%@", provinceName, cityName, areaName);
}

- (void)getAddressWithProvinceIndex:(NSInteger)pIndex cityIndex:(NSInteger)cIndex {
    
    JKAddressList *pList = self.provincesArr[pIndex];
    [self.finalCitysArr removeAllObjects];
    for (JKAddressList *cList in self.citysArr) {
        if ([cList.supper_id isEqualToString:pList.id]) {
            [self.finalCitysArr addObject:cList];
        }
    }
    
    [self.finalAreasArr removeAllObjects];
    
    if ([self.finalCitysArr count]!=0) {
        
        JKAddressList *cList = self.finalCitysArr[cIndex];
        for (JKAddressList *aList in self.areasArr) {
            if ([aList.supper_id isEqualToString:cList.id]) {
                [self.finalAreasArr addObject:aList];
            }
        }
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor = [UIColor colorWithRed:51.0/255
                                                green:51.0/255
                                                 blue:51.0/255
                                                alpha:1.0];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    
    pickerLabel.text = [self pickerView:pickerView
                            titleForRow:row
                           forComponent:component];
    return pickerLabel;
}


#pragma mark - AddressPickerViewDelegate
- (void)cancelBtnClicked{
    if ([_delegate respondsToSelector:@selector(cancelBtnClick)]) {
        [_delegate cancelBtnClick];
    }
}

- (void)sureBtnClicked{
    if ([_delegate respondsToSelector:@selector(sureBtnClickReturnProvince:City:Area:)]) {
        
        [_delegate sureBtnClickReturnProvince:provinceName
                                         City:cityName
                                         Area:areaName];
    }
}

@end

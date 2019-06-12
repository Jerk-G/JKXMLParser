//
//  ViewController.m
//  JKXMLParser
//
//  Created by apple on 2017/1/20.
//  Copyright © 2017年 jerky. All rights reserved.
//

#import "ViewController.h"
#import "JKAnalyzingXml.h"
#import "JKAddressList.h"
#import "MJExtension.h"
#import "JKAddressPickerView.h"

@interface ViewController ()<JKAddressPickerViewDelegate>


//@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) JKAddressPickerView *areaView;

@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (JKAddressPickerView *)areaView{
    if (!_areaView) {
        _areaView = [[JKAddressPickerView alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 215)];
        _areaView.delegate = self;
        [self.view addSubview:_areaView];
    }
    return _areaView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"哈哈哈哈哈哈");
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 加载地区选择器
    JKAddressPickerView *areaView = [[JKAddressPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 215, self.view.frame.size.width, 215)];
    areaView.delegate = self;
    [self.view addSubview:areaView];
    
    // 显示地区的窗口
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor lightGrayColor];
    label.text = @"请选择城市";
    label.frame = CGRectMake(0, areaView.frame.origin.y - 80, self.view.frame.size.width, 30);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blueColor];
    [self.view addSubview:label];
    self.label = label;
}

#pragma mark -- JKAddressPickerViewDelegate (解析XML的代理)
// 点击确定按钮，获取选择的地区
- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area {
    
    NSLog(@"%@%@%@" ,province, city, area);
    
    // 显示选择的地区
    self.label.text = [NSString stringWithFormat:@"%@-%@-%@" ,province, city, area];
}

// 点击清除按钮，清除地区
- (void)cancelBtnClick {
    
    NSLog(@"cancelBtnClick--");
    
    self.label.text = @"请选择城市";
}


@end

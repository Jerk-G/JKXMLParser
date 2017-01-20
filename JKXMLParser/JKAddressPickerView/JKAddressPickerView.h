//
//  JKAddressPickerView.h
//  JKXml
//
//  Created by apple on 16/11/24.
//  Copyright © 2016年 faNaiSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JKAddressPickerViewDelegate <NSObject>

/** 取消按钮点击事件*/
- (void)cancelBtnClick;

/**
 *  完成按钮点击事件
 *
 *  @param province 当前选中的省份
 *  @param city     当前选中的市
 *  @param area     当前选中的区
 */
- (void)sureBtnClickReturnProvince:(NSString *)province
City:(NSString *)city
Area:(NSString *)area;

@end

@interface JKAddressPickerView : UIView

/** 实现点击按钮代理*/
@property (nonatomic ,weak) id<JKAddressPickerViewDelegate> delegate;
// 保存数据列表
@property (nonatomic,strong) NSMutableArray *listdata ;

@property (nonatomic, strong) NSArray *listDataArr;

@end

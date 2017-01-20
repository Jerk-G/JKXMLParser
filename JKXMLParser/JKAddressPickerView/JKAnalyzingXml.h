//
//  JKAnalyzingXml.h
//  JKXml
//
//  Created by apple on 16/11/24.
//  Copyright © 2016年 faNaiSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKAnalyzingXml : NSObject<NSXMLParserDelegate>
//解析出得数据，内部是字典类型
@property (strong,nonatomic) NSMutableArray * notes ;

// 当前标签的名字 ,currentTagName 用于存储正在解析的元素名
@property (strong ,nonatomic) NSString * currentTagName ;

//开始解析
- (void) start ;
@end

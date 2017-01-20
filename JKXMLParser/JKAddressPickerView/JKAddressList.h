//
//  JKAreaList.h
//  JKXml
//
//  Created by apple on 16/11/24.
//  Copyright © 2016年 faNaiSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKAddressList : NSObject

@property (nonatomic, copy) NSString       * name;/**< 省名字*/
@property (nonatomic, copy) NSString       * id;/**< 省id*/
@property (nonatomic, copy) NSString       * supper_id;/**< 省上级id*/
@property (nonatomic, copy) NSString       * level;/**< 省优先级*/

@end

# JKXMLParser
## 基于Apple自带的XML解析器NSXMLParser封装的解析器
#### 此解析器是解析一个地址选择器的xml，然后经过封装，封装成一个地址选择器的pickerView
## 效果预览：
![预览图](https://github.com/Jerk-G/JKXMLParser/blob/master/previewImage.gif) 
## 用法

在需要用到控制器里导入主头文件：`#import "JKAddressPickerView.h"`
由于这里用到模型，需要解析，所以用了`MJExtension`到时候直接把`MJExtension、JKAddressPickerView`这两个文件导入项目中即可
####代码如下：

```Objective-C
>>// 加载地区选择器

>>JKAddressPickerView *areaView = [[JKAddressPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 215, self.view.frame.size.width, 215)];
    
>>areaView.delegate = self;
    
>>[self.view addSubview:areaView];
```
####实现代理方式
```Objective-C

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
```

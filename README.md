# JKXMLParser
## 基于Apple自带的XML解析器NSXMLParser封装的解析器
#### 此解析器是解析一个地址选择器的xml，然后经过封装，封装成一个地址选择器的pickerView
## 效果预览：
![预览图](https://github.com/Jerk-G/JKXMLParser/blob/master/previewImage.gif) 
## 用法

在需要用到控制器里导入主头文件：`#import "JKAddressPickerView.h"`
由于这里用到模型，需要解析，所以用了`MJExtension`到时候直接把`MJExtension、JKAddressPickerView`这两个问价导入项目中即可
代码如下：

```// 加载地区选择器
    JKAddressPickerView *areaView = [[JKAddressPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 215, self.view.frame.size.width, 215)];
    areaView.delegate = self;
    [self.view addSubview:areaView];```

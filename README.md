# Password-keyboard
随机变换数字位置的密码键盘。
模仿银行类应用在付款时输入的随机密码键盘。

## 使用步骤
1.将UIViewExtension与CustomKeyboard文件导入项目。<br>
2.导入自定义键盘头文件
```objc
#import "LVKeyboardView.h"
```
3.需要两个属性
```objc
@property (nonatomic, strong) LVKeyboardView *keyboard;

@property (nonatomic, strong) NSMutableString *passWord;
```
4.设置需要输入密码的textField
```objc
self.textField.inputAccessoryView = [[LVKeyboardAccessoryBtn alloc] init];
self.textField.inputView = self.keyboard;
self.textField.delegate = self;
```
5.添加以下代码实现输入功能
```objc
/***************需要*************/
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.textField.text = nil;
    self.passWord = nil;
    
    CGFloat x = 0;
    CGFloat y = self.view.height - 216;
    CGFloat w = self.view.width;
    CGFloat h = 216;
    self.keyboard = [[LVKeyboardView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.keyboard.delegate = self;
    
    self.textField.inputView = _keyboard;
    
    return YES;
}

#pragma mark - LVKeyboardDelegate
- (void)keyboard:(LVKeyboardView *)keyboard didClickButton:(UIButton *)button {
    if (self.passWord.length > 5) return;
    [self.passWord appendString:button.currentTitle];
    
    self.textField.text = self.passWord;
}

- (void)keyboard:(LVKeyboardView *)keyboard didClickDeleteBtn:(UIButton *)deleteBtn {

    NSUInteger loc = self.passWord.length;
    if (loc == 0)   return;
    NSRange range = NSMakeRange(loc - 1, 1);
    [self.passWord deleteCharactersInRange:range];
    self.textField.text = self.passWord;
}

#pragma mark - 需要
- (NSMutableString *)passWord {
    if (!_passWord) {
        _passWord = [NSMutableString stringWithCapacity:6];
    }
    return _passWord;
}

#pragma mark - 如果不需要随机变换数字需要
//- (LVKeyboardView *)keyboard {
//    if (!_keyboard) {
//        CGFloat x = 0;
//        CGFloat y = self.view.height - 216;
//        CGFloat w = self.view.width;
//        CGFloat h = 216;
//        _keyboard = [[LVKeyboardView alloc] initWithFrame:CGRectMake(x, y, w, h)];
//        _keyboard.delegate = self;
//    }
//    return _keyboard;
//}
/***************结束*************/
```
## 密码键盘效果图
![](https://github.com/liuchunlao/ImageCache/raw/master/gifResource/passwordKeyboard.gif)

## 期待
* 如果在使用过程中遇到BUG，希望你能Issues我，谢谢！
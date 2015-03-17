//
//  LVViewController.m
//  customKeyboard
//
//  Created by PBOC CS on 15/2/26.
//  Copyright (c) 2015年 liuchunlao. All rights reserved.
//

#import "LVViewController.h"
#import "LVKeyboardView.h"
#import "LVKeyboardAccessoryBtn.h"
#import "UIView+Extension.h"

@interface LVViewController () <UITextFieldDelegate, LVKeyboardDelegate>


@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, strong) LVKeyboardView *keyboard;

@property (nonatomic, strong) NSMutableString *passWord;

@end

@implementation LVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField.inputAccessoryView = [[LVKeyboardAccessoryBtn alloc] init];
    self.textField.inputView = self.keyboard;
    self.textField.delegate = self;
}

- (IBAction)click:(UIButton *)sender {
    
    [self.textField resignFirstResponder];
}

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
    NSLog(@"%@", self.textField.text);
}

- (void)keyboard:(LVKeyboardView *)keyboard didClickDeleteBtn:(UIButton *)deleteBtn {
    NSLog(@"删除");
    NSUInteger loc = self.passWord.length;
    if (loc == 0)   return;
    NSRange range = NSMakeRange(loc - 1, 1);
    [self.passWord deleteCharactersInRange:range];
    self.textField.text = self.passWord;
    NSLog(@"%@", self.textField.text);
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



@end

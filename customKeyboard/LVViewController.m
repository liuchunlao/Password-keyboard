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
    self.textField.delegate = self;
}

- (IBAction)click:(UIButton *)sender {
    
    [self.textField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.textField.inputView = self.keyboard;
    return YES;
}


- (void)keyboard:(LVKeyboardView *)keyboard didClickButton:(UIButton *)button {
    
//    NSLog(@"%@", button.currentTitle);
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

- (LVKeyboardView *)keyboard {
    if (!_keyboard) {
        CGFloat x = 0;
        CGFloat y = self.view.height - 216;
        CGFloat w = self.view.width;
        CGFloat h = 216;
        _keyboard = [[LVKeyboardView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _keyboard.delegate = self;
    }
    return _keyboard;
}


- (NSMutableString *)passWord {
    if (!_passWord) {
        _passWord = [NSMutableString stringWithCapacity:6];
    }
    return _passWord;
}



@end

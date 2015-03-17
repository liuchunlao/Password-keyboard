//
//  LVKeyboardView.h
//  customKeyboard
//
//  Created by PBOC CS on 15/2/26.
//  Copyright (c) 2015年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
#import "LVKeyboardAccessoryBtn.h"

@class LVKeyboardView;
@protocol LVKeyboardDelegate <NSObject>

@optional
/** 点击了数字按钮 */
- (void)keyboard:(LVKeyboardView *)keyboard didClickButton:(UIButton *)button;
/** 点击删除按钮 */
- (void)keyboard:(LVKeyboardView *)keyboard didClickDeleteBtn:(UIButton *)deleteBtn;

@end

@interface LVKeyboardView : UIView

@property (nonatomic, assign) id<LVKeyboardDelegate> delegate;

@end

//
//  LVKeyboardView.m
//  customKeyboard
//
//  Created by PBOC CS on 15/2/26.
//  Copyright (c) 2015年 liuchunlao. All rights reserved.
//

#import "LVKeyboardView.h"

#define LVKeyboardCols 3
#define LVKeyboardTextFont 20

@interface LVKeyboardView ()

/** 删除按钮 */
@property (nonatomic, weak) UIButton *deleteBtn;

/** 符号按钮 */
@property (nonatomic, weak) UIButton *symbolBtn;

/** ABC 文字按钮 */
@property (nonatomic, weak) UIButton *textBtn;

@end


@implementation LVKeyboardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 普通图片
        UIImage *image = [UIImage imageNamed:@"c_chaKeyboardButton"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        // 高亮图片
        UIImage *highImage = [UIImage imageNamed:@"c_chaKeyboardButtonSel"];
        highImage = [highImage stretchableImageWithLeftCapWidth:highImage.size.width * 0.5 topCapHeight:highImage.size.height * 0.5];
        
        [self setupTopButtonsWithImage:image highImage:highImage];
        [self setupBottomButtonsWithImage:highImage highImage:image];
    }
    return self;
}

#pragma mark - 数字按钮
- (void)setupTopButtonsWithImage:(UIImage *)image highImage:(UIImage *)highImage {
    
    NSMutableArray *arrM = [NSMutableArray array];
    [arrM removeAllObjects];
    for (int i = 0 ; i < 10; i++) {
        int j = arc4random_uniform(10);
        
        NSNumber *number = [[NSNumber alloc] initWithInt:j];
        if ([arrM containsObject:number]) {
            i--;
            continue;
        }
        [arrM addObject:number];
    }
    
    for (int i = 0; i < 10; i++) {
       
        UIButton *numBtn = [[UIButton alloc] init];
        NSNumber *number = arrM[i];
        NSString *title = number.stringValue;
        [numBtn setTitle:title forState:UIControlStateNormal];
        
        [numBtn setBackgroundImage:image forState:UIControlStateNormal];
        [numBtn setBackgroundImage:highImage forState:UIControlStateHighlighted];
        numBtn.titleLabel.font = [UIFont boldSystemFontOfSize:LVKeyboardTextFont];
        [numBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [numBtn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:numBtn];
    }
}

- (void)numBtnClick:(UIButton *)numBtn {

    if ([self.delegate respondsToSelector:@selector(keyboard:didClickButton:)]) {
        [self.delegate keyboard:self didClickButton:numBtn];
    }
}


#pragma mark - 删除按钮可以点击 符号、ABC按钮不能点击
- (void)setupBottomButtonsWithImage:(UIImage *)image highImage:(UIImage *)highImage {
    
    self.symbolBtn = [self setupBottomButtonWithTitle:@"符" image:image];
    self.textBtn = [self setupBottomButtonWithTitle:@"ABC" image:image];
    
    // 删除按钮
    self.deleteBtn = [self setupBottomButtonWithTitle:nil image:nil];
    [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"c_number_keyboardDeleteButton"] forState:UIControlStateNormal];
    [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"c_number_keyboardDeleteButtonSel"] forState:UIControlStateHighlighted];
    self.deleteBtn.contentMode = UIViewContentModeCenter;
    [self.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)deleteBtnClick:(UIButton *)deleteBtn {

    if ([self.delegate respondsToSelector:@selector(keyboard:didClickDeleteBtn:)]) {
        [self.delegate keyboard:self didClickDeleteBtn:deleteBtn];
    }
}

- (UIButton *)setupBottomButtonWithTitle:(NSString *)title image:(UIImage *)image {
    
    UIButton *bottomBtn = [[UIButton alloc] init];
    if (title) {
        [bottomBtn setTitle:title forState:UIControlStateNormal];
        bottomBtn.titleLabel.font = [UIFont boldSystemFontOfSize:LVKeyboardTextFont];
        [bottomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (image) {
        [bottomBtn setBackgroundImage:image forState:UIControlStateNormal];
        bottomBtn.userInteractionEnabled = NO;
    }
    [self addSubview:bottomBtn];
    return bottomBtn;
}

- (void)layoutSubviews {

    CGFloat topMargin = 17;
    CGFloat bottomMargin = 3;
    CGFloat leftMargin = 3;
    CGFloat colMargin = 5;
    CGFloat rowMargin = 3;
    
    CGFloat topBtnW = (self.width - 2 * leftMargin - 2 * colMargin) / 3;
    CGFloat topBtnH = (self.height - topMargin - bottomMargin - 3 * rowMargin) / 4;

    NSUInteger count = self.subviews.count;
    
    // 布局数字按钮
    for (NSUInteger i = 0; i < count; i++) {
        if (i == 0 ) { // 0
            UIButton *buttonZero = self.subviews[i];
            buttonZero.height = topBtnH;
            buttonZero.width = topBtnW;
            buttonZero.centerX = self.centerX;
            buttonZero.centerY = self.height - bottomMargin - buttonZero.height * 0.5;
            
            // 符号、文字及删除按钮的位置
            self.deleteBtn.x = CGRectGetMaxX(buttonZero.frame) + colMargin;
            self.deleteBtn.y = buttonZero.y;
            self.deleteBtn.width = buttonZero.width;
            self.deleteBtn.height = buttonZero.height;
            
            self.symbolBtn.x = leftMargin;
            self.symbolBtn.y = buttonZero.y;
            self.symbolBtn.width = buttonZero.width / 2 - colMargin / 2;
            self.symbolBtn.height = buttonZero.height;
            
            self.textBtn.x = CGRectGetMaxX(self.symbolBtn.frame) + colMargin;
            self.textBtn.y = buttonZero.y;
            self.textBtn.width = self.symbolBtn.width;
            self.textBtn.height = self.symbolBtn.height;
            
        }
        if (i > 0 && i < 10) { // 0 ~ 9
            
            UIButton *topButton = self.subviews[i];
            CGFloat row = (i - 1) / 3;
            CGFloat col = (i - 1) % 3;
            
            topButton.x = leftMargin + col * (topBtnW + colMargin);
            topButton.y = topMargin + row * (topBtnH + rowMargin);
            topButton.width = topBtnW;
            topButton.height = topBtnH;
        }
        
    }
    
}

@end

//
//  BWTopMenuView.m
//  BWTopMenuView
//
//  Created by syt on 2019/12/9.
//  Copyright © 2019 syt. All rights reserved.
//

#import "BWTopMenuView.h"


@interface BWTopMenuView ()

@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end
/**
 按钮之间的间距
 */
static CGFloat const btnSpace = 10.0;
/**
 指示器的高度
 */
static CGFloat const lineH = 2.0;
/**
 形变的度数
 */
//static CGFloat const radio = 1.0;

@implementation BWTopMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.defaultColor = UIColor.blackColor;
        self.selectColor = UIColor.blueColor;
        self.lineColor = UIColor.blueColor;
    }
    return self;
}



#pragma mark - setter方法
- (void)setSelectColor:(UIColor *)selectColor
{
    _selectColor = selectColor;
}

- (void)setDefaultColor:(UIColor *)defaultColor
{
    _defaultColor = defaultColor;
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
}


- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    CGFloat bw_x = 0.0;
    CGFloat bw_y = 0.0;
    CGFloat bw_h = self.Bw_height - lineH;
    if (titleArray.count > 0) {
        for (int i = 0; i < titleArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            NSString *title = [NSString stringWithFormat:@"%@", titleArray[i]];
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:self.defaultColor forState:UIControlStateNormal];
            [button setTitleColor:self.selectColor forState:UIControlStateSelected];
            button.titleLabel.font = k_Button_Title_Font;
            button.tag = i;
            CGSize size = [self sizeWithText:title font:k_Button_Title_Font maxSize:CGSizeMake(k_Screen_Width, MAXFLOAT)];
            CGFloat bw_w = size.width + btnSpace * 2;
            button.frame = CGRectMake(bw_x, bw_y, bw_w, bw_h);
            bw_x += bw_w;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                button.selected = YES;
                self.selectButton = button;
            }
            [self addSubview:button];
            [self.buttonArray addObject:button];
        }
        // 计算ScrollView的宽度，设置contentSize
        CGFloat scrollWid = CGRectGetMaxX(self.subviews.lastObject.frame);
        self.contentSize = CGSizeMake(scrollWid, self.Bw_height);
        
        UIButton *button = self.subviews.firstObject;
        UIView *indicatorView = [[UIView alloc] init];
        indicatorView.backgroundColor = self.lineColor;
        indicatorView.Bw_height = lineH;
        indicatorView.Bw_y = self.Bw_height - lineH * 2;
        indicatorView.Bw_width = button.Bw_width - 2 * btnSpace;
        indicatorView.Bw_centerX = button.Bw_centerX;
        self.indicatorView = indicatorView;
        [self addSubview:indicatorView];
    }
}

#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)button
{
    [self setButton:button];
    // 让选中的按钮调整位置
    [self setSelectButtonCenter:button];
    if (self.titleButtonClick) {
        self.titleButtonClick(button.tag, button);
    }
}

// 设置选中按钮的状态以及指示器的位置等
- (void)setButton:(UIButton *)button
{
    self.selectButton.selected = NO;
//    self.selectButton.transform = CGAffineTransformIdentity;
    
    button.selected = YES;
//    button.transform = CGAffineTransformMakeScale(radio, radio);
    self.selectButton = button;
    
    [UIView animateWithDuration:.3f animations:^{
        self.indicatorView.Bw_width = button.Bw_width - 2 * btnSpace;
        self.indicatorView.Bw_centerX = button.Bw_centerX;
    }];
   
}



- (void)setSelectButtonCenter:(UIButton *)centerButton
{
    CGFloat offsetX = centerButton.Bw_centerX - k_Screen_Width / 2;
    CGFloat maxOffsetX = self.contentSize.width - k_Screen_Width;
    if (offsetX < 0) {
        offsetX = 0;
    } else {
        if (offsetX > maxOffsetX) {
            offsetX = maxOffsetX;
        }
    }
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}


- (void)setSelectButtonWithTag:(NSInteger)tag
{
    UIButton *button = self.buttonArray[tag];
    [self setButton:button];
    [self setSelectButtonCenter:button];
}




#pragma mark - 计算按钮的宽度
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}



#pragma mark - lazy loading

- (NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}




@end

//
//  UIView+BwExtention.m
//  BwTopMenuView
//
//  Created by syt on 2019/12/9.
//  Copyright © 2019 syt. All rights reserved.
//

#import "UIView+BWExtention.h"

@implementation UIView (BwExtention)

- (void)setBw_x:(CGFloat)Bw_x{
    CGRect frame = self.frame;
    frame.origin.x = Bw_x;
    self.frame = frame;
}

- (void)setBw_y:(CGFloat)Bw_y {
    CGRect frame = self.frame;
    frame.origin.y = Bw_y;
    self.frame = frame;
}

- (void)setBw_width:(CGFloat)Bw_width{
    CGRect frame = self.frame;
    frame.size.width = Bw_width;
    self.frame = frame;
}

- (void)setBw_height:(CGFloat)Bw_height{
    CGRect frame = self.frame;
    frame.size.height = Bw_height;
    self.frame = frame;
}

- (CGFloat)Bw_x{
    return self.frame.origin.x;
}

- (CGFloat)Bw_y{
    return self.frame.origin.y;
}

- (CGFloat)Bw_width{
    return self.frame.size.width;
}

- (CGFloat)Bw_height{
    return self.frame.size.height;
}

- (CGFloat)Bw_centerX{
    return self.center.x;
}
- (void)setBw_centerX:(CGFloat)Bw_centerX{
    CGPoint center = self.center;
    center.x = Bw_centerX;
    self.center = center;
}

- (CGFloat)Bw_centerY{
    return self.center.y;
}
- (void)setBw_centerY:(CGFloat)Bw_centerY{
    CGPoint center = self.center;
    center.y = Bw_centerY;
    self.center = center;
}

- (void)setBw_size:(CGSize)Bw_size{
    CGRect frame = self.frame;
    frame.size = Bw_size;
    self.frame = frame;
}
- (CGSize)Bw_size{
    return self.frame.size;
}

- (CGFloat)Bw_right{
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)Bw_bottom{
    return CGRectGetMaxY(self.frame);
}

- (void)setBw_right:(CGFloat)Bw_right{
    self.Bw_x = Bw_right - self.Bw_width;
}
- (void)setBw_bottom:(CGFloat)Bw_bottom{
    self.Bw_y = Bw_bottom - self.Bw_height;
}

+ (instancetype)Bw_viewFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}




@end

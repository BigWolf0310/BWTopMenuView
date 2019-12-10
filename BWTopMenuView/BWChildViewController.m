//
//  BWChildViewController.m
//  BWTopMenuView
//
//  Created by syt on 2019/12/9.
//  Copyright © 2019 syt. All rights reserved.
//

#import "BWChildViewController.h"
#import "UIView+BWExtention.h"

#define k_Random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define k_RandomColor k_Random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define k_Screen_Width  [UIScreen mainScreen].bounds.size.width

@interface BWChildViewController ()

@property (nonatomic, strong) UILabel *centerLabel;

@end

@implementation BWChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = k_RandomColor;
    [self createSubViews];
}

- (void)createSubViews
{
    [self.view addSubview:self.centerLabel];
    self.centerLabel.text = [NSString stringWithFormat:@"%@", self.titleString];
}







#pragma mark - lazy loading

- (UILabel *)centerLabel
{
    if (!_centerLabel) {
        _centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.Bw_centerY - 20, k_Screen_Width, 40)];
        _centerLabel.textColor = UIColor.blackColor;
        _centerLabel.textAlignment = NSTextAlignmentCenter;
        _centerLabel.font = [UIFont systemFontOfSize:20];
    }
    return _centerLabel;
}




@end

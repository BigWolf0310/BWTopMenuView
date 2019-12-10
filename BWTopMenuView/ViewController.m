//
//  ViewController.m
//  BWTopMenuView
//
//  Created by syt on 2019/12/9.
//  Copyright © 2019 syt. All rights reserved.
//

#import "ViewController.h"

#import "BWTopMenuView.h"
#import "BWChildViewController.h"



@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) BWTopMenuView *menuView;

@property (nonatomic, strong) UIScrollView *farScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:.9];
    self.title = self.titleArray.firstObject;
    [self createSubViews];
    [self addChildVC];
}

- (void)createSubViews
{
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.farScrollView];
}

- (void)addChildVC
{
    for (int i = 0; i < self.titleArray.count; i++) {
        BWChildViewController *childVC = [[BWChildViewController alloc] init];
        [self addChildViewController:childVC];
        childVC.titleString = self.titleArray[i];
        if (i == 0) {
            [self.farScrollView addSubview:childVC.view];
            childVC.view.frame = CGRectMake(i * k_Screen_Width, 0, k_Screen_Width, self.farScrollView.Bw_height);
        }
    }
}

#pragma mark -
- (void)menuViewTitleClick:(NSInteger)tag
{
    NSString *title = [NSString stringWithFormat:@"%@", self.titleArray[tag]];
    self.title = title;
    [self showChildVC:tag];
}


- (void)showChildVC:(NSInteger)index
{
    CGFloat offsetX = index * k_Screen_Width;
    BWChildViewController *vc = self.childViewControllers[index];
    vc.titleString = self.titleArray[index];
    self.farScrollView.contentOffset = CGPointMake(index * k_Screen_Width, 0);
    if (vc.isViewLoaded) {
        return;
    }
    [self.farScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, k_Screen_Width, self.farScrollView.Bw_height);
}




#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / k_Screen_Width;
    NSString *title = [NSString stringWithFormat:@"%@", self.titleArray[index]];
    self.title = title;
    [self showChildVC:index];
    [self.menuView setSelectButtonWithTag:index];
}










#pragma mark - lazy loading

- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"爱看", @"电视剧", @"综艺", @"动漫", @"NBA", @"短视频", @"直播", @"小说", @"LOL", @"王者荣耀", @"QQ飞车", @"穿越火线"];
    }
    return _titleArray;
}

- (BWTopMenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[BWTopMenuView alloc] initWithFrame:CGRectMake(0, 64, k_Screen_Width, 40)];
        _menuView.titleArray = self.titleArray;
        __weak typeof(self) weakSelf = self;
        _menuView.titleButtonClick = ^(NSInteger tag, UIButton * _Nonnull button) {
            [weakSelf menuViewTitleClick:tag];
        };
    }
    return _menuView;
}

- (UIScrollView *)farScrollView
{
    if (!_farScrollView) {
        _farScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menuView.frame), k_Screen_Width, k_Screen_Height - CGRectGetMaxY(self.menuView.frame))];
        _farScrollView.contentSize = CGSizeMake(k_Screen_Width * self.titleArray.count, 0);
        _farScrollView.pagingEnabled = YES;
        _farScrollView.bounces = NO;
        _farScrollView.showsHorizontalScrollIndicator = YES;
        _farScrollView.delegate = self;
    }
    return _farScrollView;
}



@end

//
//  TPCCheckpointViewController.m
//  oral
//
//  Created by cocim01 on 15/5/15.
//  Copyright (c) 2015年 keximeng. All rights reserved.
//

#import "TPCCheckpointViewController.h"
#import "CheckFollowViewController.h"  // 跟读 part 关卡一


@interface TPCCheckpointViewController ()<UIScrollViewDelegate>

@end

@implementation TPCCheckpointViewController

#define kLeftMarkButtonTag 1234
#define kPartButtonTag 222




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 返回按钮
    [self addBackButtonWithImageName:@"back-Blue"];
    [self addTitleLabelWithTitleWithTitle:@"My Travel"];
    // 界面元素
    [self xib];
}

- (void)xib
{
    // 练习本  成绩单
    [_exerciseBookBtn setBackgroundImage:[UIImage imageNamed:@"exeBook"] forState:UIControlStateNormal];
    _exeLable.textColor = [UIColor colorWithRed:87/255.0 green:224/255.0 blue:192/255.0 alpha:1];

    [_scoreButton setBackgroundImage:[UIImage imageNamed:@"scoreMenu"] forState:UIControlStateNormal];
    _scoreLable.textColor = [UIColor colorWithRed:87/255.0 green:224/255.0 blue:192/255.0 alpha:1];
    
    // part1-3 滚动视图 _partScrollView
    CGRect rect = _partScrollView.frame;
    rect.origin.x = 55;
    rect.size.width = kScreentWidth-55*2;
    _partScrollView.frame = rect;
    _partScrollView.contentSize = CGSizeMake(_partScrollView.bounds.size.width*3, _partScrollView.bounds.size.height);
    _partScrollView.delegate = self;
    NSArray *partTitleArray = @[@"Part One",@"Part Two",@"Part Three"];
    
    for (int i = 0; i < 3; i ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        rect.origin.x = i*rect.size.width;
        rect.origin.y = 0;
        [btn setFrame:rect];
        btn.backgroundColor = [UIColor colorWithRed:87/255.0 green:225/255.0 blue:190/255.0 alpha:1];
        btn.tag = kPartButtonTag+i;
        btn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        btn.layer.cornerRadius = btn.frame.size.height/2;
        [btn setTitle:[partTitleArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(startPart:) forControlEvents:UIControlEventTouchUpInside];
        [_partScrollView addSubview:btn];
    }
    
    // 直接模考按钮
    _startTestBtn.layer.masksToBounds= YES;
    _startTestBtn.layer.cornerRadius = _startTestBtn.frame.size.height/2;
    _startTestBtn.backgroundColor = [UIColor colorWithRed:245/255.0 green:249/255.0 blue:250/255.0 alpha:1];
    [_startTestBtn setTitleColor:[UIColor colorWithRed:90/255.0 green:225/255.0 blue:191/255.0 alpha:1] forState:UIControlStateNormal];
    
    
    // 页码按钮
    _leftMarkBtn.tag = kLeftMarkButtonTag;
    _middleMarkBtn.tag = kLeftMarkButtonTag+1;
    _rightMarkBtn.tag = kLeftMarkButtonTag+2;
    [self drawPageButton:_leftMarkBtn];
    [self drawPageButton:_middleMarkBtn];
    [self drawPageButton:_rightMarkBtn];
    
    [self makePagesAloneWithButtonTag:kLeftMarkButtonTag];
}

#pragma mark - 页码按钮设置为圆形
- (void)drawPageButton:(UIButton *)btn
{
    btn.layer.cornerRadius = _leftMarkBtn.frame.size.width/2;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = [UIColor colorWithRed:87/255.0 green:225/255.0 blue:190/255.0 alpha:1].CGColor;
    btn.layer.borderWidth = 1;
}

#pragma mark - 显示当前的关卡数
- (void)makePagesAloneWithButtonTag:(NSInteger)btnTag
{
    for (int i = 0; i < 3; i ++)
    {
        UIButton *newBtn = (UIButton *)[self.view viewWithTag:kLeftMarkButtonTag+i];
        if (newBtn.tag == btnTag)
        {
            newBtn.backgroundColor = [UIColor colorWithRed:87/255.0 green:225/255.0 blue:190/255.0 alpha:1];
        }
        else
        {
            newBtn.backgroundColor = [UIColor whiteColor];
        }
    }
}

#pragma mark - 开始闯关
- (void)startPart:(UIButton *)btn
{
    CheckFollowViewController *followVC = [[CheckFollowViewController alloc]initWithNibName:@"CheckFollowViewController" bundle:nil];
    [self.navigationController pushViewController:followVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self makePagesAloneWithButtonTag:(int)(scrollView.contentOffset.x/scrollView.frame.size.width)+kLeftMarkButtonTag];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 直接模考
- (IBAction)testButtonClicked:(id)sender
{
    
}
@end

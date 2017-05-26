//
//  JJViewController.m
//  JJTagListViewDemo
//
//  Created by JunJunWin on 05/26/2017.
//  Copyright (c) 2017 JunJunWin. All rights reserved.
//

#import "JJViewController.h"
#import <JJTagListViewDemo/JJTagListView.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface JJViewController () <JJTagListViewDelegate>
@property (nonatomic ,strong) JJTagListView *tagListView;
@end

@implementation JJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tagListView];
    [_tagListView setTagWithTagArray:@[@"安徒生童话",@"一千零一夜",@"舞吧，舞吧，我的玩偶",@"最难使人相信的事情",@"阿里巴巴与四十大盗",@"辛巴德历险记",@"打火匣",@"一本不说话的书",@"小克劳斯和大克劳斯",@"天上落下来的一片叶子",@"当幸福来敲门",@"詹姆斯",@"库里"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (JJTagListView *)tagListView {
    if(!_tagListView) {
        _tagListView = [[JJTagListView alloc] initWithFrame:CGRectMake(0, 80, kScreenWidth, 400)];
        _tagListView.tagHeight = 28;
        _tagListView.tagLabelGap = 20;
        _tagListView.backgroundColor = [UIColor whiteColor];
        _tagListView.selectedHighlightColor = [UIColor greenColor];
        _tagListView.delegate = self;
        [_tagListView setMarginBetweenTagLabel:12 AndBottomMargin:10];
    }
    return _tagListView;
}


@end

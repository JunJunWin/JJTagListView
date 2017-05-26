//
//  JJTagListView.h
//  JJTagListView
//
//  Created by JunWin on 2017/5/25.
//  Copyright © 2017年 JunWin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJTagListView;
@protocol JJTagListViewDelegate <NSObject>

@optional
/**
 *  点击之后，选中的所有item
 *
 *  @param array       选中的数组
 *  @param tagListView tagListView
 */
- (void)JJTagListViewdidselectItem:(NSArray<NSString *> *)array tagListView:(JJTagListView *)tagListView;
/**
 *  点击某一个标签
 *
 *  @param tagStr      tagStr
 *  @param tagListView tagListView
 */
- (void)JJTagListViewClickedItem:(NSString *)tagStr tagListView:(JJTagListView *)tagListView;

@end

@interface JJTagListView : UIView

#pragma mark - 属性

#pragma mark -
#pragma mark - 颜色
/**
 * 整个view的背景色 默认clearColor
 */
@property (nonatomic, strong) UIColor *jjBackgroundColor;

/**
 *  设置tag背景色 默认白色
 */
@property (nonatomic, strong) UIColor *singleTagColor;

/**
 *  设置tag选中时背景色 默认同singleTagColor一致
 */
@property (nonatomic, strong) UIColor *singleSelectedColor;

/**
 *  设置tag高亮背景色 默认同singleTagColor一致
 */
@property (nonatomic, strong) UIColor *selectedHighlightColor;

/**
 *  设置tag边框颜色 默认灰色R_G_B_16(0xd9d9d9)
 */
@property (nonatomic, strong) UIColor *tagBorderColor;

/**
 *  设置tag选中边框颜色 默认同tagBorderColor一致
 */
@property (nonatomic, strong) UIColor *tagSelectedBorderColor;

#pragma mark - 字体，字体颜色
/**
 *  设置tag的字体大小 默认[UIFont systemFontOfSize:13]
 */
@property (nonatomic, strong) UIFont *tagTextLabelFont;

/**
 *  设置tag字体颜色 默认黑色
 */
@property (nonatomic, strong) UIColor *tagTextColor;

/**
 *  设置tag选中时文字颜色 默认和tagTextColor一致
 */
@property (nonatomic, strong) UIColor *tagSelectedTextColor;

#pragma mark - 点击
/**
 *  是否可点击 默认YES
 */
@property (nonatomic, assign) BOOL canTouch;

/**
 *  限制点击个数 默认0（无限制）
 */
@property (nonatomic, assign) NSInteger canTouchNum;

/**
 *  单选模式 默认YES 该属性的优先级要高于canTouchNum
 */
@property (nonatomic, assign) BOOL isSingleSelect;

#pragma mark - 位置
/**
 *  每一行第一个tag的x轴  默认20
 */
@property (nonatomic, assign) CGFloat originX;

/**
 *  tag的高度 默认以字体具体计算为高度
 */
@property (nonatomic, assign) CGFloat tagHeight;

/**
 *  tag的文字路径tag边框的距离 默认为10
 */
@property (nonatomic, assign) CGFloat tagLabelGap;

#pragma mark - 回调
/**
 *  回调统计选中tag
 */
@property (nonatomic, copy) void (^didselectItemBlock)(NSArray *arr);

/**
 *  代理，block和代理都会执行
 */
@property (nonatomic, weak) id<JJTagListViewDelegate> delegate;
#pragma mark - 方法
/**
 *  标签文本赋值
 */
- (void)setTagWithTagArray:(NSArray*)arr;

/**
 *  带预先设置选中 标签文本赋值初始化
 *
 *  @param arr           arr
 *  @param selectedArray selectedArray
 */
-(void)setTagWithTagArray:(NSArray*)arr selectedArray:(NSArray *)selectedArray;

/**
 *  设置tag之间的距离
 *
 *  @param Margin
 */
- (void)setMarginBetweenTagLabel:(CGFloat)Margin
                 AndBottomMargin:(CGFloat)BottomMargin;
@end

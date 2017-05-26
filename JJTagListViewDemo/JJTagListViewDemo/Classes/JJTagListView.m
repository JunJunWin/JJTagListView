//
//  JJTagListView.m
//  JJTagListView
//
//  Created by JunWin on 2017/5/25.
//  Copyright © 2017年 JunWin. All rights reserved.
//

#import "JJTagListView.h"

#define HORIZONTAL_PADDING 7.0f
#define VERTICAL_PADDING   3.0f
#define LABEL_MARGIN       10.0f
#define BOTTOM_MARGIN      10.0f
#define KBtnTag            1000

#define R_G_B_16(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]



@interface JJTagListView () {
    CGFloat _KTagMargin; // 左右tag之间的间距
    CGFloat _KBottomMargin; // 上下tag之间的间距
    NSInteger _kSelectNum; // 实际选中的标签数

    CGRect previousFrame;
    NSInteger totalHeight;
    NSMutableArray *_tagArr;
}
@end

@implementation JJTagListView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self configDefautl];
    }
    return self;

}

- (void)configDefautl {
    _kSelectNum = 0;
    totalHeight = 0;
    _tagArr = [[NSMutableArray alloc]init];

    self.isSingleSelect = YES;
    self.canTouch = YES;
    self.canTouchNum = 0;

    self.singleTagColor = [UIColor whiteColor];
    self.singleSelectedColor = self.singleTagColor;
    self.selectedHighlightColor = self.singleSelectedColor;

    self.backgroundColor = [UIColor clearColor];

    self.tagTextLabelFont = [UIFont systemFontOfSize:13];
    self.tagTextColor = [UIColor blackColor];
    self.tagBorderColor = R_G_B_16(0xd9d9d9);
    self.originX = 20;
    self.tagLabelGap = 10;
    self.tagHeight = -1;
}


-(void)setTagWithTagArray:(NSArray*)arr selectedArray:(NSArray *)selectedArray {
    // 清空处理
    totalHeight = 0;
    [_tagArr removeAllObjects];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }

    // 参数合法性检验
    if (0 == arr.count || nil == arr) {
        CGRect tempFrame = self.frame;
        tempFrame.size.height = 0;
        self.frame = tempFrame;
        return;
    }


    previousFrame = CGRectZero;

    [_tagArr addObjectsFromArray:arr];

    [arr enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL *stop) {

        UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tagBtn.frame = CGRectZero;

        if (_singleTagColor) {
            // 可以单一设置tag的颜色
            tagBtn.backgroundColor = _singleTagColor;
        } else {
            // tag颜色s随机
            tagBtn.backgroundColor = [UIColor colorWithRed:random()%255/255.0
                                                     green:random()%255/255.0
                                                      blue:random()%255/255.0 alpha:1];
        }

        tagBtn.userInteractionEnabled = _canTouch;

        [tagBtn setTitleColor:self.tagTextColor forState:UIControlStateNormal];
        [tagBtn setTitleColor:self.tagTextColor forState:UIControlStateSelected];
        [tagBtn setBackgroundImage:[JJTagListView imageWithColor:self.selectedHighlightColor]
                          forState:UIControlStateHighlighted];

        [tagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [tagBtn setTitle:str forState:UIControlStateNormal];

        tagBtn.titleLabel.font = self.tagTextLabelFont;
        tagBtn.tag = KBtnTag + idx;
        tagBtn.layer.borderColor = self.tagBorderColor.CGColor;
        tagBtn.layer.borderWidth = 1;
        tagBtn.clipsToBounds = YES;

        // 特殊处理
        if (selectedArray && [selectedArray containsObject:str]) {
            tagBtn.selected = YES;

            if (_singleSelectedColor) {
                tagBtn.backgroundColor = _singleSelectedColor;
            }

            if (_tagSelectedTextColor) {
                [tagBtn setTitleColor:_tagSelectedTextColor forState:UIControlStateNormal];
                [tagBtn setTitleColor:_tagSelectedTextColor forState:UIControlStateSelected];
            }

            if (_tagSelectedBorderColor) {
                tagBtn.layer.borderColor = _tagSelectedBorderColor.CGColor;
            }
        }


        NSDictionary *attrs = @{NSFontAttributeName : self.tagTextLabelFont};
        CGSize tempSize = [str sizeWithAttributes:attrs];
        CGSize Size_str;

        if (self.tagHeight == -1) {
            Size_str = tempSize;
            Size_str.width += HORIZONTAL_PADDING * 3;
            Size_str.height += VERTICAL_PADDING * 3;
        } else {
            // 自定义高度和宽度
            CGFloat width = [str sizeWithAttributes:@{NSFontAttributeName:self.tagTextLabelFont}].width  + self.tagLabelGap * 2;
            Size_str = CGSizeMake(width, self.tagHeight);
        }

        CGRect newRect = CGRectZero;

        BOOL isFirstItem = idx == 0 ;
        BOOL needChangeLine = previousFrame.origin.x + previousFrame.size.width + Size_str.width + _KTagMargin > self.bounds.size.width;

        if(_KTagMargin && _KBottomMargin) {

            if (needChangeLine) {
                newRect.origin = CGPointMake(self.originX, previousFrame.origin.y + Size_str.height + _KBottomMargin);
                totalHeight += Size_str.height + _KBottomMargin;
            }
            else {
                if (isFirstItem) {
                    newRect.origin = CGPointMake(self.originX, previousFrame.origin.y);
                } else {
                    newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + _KTagMargin, previousFrame.origin.y);
                }
            }

            [self setHight:self
                  andHight:totalHeight+Size_str.height + _KBottomMargin];
        } else {

            if (needChangeLine) {
                newRect.origin = CGPointMake(self.originX, previousFrame.origin.y + Size_str.height + BOTTOM_MARGIN);
                totalHeight += Size_str.height + BOTTOM_MARGIN;
            }
            else {
                if (isFirstItem) {
                    newRect.origin = CGPointMake(self.originX, previousFrame.origin.y);
                } else {
                    newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + LABEL_MARGIN, previousFrame.origin.y);
                }
            }

            [self setHight:self
                  andHight:totalHeight+Size_str.height + BOTTOM_MARGIN];
        }

        newRect.size = Size_str;
        tagBtn.layer.cornerRadius = Size_str.height * 0.5;// 纯圆角
        
        [tagBtn setFrame:newRect];
        previousFrame = tagBtn.frame;
        
        [self addSubview:tagBtn];
    }];

}

-(void)setTagWithTagArray:(NSArray*)arr {
    [self setTagWithTagArray:arr selectedArray:nil];
}

#pragma mark - 改变控件高度

- (void)setHight:(UIView *)view andHight:(CGFloat)hight {

    if (view == self) { // 去掉最底部多余的边距
        if (_KBottomMargin) {
            hight -= _KBottomMargin;
        } else {
            hight -= BOTTOM_MARGIN;
        }
    }

    CGRect tempFrame = view.frame;
    tempFrame.size.height = hight;
    view.frame = tempFrame;

}

-(void)tagBtnClick:(UIButton*)button{

    if (_isSingleSelect){
        if(button.selected) {
            button.selected = !button.selected;
        } else {
            button.selected = YES;

            button.backgroundColor = _singleTagColor;
            [button setTitleColor:_tagTextColor forState:UIControlStateNormal];
            [button setTitleColor:_tagTextColor forState:UIControlStateSelected];

            button.layer.borderColor = _tagBorderColor.CGColor;
        }
    } else {
        button.selected=!button.selected;
    }

    if (button.selected) {
        if (_singleSelectedColor) {
            button.backgroundColor = _singleSelectedColor;
        }

        if (_tagSelectedTextColor) {
            [button setTitleColor:_tagSelectedTextColor forState:UIControlStateNormal];
            [button setTitleColor:_tagSelectedTextColor forState:UIControlStateSelected];
        }

        if (_tagSelectedBorderColor) {
            button.layer.borderColor = _tagSelectedBorderColor.CGColor;
        }

    } else  {
        button.backgroundColor = _singleTagColor;

        [button setTitleColor:_tagTextColor forState:UIControlStateNormal];
        [button setTitleColor:_tagTextColor forState:UIControlStateSelected];

        button.layer.borderColor = _tagBorderColor.CGColor;
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(JJTagListViewClickedItem:tagListView:)]) {
        [self.delegate JJTagListViewClickedItem:button.titleLabel.text tagListView:self];
    }
    [self didSelectItems];
}

-(void)didSelectItems {

    NSMutableArray *arr = [[NSMutableArray alloc]init];

    for(UIView *view in self.subviews) {
        if([view isKindOfClass:[UIButton class]]) {
            UIButton *tempBtn = (UIButton *)view;
            tempBtn.enabled = YES;
            if (tempBtn.selected) {
                [arr addObject:_tagArr[tempBtn.tag - KBtnTag]];
                _kSelectNum = arr.count;
            }
        }
    }

    // 不为空与相同数量
    if((_kSelectNum && self.canTouch) &&
       (_kSelectNum == self.canTouchNum)){
        
        for(UIView *view in self.subviews){
            UIButton *tempBtn = (UIButton*)view;
            tempBtn.enabled = tempBtn.selected;
        }
        
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(JJTagListViewdidselectItem:tagListView:)]) {
        [self.delegate JJTagListViewdidselectItem:arr tagListView:self];
    }

    if (self.didselectItemBlock) {
        self.didselectItemBlock(arr);
    }
}

-(void)setMarginBetweenTagLabel:(CGFloat)Margin AndBottomMargin:(CGFloat)BottomMargin{
    _KTagMargin = Margin;
    _KBottomMargin = BottomMargin;
}

#pragma mark - Getter/Setter 
- (void)setJjBackgroundColor:(UIColor *)jjBackgroundColor {
    _jjBackgroundColor = jjBackgroundColor;
    if(_jjBackgroundColor){
        self.backgroundColor = jjBackgroundColor;
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - Helper

+ (UIImage *)imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

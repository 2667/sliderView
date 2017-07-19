//
//  ScollowIndicatorView.m
//  scrollHeadView
//
//  Created by Ios on 17/7/18.
//  Copyright © 2017年 qidongTech. All rights reserved.
//

#import "ScollowIndicatorView.h"


@interface ScollowIndicatorView()<UIScrollViewDelegate>

@property(nonatomic,strong)UIButton *originalBtn;//记录第一按钮

@property(nonatomic,strong)UIButton *lastButton;//记录上一次选中按钮

@property(nonatomic,strong)UIScrollView *scrollview;//滑动视图
@property(nonatomic,strong)UIView *indicatorView;//指示视图


@property(nonatomic,assign)CGFloat realButtonWidth;//实际按钮的宽度




@end
static CGFloat buttonWith = 88;
static CGFloat buttonHeigh = 45;

static CGFloat indicatorWith = 15;
static CGFloat indicatorHeight = 2;
static CGFloat originalX = 37;
static CGFloat originalY = 39;
@implementation ScollowIndicatorView

-(UIView *)indicatorView{
    if (!_indicatorView) {
        UIView *indicatorview = [[UIView alloc]initWithFrame:CGRectMake(originalX,originalY , indicatorWith, indicatorHeight)];
        indicatorview.center= CGPointMake(_originalBtn.center.x, originalY);
        
        _indicatorView = indicatorview;
      
        indicatorview.backgroundColor = [UIColor colorWithRed:69/255.0 green:164/255.0 blue:214/255.0 alpha:1.0];
    }
    return  _indicatorView;
}
-(UIScrollView *)scrollview{
    if (!_scrollview) {
        UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 45)];
      //  scrollview.backgroundColor = [UIColor greenColor];
        scrollview.delegate = self;
        
        NSInteger count =  self.mut.count;
       CGFloat  allWidth = count * buttonWith;
        if (allWidth > self.bounds.size.width) {
            _realButtonWidth = buttonWith;
        }else{
            _realButtonWidth = self.bounds.size.width / count;
        }
        
        scrollview.contentSize = CGSizeMake(_realButtonWidth * count, 15);
        
        scrollview.showsVerticalScrollIndicator = NO;
        scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview = scrollview;
    }
    return  _scrollview;
}

-(void)setMut:(NSArray *)mut{
    _mut = mut;
    
    [self initScrollview];
    [self addSubview:self.indicatorView];
    [self.scrollview addSubview:self.indicatorView];
 
}

-(void)initScrollview{
    
    [self addSubview:self.scrollview];
    
    [self addBtn];
}

-(void)addBtn{
    NSInteger count = self.mut.count;
    if (count == 0) {
        return;
    }
    for (NSInteger i = 0; i< count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == 0) {
            _originalBtn = button;
        }
        
        button.frame = CGRectMake(_realButtonWidth * i , 0, _realButtonWidth, buttonHeigh);
        [button setTitle:self.mut[i] forState:UIControlStateNormal];
        //button.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
        [button setTitleColor:[UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1.0] forState:UIControlStateSelected];
        button.titleLabel.font =[UIFont systemFontOfSize:15];
        
        [self.scrollview addSubview:button];
        
        [button addTarget:self action:@selector(clik:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i ;
        
        if (i == 0) {
            [self clik:button];
        }
        
        
    }
}
-(void)clik:(UIButton *)button{
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
    _lastButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _lastButton = button;
       NSInteger tag = button.tag - 100;
    
    [self changeUI:(UIButton *)button];
    
    #pragma mark ---delegate
    if ([self.delegate respondsToSelector:@selector(scollowIndicatorViewPassSelectedIndex:)]) {
        [self.delegate scollowIndicatorViewPassSelectedIndex:tag];
    }

    
}
//改变indicator 的位置，改变按钮的选中状态
-(void)changeUI:(UIButton *)button{
    //改变indicator 的frame
    [self changeIndicaterFrameWithButton:button];
    
    //让选中的内容居中
    [self makeTheSelectedcontentAtMiddle:(UIButton *)button];
}

-(void)changeIndicaterFrameWithButton:(UIButton *)button{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.center = CGPointMake(button.center.x, 40);
    }];
}
-(void)makeTheSelectedcontentAtMiddle:(UIButton *)button{
    CGFloat scrollviewWith = self.scrollview.bounds.size.width * 0.5;// 1/2 scrollview 宽
    CGFloat buttonCenterX = button.center.x; // 按钮的中心位置
    CGFloat distance = buttonCenterX - scrollviewWith;//最大偏移量
    
    CGFloat maxContentOffset = self.scrollview.contentSize.width - self.scrollview.bounds.size.width;
    if (distance < 0) {
        distance = 0;
    }else if (distance > maxContentOffset ){
        distance = maxContentOffset;
    }

    [self.scrollview setContentOffset:CGPointMake(distance, 0) animated:YES];
    
}

-(void)setContentOffSetNum:(NSInteger)contentOffSetNum{
    UIButton *button  = (UIButton *)[self viewWithTag:(contentOffSetNum +100)];
    [self changeUI:button];
    [self makeTheSelectedcontentAtMiddle:button];
}


#pragma mark  ---scrollviewDelegate




@end

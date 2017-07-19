//
//  ScollowIndicatorView.h
//  scrollHeadView
//
//  Created by Ios on 17/7/18.
//  Copyright © 2017年 qidongTech. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ScollowIndicatorViewDelegate <NSObject>
//传出选中按钮的tag
-(void)scollowIndicatorViewPassSelectedIndex:(NSInteger )index;

@end


@interface ScollowIndicatorView : UIView
@property(nonatomic,strong)NSArray *mut;
@property(nonatomic,weak)id<ScollowIndicatorViewDelegate>delegate;

@property(nonatomic,assign)NSInteger contentOffSetNum;
@end

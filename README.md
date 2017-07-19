# sliderView
用户新闻标题导航的 控件



#文档说明
@protocol ScollowIndicatorViewDelegate <NSObject>
//index 为选中title 的 下标
-(void)scollowIndicatorViewPassSelectedIndex:(NSInteger )index;

@end


@interface ScollowIndicatorView : UIView

@property(nonatomic,strong)NSArray *mut;//传入存放title 的数组
@property(nonatomic,weak)id<ScollowIndicatorViewDelegate>delegate;
@property(nonatomic,assign)NSInteger contentOffSetNum;//scrollview 滚动之后所显示控制器对应的index，一般为scrollview的偏移量除以屏幕宽

@end

#如果mut 中的title 很多的话，每个title 所对应的宽度是一定的
如果mut 总的title 数量很少，会自动计算title 的宽度来适应整个屏幕宽


使用实例：
ScollowIndicatorView *topContianerView1 =[[ScollowIndicatorView alloc]initWithFrame:CGRectMake(0, top, self.view.bounds.size.width, 45)]；

topContianerView1.mut = self.currentChannelsArray;

topContianerView1.delegate = self;

[self.view addSubview:topContianerView1];

--实现代理方法

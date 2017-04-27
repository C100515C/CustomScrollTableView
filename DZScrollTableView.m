

#import "DZScrollTableView.h"

@interface DZScrollTableView ()<UIGestureRecognizerDelegate>
@property (nonatomic,assign) DZScrollDirection direct;

@end

@implementation DZScrollTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
//        UIPanGestureRecognizer *left = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftPan:)];
//        UIScreenEdgePanGestureRecognizer *left = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(leftPan:)];
//        left.edges = UIRectEdgeLeft;
        
        
        UIPanGestureRecognizer *right = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rightPan:)];
//        UIScreenEdgePanGestureRecognizer *right = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(rightPan:)];
//        right.edges = UIRectEdgeRight;
        
//        [self addGestureRecognizer:left];
        [self addGestureRecognizer:right];
    }
    return self;
}

-(void)leftPan:(UIScreenEdgePanGestureRecognizer*)sender{
    CGPoint p = [sender locationInView:self];
    NSLog(@"左-%f",p.x);
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (self.scrollDelegate&& [self.scrollDelegate conformsToProtocol:@protocol(DZScrollTableScrollProtocol)]) {
            [self.scrollDelegate scrollWith:DZScrollDirectionLeft];
        }
    }
    
}

-(void)rightPan:(UIScreenEdgePanGestureRecognizer*)sender{
    CGPoint p = [sender locationInView:self];
    NSLog(@"右-%f",p.x);
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (self.scrollDelegate&& [self.scrollDelegate conformsToProtocol:@protocol(DZScrollTableScrollProtocol)]) {
            if (self.direct!=DZScrollDirectionNone) {
                [self.scrollDelegate scrollWith:self.direct];
            }
            
        }
    }else if (sender.state==UIGestureRecognizerStateChanged){
        [self commitTranslation:[sender translationInView:self]];

    }
    
}

/**
 *   判断手势方向
 *
 *  @param translation translation description
 */
- (void)commitTranslation:(CGPoint)translation
{
    
    CGFloat absX = fabs(translation.x);
    CGFloat absY = fabs(translation.y);
    
    // 设置滑动有效距离
    if (MAX(absX, absY) < 50)
        return;
    NSLog(@"左-%f--上-%f",translation.x,translation.y);
    NSLog(@"差-%f",absX-absY);

    if (absX-absY > 50 ) {
        
        if (translation.x<0) {
            
            //向左滑动
            self.direct = DZScrollDirectionLeft;
        }else{
            
            //向右滑动
            self.direct = DZScrollDirectionRight;

        }
        return ;
        
    } else if (absY-absX > 50) {
        
        if (translation.y<0) {
            //向上滑动
            
        }else{
            //向下滑动
        }
    }
    self.direct = DZScrollDirectionNone;

}
//gestureRecognizer 回调 判断是否是table上添加多手势 返回yes table 支持多手势 no不支持
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    return NO;
}

@end

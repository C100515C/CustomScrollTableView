

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DZScrollDirection) {
    DZScrollDirectionLeft = 1,
    DZScrollDirectionRight,
    DZScrollDirectionNone
};

@protocol DZScrollTableScrollProtocol <NSObject>

-(void)scrollWith:(DZScrollDirection)direction;

@end

@interface DZScrollTableView : UITableView

@property (nonatomic,assign) id<DZScrollTableScrollProtocol> scrollDelegate;

@end

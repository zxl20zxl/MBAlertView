
#import "MBAlertAbstract.h"
#import "MBFlatAlertButton.h"

@class MBFlatAlertButton;

@interface MBFlatAlertView : MBAlertAbstract
@property (nonatomic, copy) NSString *alertTitle;
@property (nonatomic, copy) NSString *detailText;
@property (nonatomic, readonly) UIView *contentView;
@property (nonatomic) CGFloat contentViewHeight;
@property (nonatomic) BOOL isRounded;

- (void)addButtonWithTitle:(NSString*)title type:(MBFlatAlertButtonType)type action:(MBFlatAlertButtonAction)action;

+ (instancetype)alertWithTitle:(NSString*)title detailText:(NSString*)detailText cancelTitle:(NSString*)cancelTitle cancelBlock:(MBFlatAlertButtonAction)cancelBlock;

CAAnimation *flatDismissAnimation();
@end


#import "MBAlertAbstract.h"
#import "MBFlatAlertButton.h"

@class MBFlatAlertButton;

@interface MBFlatAlertView : MBAlertAbstract
@property (nonatomic, copy) NSString *alertTitle;
@property (nonatomic, copy) NSString *detailText;

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *detailsLabel;

@property (nonatomic, readonly) UIView *contentView;
@property (nonatomic) CGFloat contentViewHeight;
@property (nonatomic) BOOL isRounded;
@property (nonatomic) CGFloat horizontalMargin;
@property (nonatomic) BOOL hasBlurBackground;

// default is YES
@property (nonatomic) BOOL dismissesOnButtonPress;

- (void)addButtonWithTitle:(NSString*)title type:(MBFlatAlertButtonType)type action:(MBFlatAlertButtonAction)action;
- (void)addButton:(MBFlatAlertButton*)button;

+ (instancetype)alertWithTitle:(NSString*)title detailText:(NSString*)detailText cancelTitle:(NSString*)cancelTitle cancelBlock:(MBFlatAlertButtonAction)cancelBlock;

+ (CAAnimation*)flatDismissAnimation;
@end

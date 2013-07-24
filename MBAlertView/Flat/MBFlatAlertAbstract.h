
#import "MBAlertAbstract.h"

@interface MBFlatAlertAbstract : MBAlertAbstract
@property (nonatomic, strong) UIView *backgroundView;
- (void)addDismissAnimation;
- (UIView*)viewToApplyPresentationAnimationsOn;
- (void)configureBackgroundView;
+ (CAAnimation*)flatDismissAnimation;
@end

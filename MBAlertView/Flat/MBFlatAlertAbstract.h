
#import "MBAlertAbstract.h"

@interface MBFlatAlertAbstract : MBAlertAbstract
@property (nonatomic) UIView *backgroundView;
- (void)addDismissAnimation;
- (UIView*)viewToApplyPresentationAnimationsOn;
- (void)configureBackgroundView;
+ (CAAnimation*)flatDismissAnimation;
@end

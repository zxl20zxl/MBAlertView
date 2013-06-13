
#import <UIKit/UIKit.h>

typedef void (^MBFlatAlertButtonAction)();

typedef enum {
    MBFlatAlertButtonTypeNormal,
    MBFlatAlertButtonTypeBold
} MBFlatAlertButtonType;

@interface MBFlatAlertButton : UIButton
@property (nonatomic, copy) MBFlatAlertButtonAction action;
@property (nonatomic, copy) NSString *title;
@property (nonatomic) MBFlatAlertButtonType type;
@property (nonatomic) UIColor *textColor;
@property (nonatomic) BOOL hasRightStroke;
@end

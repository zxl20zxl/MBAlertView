
#import "MBFlatAlertView.h"
//#import "GPUImage.h"

@interface MBFlatAlertView ()
{
    UILabel *titleLabel;
    UILabel *detailsLabel;
    UIView *containerView;
    UIView *backgroundView;
    UIView *containerBackground;
    NSMutableArray *buttons;
}

@end

@implementation MBFlatAlertView

#pragma mark - Blur Configuration

/*
 The below produces an effect exactly similar to iOS 7s blur, but is too slow to be practical. I've left it here in case you want to experiment.
 */

//- (UIImage*)screenshot
//{
//    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
//    UIGraphicsBeginImageContextWithOptions(window.bounds.size, YES, 1.0);
//    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return viewImage;
//}

//- (void)addToWindow
//{
//    UIImage *screenshot = [self screenshot];
//    
//    GPUImageGaussianBlurFilter *filter = [GPUImageGaussianBlurFilter new];
////    filter.blurSize = 2;
//    UIImage *processedScreenshot = [filter imageByFilteringImage:screenshot];
//    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:processedScreenshot];
//    imageView.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [super addToWindow];
//    
//    [containerView insertSubview:imageView atIndex:0];
//
//    [self.view addConstraints:constraintsCenter(imageView, self.view)];
//}

#pragma mark - View Configuration

- (void)loadView
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, window.size.width, window.size.height - statusBarRect.size.height)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    [self configureBackgroundView];
    [self configureContainerView];
    [self configureLabels];
    [self configureConstraints];
    [self layoutButtons];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.25 animations:^{
        backgroundView.alpha = 1.0;
    }];
}

static const CGFloat buttonHeight = 40;

- (void)configureConstraints
{
    [self.view addConstraints:
        constraintsEqualSizeAndPosition(backgroundView, self.view)
     ];
    
    [self.view addConstraints:@[
        constraintCenterX(detailsLabel, self.view),
        constraintCenterY(detailsLabel, self.view),
        constraintWidth(detailsLabel, containerView, -20)
     ]];
    
    [self.view addConstraints:@[
        constraintEqualAttributes(titleLabel, detailsLabel, NSLayoutAttributeBottom, NSLayoutAttributeTop, -4),
        constraintCenterX(titleLabel, self.view)
     ]];
    
    [self.view addConstraints:@[
        constraintCenterX(containerView, self.view),
        constraintWidth(containerView, self.view, -40),
        constraintTop(containerView, titleLabel, -16),
        constraintBottom(containerView, detailsLabel, buttonHeight + 15)
     ]];
    
    [self.view addConstraints:constraintsEqualSizeAndPosition(containerBackground, containerView)];
}

- (void)configureView
{

}

- (void)configureBackgroundView
{
    backgroundView = [UIView newForAutolayoutAndAddToView:self.view];
    backgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    backgroundView.alpha = 0.0;
}

- (void)configureContainerView
{
    containerView = [UIView newForAutolayoutAndAddToView:self.view];
    containerView.backgroundColor = [UIColor grayColor];
    containerView.layer.cornerRadius = 5.0;
    containerView.backgroundColor = [UIColor clearColor];
    containerView.clipsToBounds = YES;
    
    containerBackground = [UIView newForAutolayoutAndAddToView:containerView];
    containerBackground.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.95];
}

- (void)configureLabels
{
    titleLabel = [UILabel newForAutolayoutAndAddToView:containerView];
    titleLabel.text = _alertTitle;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    detailsLabel = [UILabel newForAutolayoutAndAddToView:containerView];
    detailsLabel.text = _detailText;
    detailsLabel.textColor = [UIColor colorWithRed:0.137 green:0.141 blue:0.145 alpha:1];
    detailsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    detailsLabel.backgroundColor = [UIColor clearColor];
    detailsLabel.numberOfLines = 0;
    detailsLabel.preferredMaxLayoutWidth = self.view.bounds.size.width;
}

#pragma mark - Buttons

- (void)addButtonWithTitle:(NSString*)title type:(MBFlatAlertButtonType)type action:(MBFlatAlertButtonAction)action
{
    MBFlatAlertButton *button = [MBFlatAlertButton new];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.action = action;
    button.title = title;
    button.type = type;
    
    if(!buttons)
        buttons = [NSMutableArray new];
    
    [buttons addObject:button];
}

- (void)layoutButtons
{
    [buttons enumerateObjectsUsingBlock:^(MBFlatAlertButton *button, NSUInteger idx, BOOL *stop) {
        if(!button.superview)
            [containerView addSubview:button];
        [self.view addConstraint:constraintEqualWithMultiplier(button, containerView, NSLayoutAttributeWidth, 0, 1.0/buttons.count)];
        [self.view addConstraint:constraintHeight(button, nil, buttonHeight)];
        [self.view addConstraint:constraintBottom(button, containerView, 0)];
        
        if(idx > 0) {
            MBFlatAlertButton *previousButton = buttons[idx - 1];
            [self.view addConstraint:constraintEqualAttributes(button, previousButton, NSLayoutAttributeLeft, NSLayoutAttributeRight, 0)];
        } else {
            [self.view addConstraint:constraintLeft(button, containerView, 0)];
        }
        
        if(idx != buttons.count - 1)
            button.hasRightStroke = YES;
        
        [button addTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
        [button addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

- (void)pressedButton:(MBFlatAlertButton*)button
{
    if(button.action)
        button.action();
    [self dismiss];
}

#pragma mark - Animation

- (void)addDismissAnimation
{
    CGFloat const duration = 0.2;
    [UIView animateWithDuration:duration animations:^{
        backgroundView.alpha = 0.0;
        containerView.alpha = 0.0;
    }];
    
    [containerView.layer addAnimation:smoothDismissAnimation() forKey:@"anim"];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self performSelector:@selector(removeAlertFromView)];
    });
}

#define scale(x, y, z) [NSValue valueWithCATransform3D:CATransform3DMakeScale(x, y, z)]

static CAAnimation *smoothDismissAnimation() {
    NSArray *frameValues = @[scale(1.0, 1.0, 1.0), scale(0.7, 0.7, 0.7)];
    NSArray *frameTimes = @[@(0.0), @(1.0)];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.15;
    animation.keyTimes = frameTimes;
    animation.values = frameValues;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    return animation;
}

#pragma mark - Class Methods

+ (instancetype)alertWithTitle:(NSString*)title detailText:(NSString*)detailText cancelTitle:(NSString*)cancelTitle cancelBlock:(MBFlatAlertButtonAction)cancelBlock
{
    MBFlatAlertView *alert = [MBFlatAlertView new];
    alert.alertTitle = title;
    alert.detailText = detailText;
    [alert addButtonWithTitle:cancelTitle type:MBFlatAlertButtonTypeBold action:cancelBlock];
    return alert;
}

@end

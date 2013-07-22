
#import "MBFlatAlertView.h"
#import "AutoLayoutHelpers.h"
#import "UIView+Autolayout.h"

@interface MBFlatAlertView ()
{
    UIView *containerView;
    UIView *backgroundView;
    UIView *containerBackground;
    NSMutableArray *buttons;
    UIView *verticallyCenteredContainer;
    UIView *buttonsView;
}

@end

@implementation MBFlatAlertView
@synthesize contentView = _contentView, titleLabel, detailsLabel;

#pragma mark - View Configuration

- (instancetype)init
{
    if(self = [super init]) {
        _horizontalMargin = 20;
        _dismissesOnButtonPress = YES;
        
        titleLabel = [UILabel newForAutolayoutAndAddToView:nil];
        detailsLabel = [UILabel newForAutolayoutAndAddToView:nil];
    }
    return self;
}

//- (void)loadView
//{
//    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
//    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
//    self.view = [[UIView alloc] initWithFrame:
//                 CGRectMake(0, 0, window.bounds.size.width, window.bounds.size.height - statusBarRect.size.height)];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureBackgroundView];
    [self configureContainerView];
    [self configureLabels];
    [self configureContentView];
    [self configureButtonsView];
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

#pragma mark - Content View

- (UIView*)contentView
{
    if(!_contentView) {
        _contentView = [UIView newForAutolayoutAndAddToView:verticallyCenteredContainer];
    }
    return _contentView;
}

- (void)configureContentView
{
    if(_contentViewHeight <= 0) {
        return;
    }
    
    if(!_contentView) {
        _contentView = [UIView newForAutolayoutAndAddToView:verticallyCenteredContainer];
    }
    
    if(!_contentView.superview) {
        [verticallyCenteredContainer addSubview:_contentView];
    }
    
    [_contentView removeConstraints:_contentView.constraints];
    [self.view addConstraints:@[
        constraintWidth(_contentView, containerView, 0),
        constraintCenterX(_contentView, containerView),
        constraintHeight(_contentView, nil, _contentViewHeight),
        constraintBottom(_contentView, verticallyCenteredContainer, 0)
     ]];
}

static const CGFloat buttonHeight = 40;

- (void)configureConstraints
{
    [self.view addConstraints:
        constraintsEqualSizeAndPosition(backgroundView, self.view)
     ];
    
    [self.view addConstraints:@[
     constraintWidth(verticallyCenteredContainer, containerView, 0),
     constraintHeight(verticallyCenteredContainer, detailsLabel, _contentViewHeight),
     constraintCenterX(verticallyCenteredContainer, containerView),
     constraintCenterY(verticallyCenteredContainer, self.view)
     ]];
    
    if(_contentView)
        [self.view addConstraint:constraintBottom(_contentView, verticallyCenteredContainer, 0)];
    
    [self.view addConstraints:@[
        constraintCenterX(detailsLabel, self.view),
        constraintWidth(detailsLabel, containerView, -20),
        constraintTop(detailsLabel, verticallyCenteredContainer, 0),
     ]];
    
    [self.view addConstraints:@[
        constraintEqualAttributes(titleLabel, detailsLabel, NSLayoutAttributeBottom, NSLayoutAttributeTop, -4),
        constraintCenterX(titleLabel, self.view)
     ]];
    
    [self.view addConstraints:@[
        constraintCenterX(containerView, self.view),
        constraintWidth(containerView, self.view, -_horizontalMargin*2),
        constraintTop(containerView, titleLabel, -16),
        constraintBottom(containerView, buttonsView, 0)
     ]];
    
    [self.view addConstraints:constraintsEqualSizeAndPosition(containerBackground, containerView)];
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
    containerView.layer.cornerRadius = _isRounded ? 5.0 : 0.0;
    containerView.backgroundColor = [UIColor clearColor];
    containerView.clipsToBounds = YES;
    
    containerBackground = [UIView newForAutolayoutAndAddToView:containerView];
    containerBackground.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.95];
    
    verticallyCenteredContainer = [UIView newForAutolayoutAndAddToView:containerView];
}

- (void)configureLabels
{
//    titleLabel = [UILabel newForAutolayoutAndAddToView:containerView];
    [containerView addSubview:titleLabel];
    titleLabel.text = _alertTitle;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    titleLabel.backgroundColor = [UIColor clearColor];
    
//    detailsLabel = [UILabel newForAutolayoutAndAddToView:verticallyCenteredContainer];
    [verticallyCenteredContainer addSubview:detailsLabel];
    detailsLabel.text = _detailText;
    detailsLabel.textColor = [UIColor colorWithRed:0.137 green:0.141 blue:0.145 alpha:1];
    detailsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    detailsLabel.backgroundColor = [UIColor clearColor];
    detailsLabel.numberOfLines = 0;
    detailsLabel.textAlignment = NSTextAlignmentCenter;
    detailsLabel.preferredMaxLayoutWidth = self.view.bounds.size.width - 60;
    [detailsLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [detailsLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

#pragma mark - Buttons

- (void)configureButtonsView
{
    buttonsView = [UIView newForAutolayoutAndAddToView:containerView];
    [self.view addConstraints:@[
     constraintWidth(buttonsView, containerView, 0),
     constraintEqualAttributes(buttonsView, _contentView ?: detailsLabel, NSLayoutAttributeTop, NSLayoutAttributeBottom, 10),
     constraintCenterX(buttonsView, containerView),
     constraintAttributeWithPriority(buttonsView, nil, NSLayoutAttributeHeight, 0, UILayoutPriorityDefaultLow)
     ]];
}

- (void)addButtonWithTitle:(NSString*)title type:(MBFlatAlertButtonType)type action:(MBFlatAlertButtonAction)action
{
    MBFlatAlertButton *button = [MBFlatAlertButton buttonWithTitle:title type:type action:action];
  
    if(!buttons)
        buttons = [NSMutableArray new];
    
    [buttons addObject:button];
}

- (void)addButton:(MBFlatAlertButton*)button
{
    if(!buttons)
        buttons = [NSMutableArray new];
    
    [buttons addObject:button];
}

- (void)layoutButtons
{    
    [buttons enumerateObjectsUsingBlock:^(MBFlatAlertButton *button, NSUInteger idx, BOOL *stop) {
        if(!button.superview)
            [buttonsView addSubview:button];
        [self.view addConstraint:constraintEqualWithMultiplier(button, buttonsView, NSLayoutAttributeWidth, 0, 1.0/buttons.count)];
        [self.view addConstraint:constraintBottom(button, buttonsView, 0)];
        [self.view addConstraints:constraintsHeightGreaterThanOrEqual(buttonsView, button)];
        [self.view addConstraint:constraintHeight(button, buttonsView, 0)];

        if(idx > 0) {
            MBFlatAlertButton *previousButton = buttons[idx - 1];
            [self.view addConstraint:constraintEqualAttributes(button, previousButton, NSLayoutAttributeLeft, NSLayoutAttributeRight, 0)];
        } else {
            [self.view addConstraint:constraintLeft(button, buttonsView, 0)];
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
    if(_dismissesOnButtonPress)
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
    
    [containerView.layer addAnimation:[self.class flatDismissAnimation] forKey:@"anim"];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self performSelector:@selector(removeAlertFromView)];
    });
}

#define scale(x, y, z) [NSValue valueWithCATransform3D:CATransform3DMakeScale(x, y, z)]

+ (CAAnimation*)flatDismissAnimation
{
    NSArray *frameValues = @[scale(1.0, 1.0, 1.0), scale(0.7, 0.7, 0.7)];
    NSArray *frameTimes = @[@(0.0), @(1.0)];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.20;
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
    alert.isRounded = YES;
    alert.detailText = detailText;
    if(cancelTitle)
        [alert addButtonWithTitle:cancelTitle type:MBFlatAlertButtonTypeBold action:cancelBlock];
    return alert;
}

@end
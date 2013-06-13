//
//  MBFlatAlertButton.m
//  Freebie
//
//  Created by Mo Bitar on 6/12/13.
//  Copyright (c) 2013 Ora Interactive. All rights reserved.
//

#import "MBFlatAlertButton.h"

@implementation MBFlatAlertButton

- (UIFont*)textFont
{
    if(_type == MBFlatAlertButtonTypeNormal)
        return [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    else return [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    self.highlighted ? [[UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1] setFill]: [[UIColor clearColor] setFill];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillRect(context, rect);
    
    UIFont *font = [self textFont];
    CGSize size = [_title sizeWithFont:font];
    [[UIColor colorWithRed:0.000 green:0.471 blue:0.965 alpha:1] set];
    [_title drawInRect:CGRectMake(rect.size.width/2.0 - size.width/2.0, rect.size.height/2.0 - size.height/2.0, size.width, size.height) withFont:font];
    
    CGFloat const strokeSize = 0.75;
    // draw top stroke
    UIBezierPath *top = [UIBezierPath bezierPathWithRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, strokeSize)];
    [[UIColor colorWithRed:0.757 green:0.773 blue:0.776 alpha:1] setFill];
    [top fill];
    
    if(_hasRightStroke) {
    // draw right stroke
        UIBezierPath *right = [UIBezierPath bezierPathWithRect:CGRectMake(rect.origin.x + rect.size.width - strokeSize, rect.origin.y, strokeSize, rect.size.height)];
        [[UIColor colorWithRed:0.757 green:0.773 blue:0.776 alpha:1] setFill];
        [right fill];
    }
}

@end

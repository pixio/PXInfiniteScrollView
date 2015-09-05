//
//  PXView.m
//  PXInfiniteScrollView
//
//  Created by Calvin Kern on 6/9/15.
//  Copyright (c) 2015 Daniel Blakemore. All rights reserved.
//

#import "PXView.h"

#import <PXInfiniteScrollView/PXInfiniteScrollView.h>

@implementation PXView
{
    NSMutableArray* _constraints;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self == nil) {
        return nil;
    }
    
    _constraints = [NSMutableArray array];
    
    _bodyScrollView = [[PXInfiniteScrollView alloc] init];
    [_bodyScrollView setTranslatesAutoresizingMaskIntoConstraints:FALSE];
    [_bodyScrollView setScrollDirection:PXInfiniteScrollViewDirectionHorizontal];
    [self addSubview:_bodyScrollView];

    _faceScrollView = [[PXInfiniteScrollView alloc] init];
    [_faceScrollView setTranslatesAutoresizingMaskIntoConstraints:FALSE];
    [_faceScrollView setScrollDirection:PXInfiniteScrollViewDirectionHorizontal];
    [self addSubview:_faceScrollView];

    [self setNeedsUpdateConstraints];
    
    return self;
}

- (void)updateConstraints
{
    [self removeConstraints:_constraints];

    NSDictionary* views = NSDictionaryOfVariableBindings(_faceScrollView, _bodyScrollView);
    NSDictionary* metrics = @{@"sp":@153, @"fh":@78};
    
    // Horizontal
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bodyScrollView]|" options:0 metrics:metrics views:views]];
    
    // Vertical
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-sp-[_faceScrollView(fh)]" options:0 metrics:metrics views:views]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_bodyScrollView]|" options:0 metrics:metrics views:views]];

    [_constraints addObject:[NSLayoutConstraint constraintWithItem:_faceScrollView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_faceScrollView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    [_constraints addObject:[NSLayoutConstraint constraintWithItem:_faceScrollView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.055 constant:0.0]];

    [self addConstraints:_constraints];
    [super updateConstraints];
}

@end

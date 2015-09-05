//
//  PXView.h
//  PXInfiniteScrollView
//
//  Created by Calvin Kern on 6/9/15.
//  Copyright (c) 2015 Daniel Blakemore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PXInfiniteScrollView/PXInfiniteScrollView.h>

@interface PXView : UIView

@property (nonatomic, readonly) PXInfiniteScrollView* faceScrollView;
@property (nonatomic, readonly) PXInfiniteScrollView* bodyScrollView;

@end

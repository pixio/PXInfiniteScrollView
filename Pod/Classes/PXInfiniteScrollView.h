//
//  PXInfiniteScrollView.h
//  PXAdditions
//
//  Created by Kevin Wong on 12/29/13.
//
//  Copyright (c) 2015 Pixio
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PXInfiniteScrollViewDirection) {
    PXInfiniteScrollViewDirectionHorizontal = 0,
    PXInfiniteScrollViewDirectionVertical,
};

@interface PXInfiniteScrollView : UIScrollView

/**
 *  An array of UIView objects that are paged.
 */
@property (nonatomic, copy, nullable) NSArray* pages;
@property (nonatomic, readonly) NSUInteger pageCount;

/**
 *  The direction of for which scrolling will occur
 */
@property (nonatomic) PXInfiniteScrollViewDirection scrollDirection;

/**
 *  The page index of the page currently being displayed
 */
@property (nonatomic) NSInteger currentPage;
- (void) setCurrentPage:(NSInteger)page animated:(BOOL)animated;

/**
 *  The view that corresponds to the currentPage index
 *
 *  @return UIView currently displayed
 */
- (UIView* _Nullable) currentPageView;

@end

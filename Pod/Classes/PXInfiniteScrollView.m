//
//  PXInfiniteScrollView.m
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

#import "PXInfiniteScrollView.h"


//! Safe mod which ensures that the modulus is positive
static inline NSInteger posMod(NSInteger numerator, NSInteger denominator)
{
    NSInteger value = numerator % denominator;
    if (value < 0)
    {
        value += denominator;
    }
    
    return value;
}


@interface PXInfiniteScrollView ()

//! Number of pages that should be added on each side of the content for better scrolling behavior
@property (nonatomic, assign) NSInteger buffer;

@end

@implementation PXInfiniteScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self == nil)
        return nil;

    // Enable paging and disable scrolling (scrolling is enabled if more than one page is set)
    [super setPagingEnabled:TRUE];
    [super setScrollEnabled:FALSE];

    [self setBounces:FALSE];
    [self setShowsHorizontalScrollIndicator:FALSE];
    [self setShowsVerticalScrollIndicator:FALSE];
    [self setDecelerationRate:UIScrollViewDecelerationRateFast];
    
    _scrollDirection = PXInfiniteScrollViewDirectionHorizontal;
    _buffer = 5;

    return self;
}

#pragma mark PXInfiniteScrollView methods

- (void) setPages:(NSArray*)pages
{
    for (UIView* view in _pages)
    {
        [view removeFromSuperview];
    }

    _pages = [pages copy];

    for (UIView* view in _pages)
    {
        [view removeFromSuperview];
        [self addSubview:view];
    }

    [self layoutPages];
}

- (void) setScrollDirection:(PXInfiniteScrollViewDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    [self layoutPages];
}

- (void) layoutPages
{
    CGRect frame = [self bounds];
    frame.origin = CGPointZero;
    
    CGFloat pageSize = [self pageSize];
    UIOffset offset = UIOffsetMake(frame.size.width, frame.size.height);

    NSInteger count = [self pageCount];
    [super setScrollEnabled:(count > 1)];

    // Set the content size
    if (_scrollDirection == PXInfiniteScrollViewDirectionHorizontal)
    {
        [self setContentSize:CGSizeMake(frame.size.width * (count + _buffer * 2), frame.size.height)];
        offset.vertical = 0.0f;
        frame.origin.x = _buffer * pageSize;
    }
    else
    {
        [self setContentSize:CGSizeMake(frame.size.width, frame.size.height * (count + _buffer * 2))];
        offset.horizontal = 0.0f;
        frame.origin.y = _buffer * pageSize;
    }

    // Set frames for each page view
    for (UIView* view in _pages)
    {
        [view setFrame:CGRectIntegral(frame)];
        frame = CGRectOffset(frame, offset.horizontal, offset.vertical);
    }

    [self setCurrentPage:0];
}

- (NSInteger) currentPage
{
    NSInteger pageSize = (NSInteger) [self pageSize];
    NSInteger pageCount = [_pages count];

    if (pageSize == 0 || pageCount == 0)
    {
        return 0;
    }

    // Unadjust the offset
    NSInteger offset = (NSInteger) [self offset];
    offset = posMod(offset - pageSize * _buffer, pageCount * pageSize);

    // Determine the center point of the page
    NSInteger center = offset + pageSize / 2;

    return posMod(center / pageSize, pageCount);
}

- (void) setCurrentPage:(NSInteger)currentPage
{
    [self setCurrentPage:currentPage animated:FALSE];
}

- (void) setCurrentPage:(NSInteger)page animated:(BOOL)animated
{
    CGFloat pageSize = (_scrollDirection == PXInfiniteScrollViewDirectionHorizontal) ? [self bounds].size.width : [self bounds].size.height;
    NSInteger currentPage = [self currentPage];

    // adjust the page so that is no more than pageCount from the current page
    if (pageSize <= 0.0f || [_pages count] == 0)
    {
        page = 0;
    }
    else
    {
        NSInteger pageDifference = page - currentPage;
        page -= posMod(pageDifference - pageDifference, (NSInteger)[_pages count]);
    }

    CGFloat oldOffset = pageSize * currentPage + pageSize * _buffer;
    CGFloat offset = pageSize * page + pageSize * _buffer;


    if (_scrollDirection == PXInfiniteScrollViewDirectionHorizontal)
    {
        if (animated == TRUE)
        {
            [self setContentOffset:CGPointMake(oldOffset, 0.0f) animated:FALSE];
        }
        [self setContentOffset:CGPointMake(offset, 0.0f) animated:animated];
    }
    else
    {
        if (animated == TRUE)
        {
            [self setContentOffset:CGPointMake(0.0f, oldOffset) animated:FALSE];
        }
        [self setContentOffset:CGPointMake(0.0f, offset) animated:animated];
    }
}

- (UIView*) currentPageView
{
    if ([self pageCount] > 0)
    {
        return _pages[[self currentPage]];
    }
    else
    {
        return nil;
    }
}

#pragma mark UIScrollView methods

- (void) setContentOffset:(CGPoint)contentOffset
{
    NSInteger pageCount = [_pages count];

    // Don't bother adjusting frames or the offset if there are no pages
    if (pageCount <= 1)
    {
        [super setContentOffset:contentOffset];
        return;
    }
    
    BOOL horizontal = (_scrollDirection == PXInfiniteScrollViewDirectionHorizontal);
    CGFloat pageSize = [self pageSize];
    
    
    CGFloat currentOffset = horizontal ? contentOffset.x : contentOffset.y;

    // Whether or not the content offset should 'jump'. This works great when physicially dragging,
    // but can problematic when jumping a large distance programatically
    BOOL adjustContentOffset =
        ([self isTracking] && [self isDragging] && ![self isDecelerating]) || // Touching and not decelerating
        (![self isTracking] && ![self isDragging] && ![self isDecelerating]); // Not touching and not decelerating
    
    // Adjust the content offset so that it within the area that it should be
    if (adjustContentOffset)
    {
        CGFloat firstPageOffset = _buffer * pageSize;
        currentOffset = firstPageOffset + fmod(currentOffset - firstPageOffset, pageSize * pageCount);
        if (horizontal)
        {
            contentOffset.x = currentOffset;
        }
        else
        {
            contentOffset.y = currentOffset;
        }
    }

    // Get the page indices of the two views that should be visible.
    NSInteger leftPageIndex = (NSInteger) floor(currentOffset / pageSize);
    NSInteger viewIndex = posMod(leftPageIndex - _buffer, pageCount);
    NSInteger nextViewIndex = posMod(viewIndex + 1, pageCount);

    
    // Adjust the page view frames so they appear seamless
    CGRect frame = CGRectZero;
    frame.size = [self bounds].size;

    if (horizontal)
    {
        [_pages[nextViewIndex] setFrame:CGRectIntegral(CGRectOffset(frame, (leftPageIndex + 1) * pageSize, 0.0f))];
        [_pages[viewIndex] setFrame:CGRectIntegral(CGRectOffset(frame, leftPageIndex * pageSize, 0.0f))];
    }
    else
    {
        [_pages[nextViewIndex] setFrame:CGRectIntegral(CGRectOffset(frame, 0.0f, (leftPageIndex + 1) * pageSize))];
        [_pages[viewIndex] setFrame:CGRectIntegral(CGRectOffset(frame, 0.0f, leftPageIndex * pageSize))];
    }


    [super setContentOffset:contentOffset];
}

- (void) setScrollEnabled:(BOOL)scrollEnabled
{
    // NOP
}

- (void) setPagingEnabled:(BOOL)pagingEnabled
{
    // NOP
}

- (void) setFrame:(CGRect)frame
{
    CGRect oldFrame = [self frame];
    NSInteger oldPage = [self currentPage];

    [super setFrame:frame];

    if (CGSizeEqualToSize(frame.size, oldFrame.size))
    {
        return;
    }

    // Layout pages if necessary
    [self layoutPages];
    [self setCurrentPage:oldPage];
}

- (void) setBounds:(CGRect)bounds
{
    CGRect oldBounds = [self bounds];
    NSInteger oldPage = [self currentPage];

    [super setBounds:bounds];

    if (CGSizeEqualToSize(bounds.size, oldBounds.size))
    {
        return;
    }

    // Layout pages if necessary
    [self layoutPages];
    [self setCurrentPage:oldPage];
}

#pragma mark - Helper methods

- (NSUInteger) pageCount
{
    return [_pages count];
}

- (CGFloat) offset
{
    return ((_scrollDirection == PXInfiniteScrollViewDirectionHorizontal) ? [self contentOffset].x : [self contentOffset].y);
}

- (CGFloat) pageSize
{
    return ((_scrollDirection == PXInfiniteScrollViewDirectionHorizontal) ? [self bounds].size.width : [self bounds].size.height);
}

@end

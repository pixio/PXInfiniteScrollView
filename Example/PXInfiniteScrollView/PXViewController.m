//
//  PXViewController.m
//  PXInfiniteScrollView
//
//  Created by Daniel Blakemore on 05/01/2015.
//  Copyright (c) 2014 Daniel Blakemore. All rights reserved.
//

#import "PXViewController.h"
#import "PXView.h"

#import <PXInfiniteScrollView/PXInfiniteScrollView.h>

@interface PXViewController ()

@end

@implementation PXViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (PXView*)contentView
{
    return (PXView*)[self view];
}

- (void)loadView
{
    [self setView:[[PXView alloc] init]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setTitle:@"PX Infinite Scroll View"];
    
    [[self view] setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    [[[self navigationController] navigationBar] setBarTintColor:[UIColor orangeColor]];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    NSArray* faces = @[@"andres", @"andrew", @"ben", @"calvin", @"daniel", @"dillon", @"hunsaker", @"julie", @"jun", @"kevin", @"lorenzo", @"matt", @"seth", @"spencer", @"victor", @"william"];
    
    NSArray* animals = @[@"big bird", @"bear", @"bugs bunny", @"cat", @"cow", @"duck", @"giraffe", @"gorilla", @"jumping lemur", @"lemur", @"lion", @"penguin", @"sloth", @"wolf", @"as it is"];
    
    // Create the array of views for the scroll views
    NSMutableArray* faceViews = [NSMutableArray array];
    for (NSString* face in faces) {
        UIImageView* imageView = [[UIImageView alloc] init];
        [imageView setImage:[UIImage imageNamed:face]];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [faceViews addObject:imageView];
    }
    
    NSMutableArray* animalViews = [NSMutableArray array];
    for (NSString* animal in animals) {
        UIImageView* imageView = [[UIImageView alloc] init];
        [imageView setImage:[UIImage imageNamed:animal]];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [animalViews addObject:imageView];
    }

    [[[self contentView] faceScrollView] setPages:faceViews];
    [[[self contentView] bodyScrollView] setPages:animalViews];
}

@end

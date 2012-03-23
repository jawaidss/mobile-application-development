//
//  TVSModelController.h
//  TV Shows
//
//  Created by  on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TVSDataViewController;

@interface TVSModelController : NSObject <UIPageViewControllerDataSource>

- (TVSDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(TVSDataViewController *)viewController;

@end

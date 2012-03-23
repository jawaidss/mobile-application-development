//
//  TVMasterViewController.h
//  TVShows
//
//  Created by  on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TVDetailViewController;

@interface TVMasterViewController : UITableViewController

@property (strong, nonatomic) TVDetailViewController *detailViewController;

@end

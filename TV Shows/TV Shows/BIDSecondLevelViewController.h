//
//  BIDSecondLevelViewController.h
//  TV Shows
//
//  Created by  on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDSecondLevelViewController : UITableViewController
@property (strong, nonatomic) NSString *showID;
@property (strong, nonatomic) NSDictionary *names;
@property (strong, nonatomic) NSArray *keys;
@end

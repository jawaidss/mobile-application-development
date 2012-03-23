//
//  BIDFirstLevelController.m
//  TV Shows
//
//  Created by  on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BIDFirstLevelController.h"
#import "BIDSecondLevelViewController.h"

@interface BIDFirstLevelController ()

@end

@implementation BIDFirstLevelController

@synthesize names;
@synthesize keys;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.title = @"TV Shows";

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSString *csv = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://epguides.com/common/allshows.txt"]];
    NSArray *lines = [csv componentsSeparatedByString: @"\n"];
    lines = [lines subarrayWithRange:NSMakeRange(1, [lines count] - 1)];
    for (NSString *line in lines) {
        NSString *trimmedLine = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([trimmedLine length] > 0) {
            NSArray *values = [trimmedLine componentsSeparatedByString:@"\","];
            NSString *showName = [values objectAtIndex:0];
            showName = [showName substringWithRange:NSMakeRange(1, [showName length] - 1)];
            NSString *showID = [values objectAtIndex:1];
            values = [showID componentsSeparatedByString:@","];
            showID = [values objectAtIndex:1];

            //NSDictionary *show = [NSDictionary dictionaryWithObjectsAndKeys:showName, @"showName", showID, @"showID", nil];

            BIDSecondLevelViewController *show = [[BIDSecondLevelViewController alloc] initWithStyle:UITableViewStylePlain];
            show.title = showName;
            show.showID = showID;
            
            NSString *firstLetter = [showName substringToIndex:1];
            NSMutableArray *temp = [dict objectForKey:firstLetter];
            if (temp) {
                [temp addObject:show];
                [dict setObject:temp forKey:firstLetter];
            } else {
                NSMutableArray *shows = [[NSMutableArray alloc] init];
                [shows addObject:show];
                [dict setObject:shows forKey:firstLetter];
            }
        }
    }
    self.names = dict;
    self.keys = [[names allKeys] sortedArrayUsingSelector:@selector(compare:)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

    self.names = nil;
    self.keys = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [keys objectAtIndex:section];
    NSArray *nameSection = [names objectForKey:key];
    return [nameSection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    NSString *key = [keys objectAtIndex:section];
    NSArray *nameSection = [names objectForKey:key];
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionsTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SectionsTableIdentifier];
    }
    BIDSecondLevelViewController *show = [nameSection objectAtIndex:row];
    cell.textLabel.text = show.title;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [keys objectAtIndex:section];
    return key;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return keys;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    NSString *key = [keys objectAtIndex:section];
    NSArray *nameSection = [names objectForKey:key];
    BIDSecondLevelViewController *nextController = [nameSection objectAtIndex:row];
    if ([nextController.showID length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nextController.title
                                                        message:@"Error: no show ID"
                                                       delegate:nil
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        [alert show];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    } else {
        [self.navigationController pushViewController:nextController animated:YES];
    }
}

@end

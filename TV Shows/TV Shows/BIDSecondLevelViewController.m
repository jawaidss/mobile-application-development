//
//  BIDSecondLevelViewController.m
//  TV Shows
//
//  Created by  on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BIDSecondLevelViewController.h"
#import "BIDAppDelegate.h"

@interface BIDSecondLevelViewController ()

@end

@implementation BIDSecondLevelViewController

@synthesize showID;
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

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSString *url = [NSString stringWithFormat:@"http://epguides.com/common/exportToCSV.asp?rage=%@", self.showID];
    NSString *csv = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    NSArray *lines = [csv componentsSeparatedByString: @"\n"];
    for (int i = 8; i < [lines count] - 4; i++) {
        NSString *line = [lines objectAtIndex:i];
        NSArray *values = [line componentsSeparatedByString:@"\""];
        NSArray *seasonEpisode = [[values objectAtIndex:0] componentsSeparatedByString:@","];
        NSString *season = [seasonEpisode objectAtIndex:1];
        NSString *episode = [seasonEpisode objectAtIndex:2];
        NSString *airdate = [[values objectAtIndex:2] stringByReplacingOccurrencesOfString:@"," withString:@""];
        NSString *title = [values objectAtIndex:3];
        NSDictionary *episodeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                     season, @"season",
                                     episode, @"episode",
                                     airdate, @"airdate",
                                     title, @"title",
                                     nil];
        NSString *key = [NSString stringWithFormat:@"Season %@", season];
        NSMutableArray *temp = [dict objectForKey:key];
        if (temp) {
            [temp addObject:episodeDict];
            [dict setObject:temp forKey:key];
        } else {
            NSMutableArray *shows = [[NSMutableArray alloc] init];
            [shows addObject:episodeDict];
            [dict setObject:shows forKey:key];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SectionsTableIdentifier];
    }
    NSDictionary *showDict = [nameSection objectAtIndex:row];
    cell.textLabel.text = [showDict objectForKey:@"title"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Episode %@: %@",
                                 [showDict objectForKey:@"episode"],
                                 [showDict objectForKey:@"airdate"]];
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
    NSDictionary *showDict = [nameSection objectAtIndex:row];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.title
                                                    message:[NSString stringWithFormat:@"%@\nSeason %@\nEpisode %@\n%@",
                                                             [showDict objectForKey:@"title"],
                                                             [showDict objectForKey:@"season"],
                                                             [showDict objectForKey:@"episode"],
                                                             [showDict objectForKey:@"airdate"]]
                                                   delegate:nil
                                          cancelButtonTitle:@"Okay"
                                          otherButtonTitles:nil];
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

//
//  BIDViewController.m
//  Simple Table
//
//  Created by  on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BIDViewController.h"

@interface BIDViewController ()

@end

@implementation BIDViewController
@synthesize names;
@synthesize keys;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
            NSDictionary *show = [NSDictionary dictionaryWithObjectsAndKeys:showName, @"showName", showID, @"showID", nil];
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
    NSArray *array = [[names allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.keys = array;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.names = nil;
    self.keys = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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
    cell.textLabel.text = [[nameSection objectAtIndex:row] valueForKey:@"showName"];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [keys objectAtIndex:section];
    return key;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return keys;
}

@end
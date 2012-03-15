//
//  ColorsViewController.m
//  Colors
//
//  Created by  on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ColorsViewController.h"

@implementation ColorsViewController
@synthesize redSlider;
@synthesize greenSlider;
@synthesize blueSlider;
@synthesize rgbLabel;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setRedSlider:nil];
    [self setGreenSlider:nil];
    [self setBlueSlider:nil];
    //[self setRGB:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)changeColor:(id)sender {
    int redValue = redSlider.value;
    [[self redSlider] setValue:redValue animated:YES];
    int greenValue = greenSlider.value;
    [[self greenSlider] setValue:greenValue animated:YES];
    int blueValue = blueSlider.value;
    [[self blueSlider] setValue:blueValue animated:YES];
    self.view.backgroundColor = [UIColor colorWithRed:redValue/255.0 green:greenValue/255.0 blue:blueValue/255.0 alpha:1];
    [rgbLabel setText:[NSString stringWithFormat:@"(%d, %d, %d)", redValue, greenValue, blueValue]];
}
@end

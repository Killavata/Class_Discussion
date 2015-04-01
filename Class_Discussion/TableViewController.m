//
//  TableViewController.m
//  Class_Discussion
//
//  Created by Luke Bakker on 3/23/15.
//  Copyright (c) 2015 Stepan Severov. All rights reserved.
//

#import "TableViewController.h"



@interface TableViewController (){
NSDictionary *students;
NSArray *nameSectionTitles;
}

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    students = @{@"B" : @[@"bob", @"bill",@"brittany"],
               @"C" :@[@"colin",@"",@"chris",@"cooper"],
               @"D" : @[@"Doris"],
               @"F" : @[@"Fred", @"Francine",@"fsdf",@"Fadf"],
               @"G" : @[@"Golf"],
               @"H" : @[@"Hockey"],
               @"K" : @[@"Kickball"],
               @"L" : @[@"Lacrosse"],
               @"P" : @[@"Ping Pong", @"Paintball"],
               @"R" : @[@"Racquetball"],
               @"S" : @[@"Soccer",@"Swimming",@"Skiing",@"Softball",@"Surfing"],
               @"T" : @[@"Tennis",@"Track"],
               @"W" : @[@"Water Polo"]};
    
    nameSectionTitles = [[students allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getImageFilename:(NSString *)sport
{
    NSString *imageFilename = [[sport lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    imageFilename = [imageFilename stringByAppendingString:@".jpg"];
    
    return imageFilename;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [nameSectionTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [nameSectionTitles objectAtIndex:section];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *sectionTitle = [nameSectionTitles objectAtIndex:section];
    NSArray *sectionNames = [students objectForKey:sectionTitle];
    return [sectionNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *sectionTitle = [nameSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionName = [students objectForKey:sectionTitle];
    NSString *name = [sectionName objectAtIndex:indexPath.row];
    cell.textLabel.text = name;
    cell.imageView.image = [UIImage imageNamed:[self getImageFilename:name]];
    
    return cell;
    
}

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 if ([segue.identifier isEqualToString:@"showYoutube"]) {
 NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
 webViewController *wvc = segue.destinationViewController;
 wvc.sentString = [sportSectionTitles objectAtIndex:indexPath.row];
 }
 }*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *sectionTitle = [nameSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionNames = [students objectForKey:sectionTitle];
    NSString *rowValue =  [sectionNames objectAtIndex:indexPath.row];
    if ([rowValue isEqualToString:(@"Lacrosse")]){
        NSString *message= [[NSString alloc] initWithFormat:@"You Selected %@ ,Lacrosse is the offical sport of the empire. Often played by boys with hair like girls,they generally are academically inferior, and altogether inferior to baseball players",rowValue];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sport Selected!" message:message delegate:nil cancelButtonTitle:@"DONE" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        NSString *message= [[NSString alloc] initWithFormat:@"You Selected %@",rowValue];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Student Selected!" message:message delegate:nil cancelButtonTitle:@"DONE" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
@end

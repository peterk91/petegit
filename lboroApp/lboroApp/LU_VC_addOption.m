//
//  LU_VC_addOption.m
//  lboroApp
//
//  Created by Peter Krepa on 10/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "LU_VC_addOption.h"

@interface LU_VC_addOption ()

@end

@implementation LU_VC_addOption
//outlets
@synthesize addButton,theTableView,navBar,searchBar,alltableView;
//properties
@synthesize tableData, managedObjectContext, isFiltered, filteredTableData;
//passed properties
@synthesize addType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    //populates the array table data with all the societies, AU clubs or societies depeneding on what button was pressed aks what the string addType is
    searchBar.delegate = (id)self;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    managedObjectContext = appDelegate.managedObjectContext;
    NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity1 = [NSEntityDescription new];
    if ([addType isEqualToString:@"MOD"]){
        entity1 = [NSEntityDescription entityForName:@"Module" inManagedObjectContext:managedObjectContext];
        navBar.topItem.title = @"Add Module";
    }
    if ([addType isEqualToString:@"AU"]){
        entity1 = [NSEntityDescription entityForName:@"AUClub" inManagedObjectContext:managedObjectContext];
        navBar.topItem.title = @"Add AU Club";
    }
    if ([addType isEqualToString:@"SOC"]){
        entity1 = [NSEntityDescription entityForName:@"Society" inManagedObjectContext:managedObjectContext];
        navBar.topItem.title = @"Add Society";
    }
    [request1 setEntity:entity1];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request1 setSortDescriptors:sortDescriptors];
    NSError *error = nil;
    NSMutableArray *mutableFetchResults1 = [[managedObjectContext executeFetchRequest:request1 error:&error] mutableCopy];
    if (mutableFetchResults1 == nil) {
    }
    tableData = [NSMutableArray new];
    [tableData addObjectsFromArray:mutableFetchResults1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setAddButton:nil];
    [self setAlltableView:nil];
    [self setSearchBar:nil];
    [self setTheTableView:nil];
    [self setNavBar:nil];
    [super viewDidUnload];
}

//this adds the option to the users memberships
- (IBAction)addOption:(id)sender {
    NSIndexPath *current = [alltableView indexPathForSelectedRow];
    NSError *error = nil;
    //checks the type of membership and then finds out if the table has been filtered. this is done to ensure the correct row is selected from the array
    if ([addType isEqualToString:@"MOD"]){
        Module *currentChoice;
        //if the results are not filtered the current choice is obtained for the table data array otherwise it uses the filtered table data array
        if(!isFiltered)
            currentChoice = [tableData objectAtIndex:current.row];
        else
            currentChoice = [filteredTableData objectAtIndex:current.row];
        //chosen is set to 1 in the core data 
        [currentChoice setValue:@"1" forKey:@"chosen"];
        //this then calls a shared method which updates the online database
        [[sharedMethods alloc] updateUserMOD:currentChoice toDelete:NO];
    }
    //the same process is used for AU and societies
    if ([addType isEqualToString:@"AU"]){
        AUClub *currentChoice;
        if(!isFiltered)
            currentChoice = [tableData objectAtIndex:current.row];
        else
            currentChoice = [filteredTableData objectAtIndex:current.row];
        [currentChoice setValue:@"1" forKey:@"chosen"];
        [[sharedMethods alloc] updateUserAU:currentChoice toDelete:NO];
    }
    if ([addType isEqualToString:@"SOC"]){
        Society *currentChoice;
        if(!isFiltered)
            currentChoice = [tableData objectAtIndex:current.row];
        else
            currentChoice = [filteredTableData objectAtIndex:current.row];
        [currentChoice setValue:@"1" forKey:@"chosen"];
        [[sharedMethods alloc] updateUserSOC:currentChoice toDelete:NO];
    }
    //the core data is then saved
    if(![managedObjectContext save:&error])
        NSLog(@"data cannot be saved");
    [[sharedMethods alloc] getEventData];
    //the view is dimissed and the reload table notification is sent out
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:self];
    [self dismissModalViewControllerAnimated:YES];
}

//when cancel is pressed the view is dismissed
- (IBAction)cancelPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

//the following method allows the user to use a search bar to search through the table
-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text{
    if(text.length == 0){
        //if there is nothing in the search bar then there is no filter
        isFiltered = FALSE;
    }
    else{
        //when filtered all objects matching the string are put into a filtered table data array which is then used as the table source
        isFiltered = true;
        filteredTableData = [[NSMutableArray alloc] init];
        if ([addType isEqualToString:@"MOD"]){
            for (Module* option in tableData){
                NSRange nameRange = [option.title rangeOfString:text options:NSCaseInsensitiveSearch];
                NSRange nameRange2 = [option.moduleID rangeOfString:text options:NSCaseInsensitiveSearch];
                if((nameRange.location != NSNotFound) || (nameRange2.location != NSNotFound)){
                    [filteredTableData addObject:option];
                }
            }
        }
        if ([addType isEqualToString:@"AU"]){
            for (AUClub* option in tableData){
                NSRange nameRange = [option.title rangeOfString:text options:NSCaseInsensitiveSearch];
                if(nameRange.location != NSNotFound){
                    [filteredTableData addObject:option];
                }
            }
        }
        if ([addType isEqualToString:@"SOC"]){
            for (Society* option in tableData){
                NSRange nameRange = [option.title rangeOfString:text options:NSCaseInsensitiveSearch];
                if(nameRange.location != NSNotFound){
                    [filteredTableData addObject:option];
                }
            }
        }
    }
    //the table view is updated to reflect the filter options
    [theTableView reloadData];
}

//sets up the table
#pragma mark - Table view data source

//returns the number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//returns the number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rowCount;
    //ensures it uses the right array
    if(isFiltered)
        rowCount = [filteredTableData count];
    else
        rowCount = [tableData count];
    return rowCount;
}

//creates and returns each cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"optionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    static NSString *CellIdentifier2 = @"optionCell2";
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
    //creates cells using specific details from the membership type therefore the 3 way if is used
    if ([addType isEqualToString:@"MOD"]){
        Module *current;
        if(isFiltered)
            current = [filteredTableData objectAtIndex:indexPath.row];
        else
            current = [tableData objectAtIndex:indexPath.row];
        cell2.textLabel.text = current.title;
        cell2.detailTextLabel.text = current.moduleID;
    }
    if ([addType isEqualToString:@"AU"]){
        AUClub *current;
        if(isFiltered)
            current = [filteredTableData objectAtIndex:indexPath.row];
        else
            current = [tableData objectAtIndex:indexPath.row];
        cell.textLabel.text = current.title;
    }
    if ([addType isEqualToString:@"SOC"]){
        Society *current;
        if(isFiltered)
            current = [filteredTableData objectAtIndex:indexPath.row];
        else
            current = [tableData objectAtIndex:indexPath.row];
        
        cell.textLabel.text = current.title;
    }
    if ([addType isEqualToString:@"MOD"])
        return cell2;
    else
        return cell;
}

//when a row is selected the add button can be pressed
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    addButton.enabled = YES;
}
@end

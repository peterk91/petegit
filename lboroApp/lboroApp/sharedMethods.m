//
//  sharedMethods.m
//  lboroApp
//
//  Created by Peter Krepa on 09/04/2013.
//  Copyright (c) 2013 Peter Krepa. All rights reserved.
//

#import "sharedMethods.h"

@implementation sharedMethods

@synthesize formatterstring, elementRSS, newsDate, newsTitle, newsURL, newsInfo, newsContext, path;

-(NSMutableArray *)connectPHPurl:(NSURL*)phpURL variables:(NSArray*)variables
{
    NSMutableURLRequest *req = [
                                 NSMutableURLRequest requestWithURL:phpURL
                                 cachePolicy:NSURLRequestReloadIgnoringCacheData
                                 timeoutInterval:60
                                 ];
    
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSMutableString *xmlData = [NSMutableString new];
    [xmlData appendString:@"<Document>"];
    
    for(int x=0;x<[variables count];x++){
        NSString *variable = [NSString stringWithFormat:@"<elem%d>%@</elem%d>",x,[variables objectAtIndex:x],x];
        [xmlData appendString:variable];
    }
    
    [xmlData appendString:@"</Document>"];
    
    NSString *postData = [NSString stringWithFormat:@"xmlData=%@&",xmlData];
    NSString *length = [NSString stringWithFormat:@"%d", [postData length]];
    
    [req setValue:length forHTTPHeaderField:@"Content-Length"];
    [req setHTTPBody:[postData dataUsingEncoding:NSASCIIStringEncoding]];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:req returningResponse:&urlResponse error:&error];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    responseString=[responseString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n\r"] ];
    NSArray *resultsArray = [responseString componentsSeparatedByString:@"&$&"];
    NSMutableArray *resultsMutable = [resultsArray mutableCopy];
    [resultsMutable removeLastObject];
    return resultsMutable;
}

-(void)updateSQL:(NSString*)sqlStatment{
    NSURL *phpURL = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_updateDatabase.php"];
    NSMutableURLRequest *req = [
                                NSMutableURLRequest requestWithURL:phpURL
                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                                timeoutInterval:60
                                ];
    
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *postData = [NSString stringWithFormat:@"sqlStatement=%@&",sqlStatment];
    NSString *length = [NSString stringWithFormat:@"%d", [postData length]];
    
    [req setValue:length forHTTPHeaderField:@"Content-Length"];
    [req setHTTPBody:[postData dataUsingEncoding:NSASCIIStringEncoding]];
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error;
    [NSURLConnection sendSynchronousRequest:req returningResponse:&urlResponse error:&error];
}



-(void)getLabelData{

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    [self clearData:@"LabelEdition" hasPredicate:NO withPrediacteStr:@""];
    
    NSURL *url = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_getLabel.php"];
    
    NSArray *variables = [NSArray new];
    
    NSMutableArray *results = [self connectPHPurl:url variables:variables];
    
    for(int x=0; x<[results count];x++){
        NSArray *editionDetails = [[results objectAtIndex:x] componentsSeparatedByString:@"*$*"];
        LabelEdition *edition = (LabelEdition *)[NSEntityDescription insertNewObjectForEntityForName:@"LabelEdition" inManagedObjectContext:managedObjectContext];
        NSString *editionDate = [editionDetails objectAtIndex:0];
        [edition setTitle:editionDate];
        [edition setPicture:[editionDetails objectAtIndex:1]];
        [edition setUrl:[editionDetails objectAtIndex:2]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd'th' MMMM yyyy"];
        [edition setDate:[formatter dateFromString:editionDate]];
    }
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        // Handle the error.
    }
    
}

-(void)getTVData{

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;

    [self clearData:@"TVSegment" hasPredicate:NO withPrediacteStr:@""];
    
    NSURL *url = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_getTV.php"];
    
    NSArray *variables = [NSArray new];
    
    NSMutableArray *results = [self connectPHPurl:url variables:variables];
    
    for(int x=0; x<[results count];x++){
        NSArray *segmentDetails = [[results objectAtIndex:x] componentsSeparatedByString:@"*$*"];
        TVSegment *segment = (TVSegment *)[NSEntityDescription insertNewObjectForEntityForName:@"TVSegment" inManagedObjectContext:managedObjectContext];
        [segment setTitle:[segmentDetails objectAtIndex:0]];
        [segment setInfo:[segmentDetails objectAtIndex:1]];
        [segment setUrl:[segmentDetails objectAtIndex:2]];
    }
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        // Handle the error.
    }
    
}

-(void)getYearPeriodsData{

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;

    [self clearData:@"YearPeriods" hasPredicate:NO withPrediacteStr:@""];
    
    NSURL *url = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_getYearData.php"];
    
    NSArray *variables = [NSArray new];
    
    NSMutableArray *results = [self connectPHPurl:url variables:variables];
    
    for(int x=0; x<[results count];x++){
        NSArray *periodDetails = [[results objectAtIndex:x] componentsSeparatedByString:@"*$*"];
        YearPeriods *period = (YearPeriods *)[NSEntityDescription insertNewObjectForEntityForName:@"YearPeriods" inManagedObjectContext:managedObjectContext];
        [period setWeek:[periodDetails objectAtIndex:0]];
        [period setSemester:[periodDetails objectAtIndex:1]];
        [period setPeriodID:[periodDetails objectAtIndex:2]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *startDate = [formatter dateFromString:[periodDetails objectAtIndex:3]];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *endDate = [formatter dateFromString:[periodDetails objectAtIndex:4]];
        [period setStartdate:startDate];
        [period setEnddate:endDate];
        if([[periodDetails objectAtIndex:1]isEqualToString:@"0"]){
            Event *newEvent = (Event *)[NSEntityDescription insertNewObjectForEntityForName:@"Event"inManagedObjectContext:managedObjectContext];
            [newEvent setName:[periodDetails objectAtIndex:0]];
            [newEvent setType:@"HOL"];
            [newEvent setStarttime:startDate];
            [newEvent setEndtime:endDate];
            [newEvent setChosen:@"1"];
            [newEvent setWeek:@"1"];
        }
    }
    
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        // Handle the error.
    }
    
}

-(void)getLocations{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    [self clearData:@"Building" hasPredicate:NO withPrediacteStr:@""];
    [self clearData:@"Room" hasPredicate:NO withPrediacteStr:@""];
    
    NSURL *url = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_getBuildings.php"];
    
    NSArray *variables = [NSArray new];
    
    NSMutableArray *results = [self connectPHPurl:url variables:variables];
    
    NSURL *url2 = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_getRooms.php"];
    
    NSMutableArray *results2 = [self connectPHPurl:url2 variables:variables];
    
    for(int x=0; x<[results count];x++){
        NSArray *buildingDetails = [[results objectAtIndex:x] componentsSeparatedByString:@"*$*"];
        Building *building = (Building *)[NSEntityDescription insertNewObjectForEntityForName:@"Building" inManagedObjectContext:managedObjectContext];
        [building setBuildingid:[buildingDetails objectAtIndex:0]];
        [building setName:[buildingDetails objectAtIndex:1]];
        
    }
    
    for(int x=0; x<[results2 count];x++){
        NSArray *roomDetails = [[results2 objectAtIndex:x] componentsSeparatedByString:@"*$*"];
        Room *room = (Room *)[NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:managedObjectContext];
        [room setBuildingid:[roomDetails objectAtIndex:0]];
        [room setName:[roomDetails objectAtIndex:1]];
        [room setRoomid:[roomDetails objectAtIndex:2]];
    }

    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        // Handle the error.
    }
    
}

-(void)clearData:(NSString*)entity hasPredicate:(BOOL)hasPred withPrediacteStr:(NSString*)predicateStr{

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    NSError *error = nil;
    
    NSFetchRequest *allEntities = [[NSFetchRequest alloc] init];
    [allEntities setEntity:[NSEntityDescription entityForName:entity inManagedObjectContext:managedObjectContext]];
    [allEntities setIncludesPropertyValues:NO];
    if(hasPred){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateStr];
        [allEntities setPredicate:predicate];}
    
    
    NSArray *allEntitiesArray = [managedObjectContext executeFetchRequest:allEntities error:&error];
    for (NSManagedObject *entity in allEntitiesArray) {
        [managedObjectContext deleteObject:entity];
    }
    NSError *saveError = nil;
    [managedObjectContext save:&saveError]; 
    
}



-(void)getAllOptions{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    [self clearData:@"Module" hasPredicate:NO withPrediacteStr:@""];
    [self clearData:@"AUClub" hasPredicate:NO withPrediacteStr:@""];
    [self clearData:@"Society" hasPredicate:NO withPrediacteStr:@""];
    
    NSURL *urlMOD = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_getAllMOD.php"];
    NSURL *urlAU = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_getAllAU.php"];
    NSURL *urlSOC = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_getAllSOC.php"];
    NSUserDefaults *currentUserDefaults =[NSUserDefaults standardUserDefaults];
    NSString *userid = [currentUserDefaults stringForKey:@"userid"];
    NSArray *variables = [NSArray arrayWithObjects: userid, nil];
    
    NSMutableArray *resultsMOD = [self connectPHPurl:urlMOD variables:variables];
    NSMutableArray *resultsAU = [self connectPHPurl:urlAU variables:variables];
    NSMutableArray *resultsSOC = [self connectPHPurl:urlSOC variables:variables];
    
    for(int x=0; x<[resultsMOD count];x++){
        NSArray *moduleDetails = [[resultsMOD objectAtIndex:x] componentsSeparatedByString:@"*$*"];
        Module *module = (Module *)[NSEntityDescription insertNewObjectForEntityForName:@"Module" inManagedObjectContext:managedObjectContext];
        [module setTitle:[moduleDetails objectAtIndex:0]];
        [module setModuleID:[moduleDetails objectAtIndex:1]];
        [module setDatabaseID:[moduleDetails objectAtIndex:2]];
        [module setChosen:[moduleDetails objectAtIndex:3]];
    }
    
    for(int x=0; x<[resultsAU count];x++){
        NSArray *auclubDetails = [[resultsAU objectAtIndex:x] componentsSeparatedByString:@"*$*"];
        AUClub *auclub = (AUClub *)[NSEntityDescription insertNewObjectForEntityForName:@"AUClub" inManagedObjectContext:managedObjectContext];
        [auclub setTitle:[auclubDetails objectAtIndex:0]];
        [auclub setDatabaseID:[auclubDetails objectAtIndex:1]];
        [auclub setChosen:[auclubDetails objectAtIndex:2]];
    }
    
    for(int x=0; x<[resultsSOC count];x++){
        NSArray *societyDetails = [[resultsSOC objectAtIndex:x] componentsSeparatedByString:@"*$*"];
        Society *society = (Society *)[NSEntityDescription insertNewObjectForEntityForName:@"Society" inManagedObjectContext:managedObjectContext];
        [society setTitle:[societyDetails objectAtIndex:0]];
        [society setDatabaseID:[societyDetails objectAtIndex:1]];
        [society setChosen:[societyDetails objectAtIndex:2]];
    }
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        // Handle the error.
    }
}
-(void)getEventData{
    NSLog(@"GET EVENT DATA");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    [self clearData:@"Event" hasPredicate:YES withPrediacteStr:@"(type LIKE 'MOD')OR(type LIKE 'SOC')OR(type LIKE 'AU')"];
    NSError *error = nil;
    NSURL *url = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_getAllEvents.php"];
    NSUserDefaults *currentUserDefaults =[NSUserDefaults standardUserDefaults];
    NSString *userid = [currentUserDefaults stringForKey:@"userid"];
    
    NSArray *variables = [NSArray arrayWithObjects: userid, nil];
    
    NSMutableArray *results = [self connectPHPurl:url variables:variables];
    for(int x=0; x<[results count];x++){
        
        NSArray *eventDetails = [[results objectAtIndex:x] componentsSeparatedByString:@"*$*"];
        Event *newEvent = (Event *)[NSEntityDescription insertNewObjectForEntityForName:@"Event"inManagedObjectContext:managedObjectContext];
        NSString *type = [eventDetails objectAtIndex:8];
        [newEvent setName:[eventDetails objectAtIndex:4]];
        [newEvent setDatabaseID:[eventDetails objectAtIndex:5]];
        [newEvent setRoom:[eventDetails objectAtIndex:6]];
        [newEvent setBuilding:[eventDetails objectAtIndex:7]];
        [newEvent setEventid:[eventDetails objectAtIndex:10]];
        [newEvent setInfo:[eventDetails objectAtIndex:11]];
        [newEvent setChosen:[eventDetails objectAtIndex:12]];
        [newEvent setType:type];
        
        if([type isEqualToString:@"MOD"]){
            
            NSString *periodIDPredicate =[NSString stringWithFormat:@"periodID LIKE '%@'",[eventDetails objectAtIndex:3]];
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"YearPeriods" inManagedObjectContext:managedObjectContext];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:periodIDPredicate];
            [request setEntity:entity];
            [request setPredicate:predicate];
            
            NSError *error = nil;
            
            NSMutableArray *yearPeriods = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
            if (yearPeriods == nil) {
                // Handle the error.
            }
            YearPeriods *currentPeriod = [yearPeriods objectAtIndex:0];
            
            NSDate *periodStartDate = currentPeriod.startdate;
                
            [newEvent setDay:[eventDetails objectAtIndex:2]];
            [newEvent setPeriodID:[eventDetails objectAtIndex:3]];
            [newEvent setWeek:[eventDetails objectAtIndex:9]];
            
            NSInteger dayNumber = [[eventDetails objectAtIndex:2] intValue]-1;

            NSDate *currentStartDate = [periodStartDate dateByAddingTimeInterval:60*60*24*dayNumber];
            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
            [formatter2 setDateFormat:@"yyyy-MM-dd"];
            NSString *currentStartString = [formatter2 stringFromDate:currentStartDate];

            NSString *startString = [NSString stringWithFormat:@"%@ %@",currentStartString, [eventDetails objectAtIndex:0]];
            NSString *endString = [NSString stringWithFormat:@"%@ %@",currentStartString,[eventDetails objectAtIndex:1]];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *startDate = [formatter dateFromString:startString];
            NSDate *endDate = [formatter dateFromString:endString];
            [newEvent setStarttime:startDate];
            [newEvent setEndtime:endDate];
            [newEvent setStartPeriod:[eventDetails objectAtIndex:13]];
            [newEvent setPeriodLength:[eventDetails objectAtIndex:14]];
        }
        else{
            
            NSString *startString = [NSString stringWithFormat:@"%@",[eventDetails objectAtIndex:0]];
            NSString *endString = [NSString stringWithFormat:@"%@",[eventDetails objectAtIndex:1]];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *startDate = [formatter dateFromString:startString];
            NSDate *endDate = [formatter dateFromString:endString];
            [newEvent setStarttime:startDate];
            [newEvent setEndtime:endDate];
            
            NSString *startStr = [[startString componentsSeparatedByString:@" "] objectAtIndex:0];
            NSString *startDayStr = [[startStr componentsSeparatedByString:@"-"] objectAtIndex:2];
            NSString *endStr = [[endString componentsSeparatedByString:@" "] objectAtIndex:0];
            NSString *endDayStr = [[endStr componentsSeparatedByString:@"-"] objectAtIndex:2];
            if([startDayStr isEqualToString:endDayStr]){
                [newEvent setWeek:@"0"];
            }
            else{
                [newEvent setWeek:@"1"];
            }
        
        }
    }

    if (![managedObjectContext save:&error]) {
       
    }
}

-(void)updateUserMOD:(Module*)module toDelete:(BOOL)del{

    NSUserDefaults *currentUserDefaults =[NSUserDefaults standardUserDefaults];
    NSString *userid = [currentUserDefaults stringForKey:@"userid"];
    
    if(del){
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM app_module_event_student WHERE userid = '%@' AND modeventid IN (SELECT modeventid FROM app_module_event WHERE moduleid = '%@')", userid, module.databaseID];
        [self updateSQL:sql];
        
        NSString *sql2 = [NSString stringWithFormat:@"DELETE FROM app_student_module WHERE userid = '%@' AND moduleid = '%@'", userid, module.databaseID];
        [self updateSQL:sql2];
    }
    else{
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO app_student_module (userid,moduleid) VALUES('%@','%@')", userid, module.databaseID];
        [self updateSQL:sql];
        NSString *sql2 = [NSString stringWithFormat:@"INSERT INTO app_module_event_student (userid,modeventid) SELECT '%@', app_module_event.modeventid FROM app_module_event WHERE moduleid = '%@' ", userid, module.databaseID];
        [self updateSQL:sql2];
    }

}

-(void)updateUserAU:(AUClub*)auclub toDelete:(BOOL)del{

    NSUserDefaults *currentUserDefaults =[NSUserDefaults standardUserDefaults];
    NSString *userid = [currentUserDefaults stringForKey:@"userid"];
    
    if(del){
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM app_auclub_event_student WHERE userid = '%@' AND aueventid IN (SELECT aueventid FROM app_auclub_event WHERE auclubid = '%@')", userid, auclub.databaseID];
        [self updateSQL:sql];
        
        NSString *sql2 = [NSString stringWithFormat:@"DELETE FROM app_student_auclub WHERE userid = '%@' AND auclubid = '%@'", userid, auclub.databaseID];
        [self updateSQL:sql2];
    }
    else{
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO app_student_auclub (userid,auclubid) VALUES('%@','%@')", userid, auclub.databaseID];
        [self updateSQL:sql];
        NSString *sql2 = [NSString stringWithFormat:@"INSERT INTO app_auclub_event_student (userid,aueventid) SELECT '%@', app_auclub_event.aueventid FROM app_auclub_event WHERE auclubid = '%@' ", userid, auclub.databaseID];
        [self updateSQL:sql2];
    }
}

-(void)updateUserSOC:(Society*)society toDelete:(BOOL)del{

    NSUserDefaults *currentUserDefaults =[NSUserDefaults standardUserDefaults];
    NSString *userid = [currentUserDefaults stringForKey:@"userid"];
    
    if(del){
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM app_society_event_student WHERE userid = '%@' AND soceventid IN (SELECT soceventid FROM app_society_event WHERE societyid = '%@')", userid, society.databaseID];
        [self updateSQL:sql];
        
        NSString *sql2 = [NSString stringWithFormat:@"DELETE FROM app_student_society WHERE userid = '%@' AND societyid = '%@'", userid, society.databaseID];
        [self updateSQL:sql2];
    }
    else{
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO app_student_society (userid,societyid) VALUES('%@','%@')", userid, society.databaseID];
        [self updateSQL:sql];
        NSString *sql2 = [NSString stringWithFormat:@"INSERT INTO app_society_event_student (userid,soceventid) SELECT '%@', app_society_event.soceventid FROM app_society_event WHERE societyid = '%@' ", userid, society.databaseID];
        [self updateSQL:sql2];
    }
    
}

- (void)updateEvent:(Event *)event isNewEvent:(BOOL)isNew{
    
    
    NSDate *startdate = event.starttime;
    NSDate *enddate = event.endtime;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *starttime = [formatter stringFromDate:startdate];
    NSString *endtime = [formatter stringFromDate:enddate];
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    NSString *predString = [NSString stringWithFormat:@"(name LIKE '%@')",event.room];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predString];
    
    NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Room" inManagedObjectContext:managedObjectContext];
    
    [request1 setEntity:entity1];
    [request1 setPredicate:predicate];
    
    NSError *error = nil;
    
    NSMutableArray *mutableFetchResults1 = [[managedObjectContext executeFetchRequest:request1 error:&error] mutableCopy];
    if (mutableFetchResults1 == nil) {
        // Handle the error.
    }
    Room *current = [mutableFetchResults1 objectAtIndex:0];
    if(isNew){
        
        NSURL *url = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_newEvent.php"];
        NSArray *variables = [NSArray arrayWithObjects: current.roomid, starttime, endtime, event.info, event.eventid, event.type, nil];
        [self connectPHPurl:url variables:variables];
    }
    
    else{
        if ([event.type isEqualToString:@"AU"]){
            NSString *sql = [NSString stringWithFormat:@"UPDATE app_auclub_event SET roomid = '%@', start_time = '%@', end_time = '%@', note = '%@' WHERE aueventid = '%@'",current.roomid, starttime, endtime, event.info, event.eventid];
            [self updateSQL:sql];
        }
        if ([event.type isEqualToString:@"SOC"]){
            NSString *sql = [NSString stringWithFormat:@"UPDATE app_society_event SET roomid = '%@', start_time = '%@', end_time = '%@', note = '%@' WHERE soceventid = '%@'",current.roomid, starttime, endtime, event.info, event.eventid];
            [self updateSQL:sql];
        }
    }
}
- (void)updateMODEvent:(Event *)event isNewEvent:(BOOL)isNew{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    NSString *predString = [NSString stringWithFormat:@"(name LIKE '%@')",event.room];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predString];
    
    NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Room" inManagedObjectContext:managedObjectContext];
    
    [request1 setEntity:entity1];
    [request1 setPredicate:predicate];
    
    NSError *error = nil;
    
    NSMutableArray *mutableFetchResults1 = [[managedObjectContext executeFetchRequest:request1 error:&error] mutableCopy];
    if (mutableFetchResults1 == nil) {
        // Handle the error.
    }
    
    Room *current = [mutableFetchResults1 objectAtIndex:0];
    
    if(isNew){
        NSURL *url = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_addModEvent.php"];
        NSArray *variables = [NSArray arrayWithObjects: current.roomid, event.day, event.startPeriod, event.periodLength, event.info, event.periodID, event.eventid, nil];
        [self connectPHPurl:url variables:variables];
    }
    
    else{
        NSURL *url = [NSURL URLWithString:@"http://co-project.lboro.ac.uk/users/copk2/app/LU_php_updateModEvent.php"];
        NSArray *variables = [NSArray arrayWithObjects: current.roomid, event.day, event.startPeriod, event.periodLength, event.info, event.periodID, event.eventid, nil];
        [self connectPHPurl:url variables:variables];
    }
    
    
}

-(void)updateUserSelection:(Event*)event toDelete:(BOOL)del{

    NSUserDefaults *currentUserDefaults =[NSUserDefaults standardUserDefaults];
    NSString *userid = [currentUserDefaults stringForKey:@"userid"];
    
    if(del){
        if ([event.type isEqualToString:@"MOD"]){
            NSString *sql = [NSString stringWithFormat:@"DELETE FROM app_module_event_student WHERE userid = '%@' AND modeventid = '%@'", userid, event.eventid];
            [self updateSQL:sql];
        
        }
        if ([event.type isEqualToString:@"AU"]){
            NSString *sql = [NSString stringWithFormat:@"DELETE FROM app_auclub_event_student WHERE userid = '%@' AND aueventid = '%@'", userid, event.eventid];
            [self updateSQL:sql];
        }
        if ([event.type isEqualToString:@"SOC"]){
            NSString *sql = [NSString stringWithFormat:@"DELETE FROM app_society_event_student WHERE userid = '%@' AND soceventid = '%@'", userid, event.eventid];
            [self updateSQL:sql];
        }
    }
    else{
        if ([event.type isEqualToString:@"MOD"]){
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO app_module_event_student(userid,modeventid) VALUES('%@','%@')", userid, event.eventid];
            [self updateSQL:sql];
            
        }
        if ([event.type isEqualToString:@"AU"]){
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO app_auclub_event_student(userid,aueventid) VALUES('%@','%@')", userid, event.eventid];
            [self updateSQL:sql];
        }
        if ([event.type isEqualToString:@"SOC"]){
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO app_society_event_student(userid,soceventid) VALUES('%@','%@')", userid, event.eventid];
            [self updateSQL:sql];
        }
        
    }
}

-(void)getNewsData{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    newsContext = appDelegate.managedObjectContext;
    
    [self clearData:@"Newsstory" hasPredicate:NO withPrediacteStr:@""];

    
    NSURL *xmlURL = [[NSURL alloc] init];
    NSXMLParser *parserRSS;
    
    NSArray *allPaths = [NSArray arrayWithObjects:@"http://www.lufbra.net/news/rss/0/subtree/",@"http://www.lboro.ac.uk/students/rss/index.xml",@"http://blog.lboro.ac.uk/blog/category/news/feed",@"http://www.lboro.ac.uk/services/it/rss/index.xml", nil];
    
    for(NSString* currentPath in allPaths){
        path = currentPath;
        xmlURL = [NSURL URLWithString:path];
        parserRSS = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
        [parserRSS setDelegate:(id)self];
        [parserRSS parse];
    }
    
    NSError *error = nil;
    if (![newsContext save:&error]) {
        // Handle the error.
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	elementRSS = [elementName copy];
	if ([elementName isEqualToString:@"item"]) {
		newsTitle = [[NSMutableString alloc] init];
		newsDate = [[NSMutableString alloc] init];
		newsInfo = [[NSMutableString alloc] init];
		newsURL = [[NSMutableString alloc] init];
	}
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{

	if ([elementName isEqualToString:@"item"]) {
        Newsstory *newsitem = (Newsstory *)[NSEntityDescription insertNewObjectForEntityForName:@"Newsstory" inManagedObjectContext:newsContext];
        
        NSArray *newTitle = [newsTitle componentsSeparatedByString:@"\n"];
        NSMutableString *newTitle1= [[newTitle[0] stringByReplacingOccurrencesOfString:@"&lsquo;"
                                                                         withString:@"'"]mutableCopy];
        NSMutableString *newTitle2 = [[newTitle1 stringByReplacingOccurrencesOfString:@"&rsquo;"
                                                                         withString:@"'"]mutableCopy];

		[newsitem setTitle: newTitle2];
        
        NSMutableString *newlink = newsURL;
        
        NSMutableString *newerLink = [[newlink stringByReplacingOccurrencesOfString:@"\n"
                                                                         withString:@""]mutableCopy];
        NSMutableString *newestLink = [[newerLink stringByReplacingOccurrencesOfString:@" "
                                                                            withString:@""]mutableCopy];
        NSArray *urlArray = [newestLink componentsSeparatedByString:@"?"];
        
        [newsitem setLink: urlArray[0]];
        [newsitem setSummary: newsInfo];
        NSString *format = @"";
        
        if([path isEqualToString:@"http://www.lufbra.net/news/rss/0/subtree/"]){
            format = @"EEE, dd MMM yyyy HH:mm:ss ZZZ";
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            NSDate *thedate = [formatter dateFromString:newsDate];
            [newsitem setDate:thedate];
        }
        
        if([path isEqualToString:@"http://www.lboro.ac.uk/services/it/rss/index.xml"]){
            format = @"EEE, dd MMM yyyy ";
            NSString *newdate = [newsDate substringWithRange:NSMakeRange(0, 17)];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            NSDate *thedate = [formatter dateFromString:newdate];
            
            [newsitem setDate:thedate];
        }
        
        if([path isEqualToString:@"http://www.lboro.ac.uk/students/rss/index.xml"]){
            format = @", dd MMM yyyy ";
            NSArray *datestring = [newsDate componentsSeparatedByString:@"y"];
            
            NSMutableString *mutDate = [NSMutableString new];
            [mutDate appendString:datestring[1]];
            if([datestring count] >2){
                [mutDate appendString:datestring[2]];
            }
            NSString *newdate = [mutDate substringWithRange:NSMakeRange(0, 13)];
            
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            NSDate *thedate = [formatter dateFromString:newdate];
            
            [newsitem setDate:thedate];
        }
        
        if([path isEqualToString:@"http://blog.lboro.ac.uk/blog/category/news/feed"]){
            format = @"EEE, dd MMM yyyy ";         
            NSString *newdate = [newsDate substringWithRange:NSMakeRange(0, 17)];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            NSDate *thedate = [formatter dateFromString:newdate];
            
            [newsitem setDate:thedate];
            
    
            
        }
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{

	if ([elementRSS isEqualToString:@"title"]) {
		[newsTitle appendString:string];
	}
    else if ([elementRSS isEqualToString:@"link"]) {
		[newsURL appendString:string];
	}
    else if ([elementRSS isEqualToString:@"description"]) {
		[newsInfo appendString:string];
	}
    else if ([elementRSS isEqualToString:@"pubDate"]) {
		[newsDate appendString:string];
	}
	
}

@end

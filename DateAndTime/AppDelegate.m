//
//  AppDelegate.m
//  DateAndTime
//
//  Created by EnzoF on 22.08.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Student.h"

typedef  NSComparisonResult(^ComparisonResultBlock)(id _Nonnull obj1 , id _Nonnull obj2);
@interface AppDelegate ()

@property (strong, nonatomic) NSMutableArray *mArrayStudents;
@property (strong, nonatomic) NSDate *fastDate;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor greenColor];
    [self.window makeKeyAndVisible];
    
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = navC;
    
    
    for (int allStudents = 0; allStudents < 30; allStudents++) {
        Student *student = [[Student alloc]initWithDateOfBirthOfFromAge:16 toAge:50];
        
        [self.mArrayStudents addObject:student];
    }
    
    for (Student *currentStudentObj in self.mArrayStudents) {
        [currentStudentObj printDateFormatterOfDate:currentStudentObj.dateOfBirth];
    }

    NSLog(@"\nSorted Array by Students");
    NSArray *sortedArrayStudents = [self sortedArrayOfArrayStudent:self.mArrayStudents];
    for (Student *currentSortedStudentObj in sortedArrayStudents)
    {
        [currentSortedStudentObj printDateFormatterOfDate:currentSortedStudentObj.dateOfBirth];
    }
    
    
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:.5f target:self selector:@selector(birthdayGreetingsInFastCalendar:) userInfo:nil repeats:YES];
    self.timer = timer;
    
    Student *yangetStudent = [sortedArrayStudents objectAtIndex:0];
    Student *oldestStudent = [sortedArrayStudents objectAtIndex:[sortedArrayStudents count] -1];
    NSLog(@"%@",[self differenBetweenYangestStudent:yangetStudent andOldestStudent:oldestStudent]);
    // Override point for customization after application launch.
    return YES;
}

#pragma mark -initialization-

- (NSMutableArray*)mArrayStudents{
    if(!_mArrayStudents)
    {
        _mArrayStudents = [[NSMutableArray alloc]init];
    }
    
    return _mArrayStudents;
}

#pragma mark -metods-

-(NSArray*)sortedArrayOfArrayStudent:(NSArray*)arrayStudent{
   return [arrayStudent sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1 , id _Nonnull obj2){
        Student *studentObj1;
        Student *studentObj2;
        NSDate *dateStudentObj1;
        NSDate *dateStudentObj2;
       
        if([obj1 isKindOfClass:[Student class]])
        {
            studentObj1 = (Student*)obj1;
            dateStudentObj1 = studentObj1.dateOfBirth;
        }
        if([obj2 isKindOfClass:[Student class]])
        {
            studentObj2 = (Student*)obj2;
            dateStudentObj2 = studentObj2.dateOfBirth;
        }
        NSComparisonResult comparisonResult = [dateStudentObj2 compare:dateStudentObj1];
        return comparisonResult;
    }];
}

-(void)birthdayGreetingsInFastCalendar:(NSTimer*)timer{
    NSTimeInterval secondsPerDay = (NSTimeInterval)24*60*60;
    self.fastDate = [NSDate dateWithTimeInterval:secondsPerDay sinceDate:self.fastDate];
    NSDate *currentFastDate = [self monthAndDayOfDate:self.fastDate];
    
    for (Student *currentStudentObj in self.mArrayStudents) {
          NSDate *currentStudentDateOfBirth = [self monthAndDayOfDate:currentStudentObj.dateOfBirth];
        if([currentFastDate isEqualToDate:currentStudentDateOfBirth])
        {
            NSLog(@"Happy BirthDay student %@ %@",currentStudentObj.firstName,currentStudentObj.lastName);
        }
    }
}

- (NSDate*)monthAndDayOfDate:(NSDate*)date{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *fastDateComponents = [currentCalendar components: NSCalendarUnitMonth |
                                            NSCalendarUnitDay
                                                              fromDate:date];
    [fastDateComponents setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    return [currentCalendar dateFromComponents:fastDateComponents];
}

-(NSString*)differenBetweenYangestStudent:(Student*)yangestStudent andOldestStudent:(Student*)oldestStudent{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *differentComponents = [currentCalendar components:NSCalendarUnitYear         |
                                                                        NSCalendarUnitMonth        |
                                                                        NSCalendarUnitWeekOfMonth  |
                                                                        NSCalendarUnitDay
                                                        fromDate:oldestStudent.dateOfBirth toDate: yangestStudent.dateOfBirth
                                                         options:NSCalendarWrapComponents];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM YYYY 'by year'"];
    NSLog(@"\nYangest student %@ %@, which he was born %@ yanger then,"
          "\noldest student %@ %@, which he was born %@"
          "\non %lu years %lu months %lu weeks %lu days",
          yangestStudent.firstName,yangestStudent.lastName,[formatter stringFromDate:yangestStudent.dateOfBirth],
          oldestStudent.firstName,oldestStudent.lastName,[formatter stringFromDate:oldestStudent.dateOfBirth],
          [differentComponents year],[differentComponents month],[differentComponents weekOfMonth],[differentComponents day]);
    
    return nil;
}

#pragma mark -initialization-
-(NSDate*)fastDate{
    if(!_fastDate)
    {
        _fastDate = [NSDate date];
    }
    return _fastDate;
}

@end

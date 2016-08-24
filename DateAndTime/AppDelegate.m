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
typedef enum{
    AppDelegateSundaySearch,
    AppDelegateWeekdaysSearch
}AppDelegateTypeDayOfWeekSearch;
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
    
    NSLog(@"\nDate of Birth by Students");
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
    
    NSLog(@"\nFirstDay of every month in Current Year");
    NSDate *date = [NSDate date];
    NSLog(@"%@",[self namesFirstDaysOfEveryMonthInYearOfDate:date]);
    
    NSLog(@"\nAllSunday in Current Year");
    NSLog(@"%@",[self allDayinYearOfDate:date typeSearch:AppDelegateSundaySearch]);
    
    NSLog(@"\nAllWeekday in Current Year");
    NSLog(@"%@",[self allDayinYearOfDate:date typeSearch:AppDelegateWeekdaysSearch]);
    
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

-(NSDate*)fastDate{
    if(!_fastDate)
    {
        _fastDate = [NSDate date];
    }
    return _fastDate;
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
    NSString *outputString = [NSString stringWithFormat:
                              @"\nYangest student %@ %@, which he was born %@ yanger then,"
                              "\noldest student %@ %@, which he was born %@"
                              "\non %lu years %lu months %lu weeks %lu days",
                              yangestStudent.firstName,yangestStudent.lastName,[formatter stringFromDate:yangestStudent.dateOfBirth],
                              oldestStudent.firstName,oldestStudent.lastName,[formatter stringFromDate:oldestStudent.dateOfBirth],
                              [differentComponents year],[differentComponents month],[differentComponents weekOfMonth],[differentComponents day]];
    
    return outputString;
}

- (NSString*)namesFirstDaysOfEveryMonthInYearOfDate:(NSDate*)date{
    NSMutableString *mOutputStr;
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *currentComponents = [currentCalendar components: NSCalendarUnitYear |
                                           NSCalendarUnitMonth|
                                           NSCalendarUnitDay
                                                             fromDate:date];
    NSInteger setYear = [currentComponents year];
    NSInteger setDay = 1;
    NSInteger currentMonth = [currentComponents month];
    for (NSInteger month = 1; month <= 12; month++)
    {
        [currentComponents setYear:setYear];
        [currentComponents setMonth:month];
        [currentComponents setDay:setDay];
        NSDate *date = [currentCalendar dateFromComponents:currentComponents];
        NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
        [dayFormatter setDateFormat:@"EEEE"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd MMMM YYYY"];
        NSString *wasOrWill;
        if(month <= currentMonth)
        {
            wasOrWill = @"was";
        }
        else
        {
            wasOrWill = @"will be";
        }
        if(!mOutputStr)
        {
            mOutputStr = [[NSMutableString alloc] init];
        }
        [mOutputStr appendString:[NSString stringWithFormat:@"\n%@ %@ %@",[dateFormatter stringFromDate:date],wasOrWill,[dayFormatter stringFromDate:date]]];
    }
    return mOutputStr;
}

- (NSString*)allDayinYearOfDate:(NSDate*)date typeSearch:(AppDelegateTypeDayOfWeekSearch)TypeDayOfWeekSearch{
    __block NSMutableString *mOutputString = [[NSMutableString alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMMM YYYY"];
    NSInteger setDay = 1;
    NSInteger setMonth = 1;
    NSDateComponents *dateComponent =[calendar components:NSCalendarUnitYear
                                                 fromDate:date];
    NSInteger currentYear = [dateComponent year];
    [dateComponent setDay:setDay];
    [dateComponent setMonth:setMonth];
    [dateComponent setYear:currentYear];
    [dateComponent setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *currentDate = [calendar dateFromComponents:dateComponent];
    NSDictionary *dictionaryTypeDaysSearch;
    switch (TypeDayOfWeekSearch) {
        case AppDelegateSundaySearch:
            dictionaryTypeDaysSearch = [[NSDictionary alloc] initWithObjectsAndKeys: @"Su",@"1",nil];
            break;
        case AppDelegateWeekdaysSearch:
            dictionaryTypeDaysSearch = [[NSDictionary alloc] initWithObjectsAndKeys: @"Mon",@"2",@"Tu",@"3",@"We",@"4",@"Th",@"5",@"Fr",@"6",nil];
            break;
   
        default:
            dictionaryTypeDaysSearch = nil;
            break;
    }
    NSString *weekdayType = [NSString stringWithFormat:@"%lu",[dateComponent weekday]];
    if([dictionaryTypeDaysSearch objectForKey:weekdayType])
    {
        [mOutputString appendString:[NSString stringWithFormat:@"\n%@",[dateFormatter stringFromDate:date]]];
    }
    NSDateComponents *hourComponent = [calendar components:NSCalendarUnitHour fromDate:date];
   [calendar enumerateDatesStartingAfterDate:currentDate matchingComponents:hourComponent options:NSCalendarMatchStrictly usingBlock:^(NSDate * _Nullable date, BOOL exactMatch, BOOL * _Nonnull stop) {
       NSDateComponents *yearComponent = [calendar components:NSCalendarUnitYear fromDate:date];
       NSInteger year = [yearComponent year];
       if(!(year <= currentYear))
       {
           *stop = YES;
       }
       else
       {
           NSDateComponents *dayOfWeekComponent =[calendar components:NSCalendarUnitWeekday fromDate:date];
           NSString *weekdayType = [NSString stringWithFormat:@"%lu",[dayOfWeekComponent weekday]];
           if([dictionaryTypeDaysSearch objectForKey:weekdayType])
           {
             [mOutputString appendString:[NSString stringWithFormat:@"\n%@",[dateFormatter stringFromDate:date]]];
           }
       }
   }];
    return mOutputString;
}


@end

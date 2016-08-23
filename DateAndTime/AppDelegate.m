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


@end

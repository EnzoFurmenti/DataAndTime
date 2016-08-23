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


@end

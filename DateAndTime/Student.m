//
//  Student.m
//  DateAndTime
//
//  Created by EnzoF on 22.08.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import "Student.h"

static NSString *firstNames[] = {
                            @"Милена",
                            @"Инна",
                            @"Богдан",
                            @"Анатолий",
                            @"Тимофей",
                            @"Родион",
                            @"Альбина",
                            @"Семён",
                            @"Глеб",
                            @"Вячеслав",
                            @"Алла",
                            @"Василиса",
                            @"Анжелика",
                            @"Марат",
                            @"Владислав",
                            @"Ярослав",
                            @"Маргарита",
                            @"Матвей",
                            @"Тимур",
                            @"Виталий",
                            @"Степан"
};
static int firstNameCount = 21;


@implementation Student

#pragma mark -initalization-

-(instancetype)initWithDateOfBirthOfFromAge:(NSInteger)fromAge toAge:(NSInteger)toAge{
    self = [super init];
    if(self)
    {
        self.firstName = firstNames[arc4random() % firstNameCount];
        self.dateOfBirth = [self dateOfBirthOfSFromAge:fromAge toAge:toAge];
    }
    return self;
}

#pragma mark -metods-

- (NSDate*)dateOfBirthOfSFromAge:(NSInteger)fromAge toAge:(NSInteger)toAge{
    NSDate *currentdDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *allCurrentDateComponents = [calendar components:  NSCalendarUnitEra   |
                                                  NSCalendarUnitYear  |
                                                  NSCalendarUnitMonth |
                                                  NSCalendarUnitDay   |
                                                  NSCalendarUnitHour  |
                                                  NSCalendarUnitMinute|
                                                  NSCalendarUnitSecond|
                                                  NSCalendarUnitNanosecond
                                                             fromDate:currentdDate];
    NSInteger era = [allCurrentDateComponents era];
    
    NSInteger fromYear = [allCurrentDateComponents year] - toAge;
    NSInteger toYear = [allCurrentDateComponents year] - fromAge;
    
    NSInteger month = [allCurrentDateComponents month];
    NSInteger day = [allCurrentDateComponents day];
    NSInteger hour = [allCurrentDateComponents hour];
    NSInteger minute = [allCurrentDateComponents minute];
    NSInteger second = [allCurrentDateComponents second];
    NSInteger nanosecond = [allCurrentDateComponents nanosecond];
    
    
    NSDate *fromDate = [calendar dateWithEra:era year:fromYear month:month day:day hour:hour minute:minute second:second nanosecond:nanosecond];
    
    NSDate *toDate = [calendar dateWithEra:era year:toYear month:month day:day hour:hour minute:minute second:second nanosecond:nanosecond];
    
    NSTimeInterval rangeTimeInterval = [toDate timeIntervalSinceDate:fromDate];
    NSInteger intRangeTimeInterval = (NSInteger)rangeTimeInterval;
    NSTimeInterval randomTimeInterval = (NSTimeInterval)(arc4random() % intRangeTimeInterval);
    NSDate *dateOfBirth = [NSDate dateWithTimeInterval:randomTimeInterval sinceDate:fromDate];
    return dateOfBirth;
}


-(void)printDateFormatterOfDate:(NSDate*)date{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd MMMM YYYY GGGG EEEE  'in' HH:mm:ss:SSS"];
    NSLog(@"\nStudent %@ was born %@. His is %ld",self.firstName,[dateFormatter stringFromDate:date],self.age);
}

- (NSInteger)age{
    if(!_age)
    {
        NSDate *currentDate = [NSDate date];
        NSCalendar *currentCalendar = [NSCalendar currentCalendar];
        NSDateComponents *yearDateOfBirthComponent = [currentCalendar components:NSCalendarUnitYear fromDate:self.dateOfBirth];
        NSDateComponents *yearCurrentDateComponent = [currentCalendar components:NSCalendarUnitYear fromDate:currentDate];
        _age = [yearCurrentDateComponent year] - [yearDateOfBirthComponent year];
    }
    return _age;
}
@end

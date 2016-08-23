//
//  Student.h
//  DateAndTime
//
//  Created by EnzoF on 22.08.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (strong, nonatomic) NSDate *dateOfBirth;
@property (assign, nonatomic) NSInteger age;
@property (strong, nonatomic) NSString *firstName;


-(instancetype)initWithDateOfBirthOfFromAge:(NSInteger)fromAge toAge:(NSInteger)toAge;

-(void)printDateFormatterOfDate:(NSDate*)date;
@end

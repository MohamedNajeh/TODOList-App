//
//  Singlton.m
//  TodoListApp
//
//  Created by Najeh on 28/01/2022.
//

#import "Singlton.h"

@implementation Singlton
+(Singlton *)singleton {
    static dispatch_once_t pred;
    static Singlton *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[Singlton alloc] init];
        shared.globalArray = [[NSMutableArray alloc]init];
    });
    return shared;
}
@end

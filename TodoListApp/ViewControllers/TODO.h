//
//  TODO.h
//  TodoListApp
//
//  Created by Najeh on 27/01/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TODO : NSObject <NSCoding ,NSSecureCoding>
@property NSString *name,*descrip,*periorty,*currDate,*status,*reminAfter;

-(void)encodeWithCoder:(NSCoder *)encoder;
@end

NS_ASSUME_NONNULL_END

//
//  Singlton.h
//  TodoListApp
//
//  Created by Najeh on 28/01/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Singlton : NSObject
@property (nonatomic, retain) NSMutableArray * globalArray;
  +(Singlton*)singleton;
@end

NS_ASSUME_NONNULL_END

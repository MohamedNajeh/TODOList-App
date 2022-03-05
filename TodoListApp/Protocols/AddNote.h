//
//  AddNote.h
//  TodoListApp
//
//  Created by Najeh on 27/01/2022.
//

#import <Foundation/Foundation.h>
#import "TODO.h"
NS_ASSUME_NONNULL_BEGIN

@protocol AddNote <NSObject>
-(void) addNote:(TODO*) n;
@end

NS_ASSUME_NONNULL_END

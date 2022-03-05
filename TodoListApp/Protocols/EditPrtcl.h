//
//  EditPrtcl.h
//  TodoListApp
//
//  Created by Najeh on 28/01/2022.
//

#import <Foundation/Foundation.h>
#import "TODO.h"
NS_ASSUME_NONNULL_BEGIN

@protocol EditPrtcl <NSObject>
-(void) commitEditing:(TODO *) todo andIndex:(NSInteger) index;
-(void) commitRemove:(NSInteger) index;
@end

NS_ASSUME_NONNULL_END

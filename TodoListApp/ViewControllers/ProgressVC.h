//
//  ProgressVC.h
//  TodoListApp
//
//  Created by Najeh on 28/01/2022.
//

#import "ViewController.h"
#import "TODO.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProgressVC : ViewController <UITableViewDelegate , UITableViewDataSource>{
    NSMutableArray *result;
}

@property TODO* todo;
@property NSString *name,*descrip,*periorty,*currDate,*status;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

NS_ASSUME_NONNULL_END

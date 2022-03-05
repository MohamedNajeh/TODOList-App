//
//  DoneVC.h
//  TodoListApp
//
//  Created by Najeh on 29/01/2022.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoneVC : ViewController<UITabBarDelegate , UITableViewDataSource>
{
    NSMutableArray *doneArray;
}
@property NSString *name,*descrip,*periorty,*currDate,*status;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

NS_ASSUME_NONNULL_END

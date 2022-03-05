//
//  ToDoVC.h
//  TodoListApp
//
//  Created by Najeh on 27/01/2022.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoVC : ViewController <UITableViewDelegate ,UITableViewDataSource>{
    NSMutableArray *todos;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIView *noFilesViewOutlet;

@end

NS_ASSUME_NONNULL_END

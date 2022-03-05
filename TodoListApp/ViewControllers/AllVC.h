//
//  AllVC.h
//  TodoListApp
//
//  Created by Najeh on 29/01/2022.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AllVC : ViewController <UITableViewDelegate , UITableViewDataSource>{
    NSMutableArray *allData;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END

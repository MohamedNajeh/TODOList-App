//
//  ToDoVC.m
//  TodoListApp
//
//  Created by Najeh on 27/01/2022.
//

#import "ToDoVC.h"
#import "AddToDoVC.h"
#import "TODO.h"
#import "EditPrtcl.h"
#import "EditingVC.h"
#import "TodoDetailsVC.h"
#import "Singlton.h"
#import "ViewController.h"
#import "ProgressVC.h"
#import "DoneVC.h"
#import <QuartzCore/QuartzCore.h>
#import "AllVC.h"
@interface ToDoVC () <AddNote,EditPrtcl,UITabBarDelegate,UISearchBarDelegate>
{
    NSUserDefaults *defaults;
    NSMutableArray <TODO *> *todosArray;
    NSMutableArray *filteredData;
    NSMutableArray *highPer;
    NSMutableArray *midPer;
    NSMutableArray *lowPer;
    BOOL isFiltered,isSorted;
}
@end

@implementation ToDoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    isFiltered = false;
    isSorted = false;
    self.searchBar.delegate = self;
    todos = [NSMutableArray new];
    defaults = [NSUserDefaults standardUserDefaults];
    NSData *savedData = [defaults objectForKey:@"todosArray"];
    NSError *error;
    NSSet *set = [NSSet setWithArray:@[
        [NSMutableArray class],[TODO class],]];
   
    todosArray = (NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:&error];
    [todos addObjectsFromArray:todosArray];
}

-(void)viewWillAppear:(BOOL)animated{
    if(todos.count != 0){
    [self.tableView setBackgroundView:nil];
        
    }if(todos.count == 0){
        [self.tableView setBackgroundView:_noFilesViewOutlet];
    }
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    NSError *error;
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:todos requiringSecureCoding:YES error:&error];
    [defaults setObject:archiveData forKey:@"todosArray"];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        isFiltered = false;
    }else{
        isFiltered = true;
        filteredData = [[NSMutableArray alloc] init];
        if(isSorted){
            for (TODO *todo in highPer) {
                NSRange range = [todo.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (range.location != NSNotFound) {
                    [filteredData addObject:todo];
                }
            }
            
//            for (TODO *todo in midPer) {
//                NSRange range = [todo.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
//                if (range.location != NSNotFound) {
//                    [filteredData addObject:todo];
//                }
//            }
//
//            for (TODO *todo in lowPer) {
//                NSRange range = [todo.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
//                if (range.location != NSNotFound) {
//                    [filteredData addObject:todo];
//                }
//            }
        }else
        for (TODO *todo in todos) {
            NSRange range = [todo.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [filteredData addObject:todo];
            }
        }
    }
        
    [self.tableView reloadData];
}
- (IBAction)addNoteBtnPressed:(id)sender {
    AddToDoVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddTODO"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    [vc setAddTO:self];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (isSorted && isFiltered) {
        return 1;
    }else if(isSorted){
        return 3;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger num = 0;
    if (isFiltered) {
        return filteredData.count;
    }
    if (isSorted) {
        switch (section) {
            case 0:
                num = [highPer count];
                break;
            case 1:
                num = midPer.count;
                break;
            case 2:
                num = lowPer.count;
                break;
            default:
                break;
        }
    }else{
        num = [todos count];
    }
    return  num;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.contentView.layer.borderWidth = 7;
    cell.contentView.layer.cornerRadius = 25;
    //cell.contentView.layer.
    UIImageView *Img = [cell viewWithTag:1];
    UILabel *title = [cell viewWithTag:2];
    UILabel *creationDate = [cell viewWithTag:3];
    UILabel *periorty = [cell viewWithTag:5];
    if (isFiltered) {
        title.text = [filteredData [indexPath.row] name];
        creationDate.text = [filteredData [indexPath.row] currDate];
        periorty.text = [filteredData [indexPath.row] status];
        Img.image = [UIImage imageNamed:[filteredData [indexPath.row] periorty]];
    }
    else{
            if(isSorted){
                switch (indexPath.section) {
                    case 0:
                        title.text = [highPer [indexPath.row] name];
                        creationDate.text = [highPer [indexPath.row] currDate];
                        periorty.text = [highPer [indexPath.row] status];
                        Img.image = [UIImage imageNamed:[highPer [indexPath.row] periorty]];
                        break;
                    case 1:
                        title.text = [midPer [indexPath.row] name];
                        creationDate.text = [midPer [indexPath.row] currDate];
                        periorty.text = [midPer [indexPath.row] status];
                        Img.image = [UIImage imageNamed:[midPer [indexPath.row] periorty]];
                        break;
                    case 2:
                        title.text = [lowPer [indexPath.row] name];
                        creationDate.text = [lowPer [indexPath.row] currDate];
                        periorty.text = [lowPer [indexPath.row] status];
                        Img.image = [UIImage imageNamed:[lowPer [indexPath.row] periorty]];
                        break;
        
                    default:
                        break;
                }}
                else{
    title.text = [todos [indexPath.row] name];
    creationDate.text = [todos [indexPath.row] currDate];
    periorty.text = [todos [indexPath.row] status];
    Img.image = [UIImage imageNamed:[todos [indexPath.row] periorty]];
                }
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIContextualAction *edit = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Edit" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Editing Sure?🌚" message:@"Are you sure you want to edit this TODO ?" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *action1 =[UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            printf("granted\n");
            EditingVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EditVC"];
            
            [self.navigationController pushViewController:vc animated:YES];
            [vc setEditPr:self];
            [vc setIndex:indexPath.row];
            
        }];
        
        UIAlertAction *action2 =[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL];
        
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:NULL];
            // your code...
            
        }];
        edit.image  = [UIImage imageNamed:@"edit"];
    //-------------------Delete--------------------------
    UIContextualAction *delete = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"DELETING Sure?🌚" message:@"Are you sure you want to DELETE this TODO ?" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *action1 =[UIAlertAction actionWithTitle:@"DELETE" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if(self->isSorted){
            switch (indexPath.section) {
                case 0:
                    [self->highPer removeObjectAtIndex:indexPath.row];
                    break;
                case 1:
                    [self->midPer removeObjectAtIndex:indexPath.row];
                    break;
                case 2:
                    [self->lowPer removeObjectAtIndex:indexPath.row];
                    break;
                default:
                    break;
            }
            
        }else{
            [self->todos removeObjectAtIndex:indexPath.row];
        }
       
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        printf("delete\n");
            
        }];
        UIAlertAction *action2 =[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL];
        
            [alert addAction:action1];
            [alert addAction:action2];
            [self presentViewController:alert animated:YES completion:NULL];
        
    }];
    
    delete.image  = [UIImage systemImageNamed:@"trash"];
    delete.backgroundColor = [UIColor redColor];
        UISwipeActionsConfiguration *actions = [UISwipeActionsConfiguration configurationWithActions:[[NSArray alloc] initWithObjects:edit,delete, nil]];
        
        return actions;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TodoDetailsVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TodoDetailsVC"];
    if(self->isSorted){
        switch (indexPath.section) {
            case 0:
                [vc setImgName:[highPer [indexPath.row] periorty]];
                [vc setTitleName:[highPer [indexPath.row] name]];
                [vc setDescrip:[highPer [indexPath.row] descrip]];
                break;
            case 1:
                [vc setImgName:[midPer [indexPath.row] periorty]];
                [vc setTitleName:[midPer [indexPath.row] name]];
                [vc setDescrip:[midPer [indexPath.row] descrip]];
                break;
            case 2:
                [vc setImgName:[lowPer [indexPath.row] periorty]];
                [vc setTitleName:[lowPer [indexPath.row] name]];
                [vc setDescrip:[lowPer [indexPath.row] descrip]];
                break;
            default:
                break;
        }
        
    }else{
    [vc setImgName:[todos [indexPath.row] periorty]];
    [vc setTitleName:[todos [indexPath.row] name]];
    [vc setDescrip:[todos [indexPath.row] descrip]];
    }
    
    [self presentViewController:vc animated:YES completion:NULL];
    
}

- (void)addNote:(TODO *)n {
    [todos addObject:n];
    [self.tableView reloadData];
}



- (void)commitEditing:(nonnull TODO *)todo andIndex:(NSInteger)index {
    [todos removeObjectAtIndex:index];
    [todos insertObject:todo atIndex:index];
    [self.tableView reloadData];
}

- (void)commitRemove:(NSInteger)index {
    [todos removeObjectAtIndex:index];
    [self.tableView reloadData];
}
- (IBAction)progressItemPresseed:(id)sender {
    ProgressVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProgressVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)toDoneItemVC:(id)sender {
    DoneVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DoneVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)allItemVC:(id)sender {
    AllVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AllVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)sortTableBtn:(id)sender {
    isSorted = true;
    highPer = [NSMutableArray new];
    midPer = [NSMutableArray new];
    lowPer = [NSMutableArray new];
    
    for (TODO *todo in todos) {
       // NSRange range = [todo.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if ([todo.periorty isEqualToString:@"High"]) {
            [highPer addObject:todo];
        }else if([todo.periorty isEqualToString:@"Mid"]){
            [midPer addObject:todo];
        }else if([todo.periorty isEqualToString:@"Low"]){
            [lowPer addObject:todo];
        }
        [self.tableView reloadData];
    }
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Sorted😃" message:@"Table sorted successfully" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action2 =[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:NULL];
    
    
}

@end

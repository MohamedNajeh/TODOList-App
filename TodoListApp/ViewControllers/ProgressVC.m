//
//  ProgressVC.m
//  TodoListApp
//
//  Created by Najeh on 28/01/2022.
//

#import "ProgressVC.h"
#import "TODO.h"
#import "EditingProgressVC.h"
#import "EditingVC.h"
#import "ToDoVC.h"
#import "DoneVC.h"
#import "TodoDetailsVC.h"
@interface ProgressVC () <EditPrtcl>{
    NSUserDefaults *defaults1;
    NSMutableArray <TODO *> *progressArray;
    NSMutableArray *inProgressArray;
    NSMutableArray *highPer;
    NSMutableArray *midPer;
    NSMutableArray *lowPer;
    BOOL isSorted;
    
   // NSString *name1,*descrip1,*periorty1,*currDate1,*status1;
}


@end

@implementation ProgressVC

- (void)viewDidLoad {
    
   
    [super viewDidLoad];
    isSorted = false;
    result = [NSMutableArray new];
    defaults1 = [NSUserDefaults standardUserDefaults];
    NSData *savedData = [defaults1 objectForKey:@"progressArray"];
    NSError *error;
    NSSet *set = [NSSet setWithArray:@[
        [NSMutableArray class],[TODO class],]];
   
    progressArray = (NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:&error];
    [result addObjectsFromArray:progressArray];
    
}

-(void)viewWillAppear:(BOOL)animated{
    if(_descrip != nil){
        TODO *tdo;
        tdo = [TODO new];
        [tdo setName:_name];
        [tdo setStatus:_status];
        [tdo setDescrip:_descrip];
        [tdo setPeriorty:_periorty];
        [tdo setCurrDate:_currDate];
        [result addObject:tdo];
    }
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    NSError *error;
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:result requiringSecureCoding:YES error:&error];
    [defaults1 setObject:archiveData forKey:@"progressArray"];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (isSorted) {
        return 3;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger num = 0;
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
        num = [result count];
    }
    return  num;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inProgressCell" forIndexPath:indexPath];
    cell.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.contentView.layer.borderWidth = 7;
    cell.contentView.layer.cornerRadius = 25;
    
    UIImageView *Img = [cell viewWithTag:1];
    UILabel *title = [cell viewWithTag:2];
    UILabel *creationDate = [cell viewWithTag:3];
    UILabel *periorty = [cell viewWithTag:5];
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
        }
    }else {
        title.text = [result [indexPath.row] name];
        creationDate.text = [result [indexPath.row] currDate];
        periorty.text = [result [indexPath.row] status];
        Img.image = [UIImage imageNamed:[result [indexPath.row] periorty]];
    }
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIContextualAction *edit = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Edit" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Editing" message:@"Are you sure you want to edit this TODO ?" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *action1 =[UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            printf("granted\n");
            EditingProgressVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EditProgVC"];
            [self.navigationController pushViewController:vc animated:YES];
            [vc setEditProg:self];
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
            
            // your code...
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"DELETING ⛔️" message:@"Are you sure you want to DELETE this TODO ?" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *action1 =[UIAlertAction actionWithTitle:@"DELETE" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            printf("granted delete\n");
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
                [self->result removeObjectAtIndex:indexPath.row];
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
    [vc setImgName:[result [indexPath.row] periorty]];
    [vc setTitleName:[result [indexPath.row] name]];
    [vc setDescrip:[result [indexPath.row] descrip]];
    }
    [self presentViewController:vc animated:YES completion:NULL];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (IBAction)movetoTODOVC:(id)sender {
//    NSArray *viewControllers = [self.navigationController viewControllers];
//    [self.navigationController popToViewController:viewControllers[viewControllers.count - 3] animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)commitEditing:(nonnull TODO *)todo andIndex:(NSInteger)index {
    [result removeObjectAtIndex:index];
    [result insertObject:todo atIndex:index];
    [self.tableView reloadData];
}

- (void)commitRemove:(NSInteger)index {
    [result removeObjectAtIndex:index];
    [self.tableView reloadData];
}

- (IBAction)toDoneItemVC:(id)sender {
    DoneVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DoneVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)sortBtnPressed:(id)sender {
    isSorted = true;
    highPer = [NSMutableArray new];
    midPer = [NSMutableArray new];
    lowPer = [NSMutableArray new];
    
    for (TODO *todo in result) {
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
    UIAlertAction *action2 =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:NULL];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:NULL];
    
}

@end

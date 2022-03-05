//
//  DoneVC.m
//  TodoListApp
//
//  Created by Najeh on 29/01/2022.
//

#import "DoneVC.h"
#import "TODO.h"
#import "ProgressVC.h"
#import "TodoDetailsVC.h"
@interface DoneVC ()
{
    NSUserDefaults *defaults;
    NSMutableArray <TODO *> *doneeArray;
    NSMutableArray *highPer;
    NSMutableArray *midPer;
    NSMutableArray *lowPer;
    BOOL isSorted;
}
@end

@implementation DoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    isSorted = false;
    doneArray = [NSMutableArray new];
    defaults = [NSUserDefaults standardUserDefaults];
    NSData *savedData = [defaults objectForKey:@"doneeArray"];
    NSError *error;
    NSSet *set = [NSSet setWithArray:@[
        [NSMutableArray class],[TODO class],]];
   
    doneeArray = (NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:&error];
    [doneArray addObjectsFromArray:doneeArray];
    //[self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view.
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
        [doneArray addObject:tdo];
    }
    [self.tableView reloadData];
}
-(void)viewWillDisappear:(BOOL)animated{
    NSError *error;
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:doneArray requiringSecureCoding:YES error:&error];
    [defaults setObject:archiveData forKey:@"doneeArray"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(isSorted){
        return 3;
    }
    return  1;
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
    [vc setImgName:[doneArray [indexPath.row] periorty]];
    [vc setTitleName:[doneArray [indexPath.row] name]];
    [vc setDescrip:[doneArray [indexPath.row] descrip]];
    }
    [self presentViewController:vc animated:YES completion:NULL];
    
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
        num = [doneArray count];
    }
    return  num;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoneCell" forIndexPath:indexPath];
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
    title.text = [doneArray [indexPath.row] name];
    creationDate.text = [doneArray [indexPath.row] currDate];
    periorty.text = [doneArray [indexPath.row] status];
    Img.image = [UIImage imageNamed:[doneArray [indexPath.row] periorty]];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"DELETING ⛔️" message:@"Are you sure you want to DELETE this TODO ?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 =[UIAlertAction actionWithTitle:@"DELETE" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
    if (editingStyle == UITableViewCellEditingStyleDelete) {
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
        [self->doneArray removeObjectAtIndex:indexPath.row];
        }
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        printf("delete\n");
    }
    }];
    UIAlertAction *action2 =[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL];
    
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:NULL];

}
- (IBAction)todoItemVC:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)progressitemPressed:(id)sender {
    ProgressVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProgressVC"];
    
    [self.navigationController popToViewController:vc animated:YES];
    
}
- (IBAction)sortBtnPressed:(id)sender {
    isSorted = true;
    highPer = [NSMutableArray new];
    midPer = [NSMutableArray new];
    lowPer = [NSMutableArray new];
    
    for (TODO *todo in doneArray) {
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

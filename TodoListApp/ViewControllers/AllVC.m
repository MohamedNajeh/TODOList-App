//
//  AllVC.m
//  TodoListApp
//
//  Created by Najeh on 29/01/2022.
//

#import "AllVC.h"
#import "TODO.h"
#import "TodoDetailsVC.h"
@interface AllVC (){
    NSUserDefaults *defaults;
    NSMutableArray <TODO *> *todosArray;
    NSMutableArray <TODO *> *progArray;
    NSMutableArray <TODO *> *donsArray;
    NSMutableArray *highPer;
    NSMutableArray *midPer;
    NSMutableArray *lowPer;
    NSMutableArray *filteredData;
    BOOL isSorted;
}

@end

@implementation AllVC

- (void)viewDidLoad {
    [super viewDidLoad];
    isSorted = false;
    //self.searchBar.delegate = self;
    allData = [NSMutableArray new];
    defaults = [NSUserDefaults standardUserDefaults];
    NSData *savedData = [defaults objectForKey:@"todosArray"];
    NSData *savedData1 = [defaults objectForKey:@"progressArray"];
    NSData *savedData2 = [defaults objectForKey:@"doneeArray"];
    NSError *error;
    NSSet *set = [NSSet setWithArray:@[
        [NSMutableArray class],[TODO class],]];
   
    todosArray = (NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:&error];
    
    progArray = (NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData1 error:&error];
    
    donsArray = (NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData2 error:&error];
    [allData addObjectsFromArray:todosArray];
    [allData addObjectsFromArray:progArray];
    [allData addObjectsFromArray:donsArray];
    //[self.tableView reloadData];
    // Do any additional setup after loading the view.
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
    [vc setImgName:[allData [indexPath.row] periorty]];
    [vc setTitleName:[allData [indexPath.row] name]];
    [vc setDescrip:[allData [indexPath.row] descrip]];
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
        num = [allData count];
    }
    return  num;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllCell" forIndexPath:indexPath];
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
    title.text = [allData [indexPath.row] name];
    creationDate.text = [allData [indexPath.row] currDate];
    periorty.text = [allData [indexPath.row] status];
    Img.image = [UIImage imageNamed:[allData [indexPath.row] periorty]];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (IBAction)sortBtnPressed:(id)sender {
    isSorted = true;
    highPer = [NSMutableArray new];
    midPer = [NSMutableArray new];
    lowPer = [NSMutableArray new];
    
    for (TODO *todo in allData) {
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

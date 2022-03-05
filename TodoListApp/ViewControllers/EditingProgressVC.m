//
//  EditingProgressVC.m
//  TodoListApp
//
//  Created by Najeh on 29/01/2022.
//

#import "EditingProgressVC.h"
#import "TODO.h"
#import "DoneVC.h"
@interface EditingProgressVC (){
    NSDateFormatter *dateFormatter;
    
    
    
}

@end

@implementation EditingProgressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy        hh:mm:ss"];
   
    _editBtnOutlet.layer.cornerRadius = 25;
    _descripTextView.layer.cornerRadius = 20;
    // Do any additional setup after loading the view.
}

- (IBAction)editProgTODO:(id)sender {
    TODO *todo = [TODO new];
    todo.name = self.nameTxtField.text;
    todo.currDate = [dateFormatter stringFromDate:[NSDate date]];
    todo.periorty = [self.periortySegment titleForSegmentAtIndex:_periortySegment.selectedSegmentIndex];
    todo.descrip = _descripTextView.text;
    todo.status = @"active";
    if([_swithControl isOn]){
        DoneVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DoneVC"];;
        [vc setName:_nameTxtField.text];
        [vc setDescrip:_descripTextView.text];
        [vc setCurrDate:[dateFormatter stringFromDate:[NSDate date]]];
        [vc setPeriorty:[self.periortySegment titleForSegmentAtIndex:_periortySegment.selectedSegmentIndex]];
        [vc setStatus:@"DONE"];
        [self.editProg commitRemove:_index];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        [self.editProg commitEditing:todo andIndex:_index];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end

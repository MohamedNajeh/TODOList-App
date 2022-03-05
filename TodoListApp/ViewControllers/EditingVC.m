//
//  EditingVC.m
//  TodoListApp
//
//  Created by Najeh on 28/01/2022.
//

#import "EditingVC.h"
#import "ProgressVC.h"
@interface EditingVC ()<UITextFieldDelegate>{
    NSDateFormatter *dateFormatter;
    ProgressVC *vc;
}

@end

@implementation EditingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy        hh:mm:ss"];
    [self.nameTxtField setDelegate:self];
    vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProgressVC"];
    
    // Do any additional setup after loading the view.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)EditBtnPressed:(id)sender {
    TODO *todo = [TODO new];
    todo.name = self.nameTxtField.text;
    todo.currDate = [dateFormatter stringFromDate:[NSDate date]];
    todo.periorty = [self.periortySegment titleForSegmentAtIndex:_periortySegment.selectedSegmentIndex];
    todo.descrip = _descripTextView.text;
    todo.status = @"inActive";
    if([_activationToggle isOn]){
        //todo.status = @"active";

        [vc setName:_nameTxtField.text];
        [vc setDescrip:_descripTextView.text];
        [vc setCurrDate:[dateFormatter stringFromDate:[NSDate date]]];
        [vc setPeriorty:[self.periortySegment titleForSegmentAtIndex:_periortySegment.selectedSegmentIndex]];
        [vc setStatus:@"active"];
        [self.editPr commitRemove:_index];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        [self.editPr commitEditing:todo andIndex:_index];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


@end

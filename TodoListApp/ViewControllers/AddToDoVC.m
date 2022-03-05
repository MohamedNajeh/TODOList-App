//
//  AddToDoVC.m
//  TodoListApp
//
//  Created by Najeh on 27/01/2022.
//

#import "AddToDoVC.h"
#import "TODO.h"
@interface AddToDoVC () <UITextFieldDelegate>{
    NSDateFormatter *dateFormatter;
}

@end
BOOL isGranted;
@implementation AddToDoVC
NSString *per;

- (void)viewDidLoad {
    [super viewDidLoad];
    dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy        hh:mm:ss"];
    [self.nameTextField setDelegate:self];
    _addBtnOutlet.layer.cornerRadius = 25;
    _descripTextView.layer.cornerRadius = 20;
    [self configureReminder];
//    [dateFormatter stringFromDate:[NSDate date]
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(void)viewWillAppear:(BOOL)animated{
    
    
}
- (IBAction)addBtnPressed:(id)sender {
    TODO *todo = [TODO new];
    if([_nameTextField.text isEqualToString:@""] || [_descripTextView.text isEqualToString:@""]){
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Missing Data 🌚" message:@"Complete Empty fields please" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action2 =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:NULL];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:NULL];
    }
    else{
        
    todo.name = self.nameTextField.text;
    todo.currDate = [dateFormatter stringFromDate:_datePickerOutlet.date];
    todo.periorty = [self.periortySegment titleForSegmentAtIndex:_periortySegment.selectedSegmentIndex];
    todo.descrip = _descripTextView.text;
    todo.status = @"inActive";
    todo.reminAfter = _reminderTextField.text;
    [self.addTO addNote:todo];
    [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (IBAction)addReminder:(id)sender {
    if (isGranted){
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = _nameTextField.text;
        content.subtitle = [self.periortySegment titleForSegmentAtIndex:_periortySegment.selectedSegmentIndex];
    content. body = @"This is Reminder From todoAPP";
    content.sound = [UNNotificationSound defaultSound];
    //[content setLaunchImageName:@"High"];
    // setting the notification trigger
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
        triggerWithTimeInterval:[self.reminderTextField.text intValue] repeats:NO];
    // setting request for the notification
    UNNotificationRequest *request = [UNNotificationRequest
    requestWithIdentifier:@"UYLLocalNotification"content:content trigger: trigger];
    //add notification for current notification centre
    [center addNotificationRequest:request withCompletionHandler:nil];
        _reminderTextField.text = @"";
    }
}

-(void)configureReminder{
    isGranted = false;
    UNUserNotificationCenter*center
    = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert+UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:options completionHandler:^ (BOOL granted, NSError* _Nullable error){
    isGranted=granted;
    }];
}

@end

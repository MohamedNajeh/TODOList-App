//
//  AddToDoVC.h
//  TodoListApp
//
//  Created by Najeh on 27/01/2022.
//

#import "ViewController.h"
#import "AddNote.h"
#import <UserNotifications/UserNotifications.h>
NS_ASSUME_NONNULL_BEGIN

@interface AddToDoVC : ViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *descripTextView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *periortySegment;
@property (weak, nonatomic) IBOutlet UILabel *perLbl;
@property id <AddNote> addTO;
@property (weak, nonatomic) IBOutlet UIButton *addBtnOutlet;
@property (weak, nonatomic) IBOutlet UITextField *reminderTextField;
@property (weak, nonatomic) IBOutlet UIButton *reminderBtnOutlet;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerOutlet;
@end

NS_ASSUME_NONNULL_END

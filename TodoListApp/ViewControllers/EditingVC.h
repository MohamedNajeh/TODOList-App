//
//  EditingVC.h
//  TodoListApp
//
//  Created by Najeh on 28/01/2022.
//

#import "ViewController.h"
#import "EditPrtcl.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditingVC : ViewController
@property id <EditPrtcl> editPr;

@property NSInteger index;
@property (weak, nonatomic) IBOutlet UITextField *nameTxtField;
@property (weak, nonatomic) IBOutlet UITextView *descripTextView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *periortySegment;
@property (weak, nonatomic) IBOutlet UISwitch *activationToggle;
@end

NS_ASSUME_NONNULL_END

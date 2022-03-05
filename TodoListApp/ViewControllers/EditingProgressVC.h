//
//  EditingProgressVC.h
//  TodoListApp
//
//  Created by Najeh on 29/01/2022.
//

#import "ViewController.h"
#import "EditPrtcl.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditingProgressVC : ViewController
@property id <EditPrtcl> editProg;
@property NSInteger index;
@property (weak, nonatomic) IBOutlet UITextField *nameTxtField;
@property (weak, nonatomic) IBOutlet UITextView *descripTextView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *periortySegment;

@property (weak, nonatomic) IBOutlet UISwitch *swithControl;
@property (weak, nonatomic) IBOutlet UIButton *editBtnOutlet;

@end

NS_ASSUME_NONNULL_END

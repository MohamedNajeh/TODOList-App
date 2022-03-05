//
//  TodoDetailsVC.h
//  TodoListApp
//
//  Created by Najeh on 28/01/2022.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TodoDetailsVC : ViewController
@property (weak, nonatomic) IBOutlet UIImageView *periortyImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property NSString *imgName,*titleName,*descrip;
@end

NS_ASSUME_NONNULL_END

//
//  TodoDetailsVC.m
//  TodoListApp
//
//  Created by Najeh on 28/01/2022.
//

#import "TodoDetailsVC.h"

@interface TodoDetailsVC ()

@end

@implementation TodoDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.periortyImgView.image = [UIImage imageNamed:_imgName];
    self.titleLbl.text = _titleName;
    self.descriptionTextView.text = _descrip;
    _descriptionTextView.layer.cornerRadius = 20;
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

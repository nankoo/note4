//
//  FirstViewController.h
//  sample_nsurlconnection_nsurlsession_category
//
//  Created by kazuhiro on 2014/05/21.
//  Copyright (c) 2014年 kazuhiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController{
    NSString *nameData;
    
}
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UITextView *myText;
@property (nonatomic) NSString *nameData;
@property (weak, nonatomic) IBOutlet UIButton *myBtn_data;
- (IBAction)actBtn_data:(id)sender;

@end

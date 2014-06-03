//
//  SecondViewController.h
//  sample_nsurlconnection_nsurlsession_category
//
//  Created by kazuhiro on 2014/05/21.
//  Copyright (c) 2014年 kazuhiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
<NSURLConnectionDelegate, NSURLSessionDelegate, NSURLConnectionDataDelegate>
{
    NSURLConnection *connection;
    NSMutableData *mutableData;
    
    float totalBytes;
    float loadedBytes;
    
    NSData *data;
    //NSString *errorString;
}
@property NSData *data;

@property (weak, nonatomic) IBOutlet UILabel *myLabel2;
@property (weak, nonatomic) IBOutlet UITextView *myText2;
@property (weak, nonatomic) IBOutlet UIButton *mybtn2;
- (IBAction)actBtn2:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *myBtn_Syn;
- (IBAction)actBtn_syn:(id)sender;
@property (weak, nonatomic) IBOutlet UIProgressView *progres_bar;

@end

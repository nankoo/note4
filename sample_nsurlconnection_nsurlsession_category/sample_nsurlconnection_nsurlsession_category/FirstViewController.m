//
//  FirstViewController.m
//  sample_nsurlconnection_nsurlsession_category
//
//  Created by kazuhiro on 2014/05/21.
//  Copyright (c) 2014年 kazuhiro. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController


@synthesize nameData;


//サーバとのコネクション情報を保持
NSURLConnection *connection = nil;
//受信データを入れる
NSMutableData *data_data = nil;
NSMutableArray *data_string = nil;
NSMutableDictionary *data_dic = nil;


- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/*メモリ不足警告をアプリが受け取った時に、didReceiveMemoryWarning から呼び出されるメモリ
- (void)viewDidUnload{
    [self setNameData:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
 */

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//
- (IBAction)actBtn_data:(id)sender {
    //同期通信
    //接続先URLを指定する
    NSString* address = @"http://dev.classmethod.jp/references/ios-nsurlsession-1/";
    //接続先URLをNSURL型に変換する
    NSURL* url = [NSURL URLWithString:address];
              //リクエストを作成
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: url];
    //サーバと接続する
    connection = [
                  [NSURLConnection alloc]
                  initWithRequest : request
                  delegate : self
                  ];
        if (!connection) {
            NSLog(@"connection error.");
            }

        }

// 非同期通信ヘッダーが返ってきた
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    _myLabel.text =@"通信開始";
    // データを初期化
    data_data = [[NSMutableData alloc] initWithData:0];
    /*
     　// プログレスバー更新
     　totalbytes = [response expectedContentLength];
     　loadedbytes = 0.0;
     progressBar.progress = loadedbytes;
     */
}

// 非同期通信ダウンロード中
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    //mutabledata(async_data)にデータを追加する
    [data_data appendData:data];
    _myLabel.text =@"ダウンロード中";
    /*
       // プログレスバー更新
       loadedbytes += [data length];
       [progress setProgress:(loadedbytes/totalbytes)];
    */
}


// 非同期通信エラー
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSString *error_str = [error localizedDescription];
    NSLog(@"%@", error_str);
}

// 非同期通信ダウンロード完了
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *data_str = nil;
    //受信データのエンコーディング
    //NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data_data];
    //NSLog(@"%@", array);
    
    data_str = [[NSString alloc]initWithData : data_data
                                          encoding : NSUTF8StringEncoding];
    
    // 終わった事をAlertダイアログで表示する。
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                       message:@"Finish Loading"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
    [alertView show];
    _myLabel.text = @"完了";
    _myText.text = data_str;

     // プログレスバー更新
    //[progress setProgress:1.0];

     }




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

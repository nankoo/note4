//
//  SecondViewController.m
//  sample_nsurlconnection_nsurlsession_category
//
//  Created by kazuhiro on 2014/05/21.
//  Copyright (c) 2014年 kazuhiro. All rights reserved.
//

/*
 #pragma mark Synchronous //同期通信
 #pragma mark ASynchronous //非同期通信
 #pragma mark session_Synchronous //NSURLSession_同期通信
 #pragma mark session_ASynchronous //NSURLSession_非同期通信
 
 
 */


#import "SecondViewController.h"

@interface SecondViewController ()

@end



@implementation SecondViewController
@synthesize data;





- (void)viewDidLoad
{
    NSLog(@"6");
    [super viewDidLoad];
    [_progres_bar setProgress:0.0];
    
}



- (void)didReceiveMemoryWarning
{
    NSLog(@"7");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//同期通信
#pragma mark Synchronous
//同期通信呼び出し
- (IBAction)actBtn_syn:(id)sender {
    
    // [1]
    NSURL *url = [NSURL URLWithString:@"http://www.hatena.ne.jp"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    // [2]
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // [3]
    NSString *errorString = [error localizedDescription];
    if (0 < [errorString length]){
        // エラー処理
        // お好きにどうぞ！
        // --- 省略  ---
    }

    if (0 < [errorString length]){
        NSLog(@"オワタ");
    }
    
    // [4]
    int encArray[] = {
        NSUTF8StringEncoding,           // UTF-8
        NSShiftJISStringEncoding,       // Shift-JIS
        NSJapaneseEUCStringEncoding,    // EUC-JP
        NSISO2022JPStringEncoding,      // JIS
        NSUnicodeStringEncoding,        // Unicode
        NSASCIIStringEncoding           // ASCII
    };
    
    NSString *dataString = nil;
    //NSStringにするなりして使用出来るデータ型やオブジェクトに変換する必要がある
    //forで要素数分だけループを回します
    //「/」は割り算という認識であってる？
    int max = sizeof(encArray) / sizeof(encArray[0]);
    NSLog(@"%d", max);
    
    for (int i = 0; i < max; i++){
        dataString = [[NSString alloc] initWithData:data encoding:encArray[i]];
        if (dataString != nil) {
            break;
        }
    }
    
    NSLog(@"%@", dataString);
    _myText2.text = dataString;
    // dataString内にHTTP通信でとれた結果がNSStringとして代入されています。
    // あとはお好きに...
    
    // --- 省略  --- //
}



//非同期通信
#pragma mark ASynchronous

// pushAsyncBtnが押されたら実行される処理
-(IBAction)actBtn2:(id)sender{
    
    // [1]
    NSURL *url = [NSURL URLWithString:@"http://www.hatena.ne.jp"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // [5]
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection == nil) {
        // エラー処理
        // お好きにどうぞ！
        // --- 省略  ---
    }

}

//引数の数で飛ぶメソッド判断してるの？


// [6]非同期用：レスポンスを受け取った際に呼び出される
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // データを初期化
    mutableData = [[NSMutableData alloc] initWithData:0];
    // プログレスバーを更新
    totalBytes = [response expectedContentLength];
    loadedBytes = 0.0;
    [_progres_bar setProgress: loadedBytes];
}

// [7]非同期用：データを受け取る度に呼び出される
- (void) connection:(NSURLConnection*)connection didReceiveData:(NSData *)data
{
    // データを追加する
    [mutableData appendData:data];
    // プログレスバーを更新
    loadedBytes += [data length];
    [_progres_bar setProgress:(loadedBytes / totalBytes)];
}

// [8]非同期用：通信時にエラーが起きた際に呼ばれるメソッド
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"オワタ");
}

// [9]非同期用：データ通信終了後に呼び出される
- (void) connectionDidFinishLoading:(NSURLConnection*)connection
{
    // [4]
    int encArray[] = {
        NSUTF8StringEncoding,
        NSShiftJISStringEncoding,
        NSJapaneseEUCStringEncoding,
        NSISO2022JPStringEncoding,
        NSUnicodeStringEncoding,
        NSASCIIStringEncoding
    };
    
    NSString *dataString = nil;
    int max = sizeof(encArray) / sizeof(encArray[0]);
    for (int i = 0; i < max; i++){
        dataString = [[NSString alloc] initWithData:mutableData encoding:encArray[i]];
        if (dataString != nil){
            break;
        }
    }
    
    // プログレスバーを更新
    [_progres_bar setProgress:1.0];
    
    // dataString内にHTTP通信でとれた結果がNSStringとして代入されています。
    // あとはお好きに...
    // --- 省略  --- //
}



@end

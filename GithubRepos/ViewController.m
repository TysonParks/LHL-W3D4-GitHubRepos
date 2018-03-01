//
//  ViewController.m
//  GithubRepos
//
//  Created by Tyson Parks on 3/1/18.
//  Copyright © 2018 Tyson Parks. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/TysonParks/repos"]; // 1
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url]; // 2
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 4
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        
    }]; // 5
    
    [dataTask resume]; // 6

}

@end

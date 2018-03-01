//
//  ViewController.m
//  GithubRepos
//
//  Created by Tyson Parks on 3/1/18.
//  Copyright © 2018 Tyson Parks. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) NSArray *repos;
//@property (strong, nonatomic) NSString *repoName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/TysonParks/repos"]; // 1
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url]; // 2
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 4
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        self.repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; // 2
        
        if (jsonError) { // 3
            // Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        // If we reach this point, we have successfully retrieved the JSON from the API
        for (NSDictionary *repo in self.repos) { // 4
            NSString *repoName = repo[@"name"];
//            NSLog(@"repo: %@", repoName);
//            NSLog(@"repo count: %lu", (unsigned long)self.repos.count);
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                // This will run on the main queue
                [self.myTableView reloadData];
            }];
        }
        
        
    }]; // 5
    
    [dataTask resume]; // 6
    
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary *repo = [self.repos objectAtIndex:indexPath.row];
    cell.textLabel.text = repo[@"name"];
    NSLog(@"repo: %@", cell.textLabel.text);
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.repos.count;
}






@end

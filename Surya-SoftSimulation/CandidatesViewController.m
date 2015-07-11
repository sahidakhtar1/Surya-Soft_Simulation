//
//  CandidatesViewController.m
//  Surya-SoftSimulation
//
//  Created by Shaikh Shahid Akhtar on 10/07/15.
//  Copyright (c) 2015 Shaikh Shahid Akhtar. All rights reserved.
//

#import "CandidatesViewController.h"
#import "CandidateCell.h"
#import "RESTfulServiceHelper.h"
#import "ImageUitlity.h"
@interface CandidatesViewController ()
@property (nonatomic, strong) NSArray *allCandidates;
@end

static NSString* const FIRST_NAME_KEY = @"firstName";
static NSString* const LAST_NAME_KEY = @"lastName";
static NSString* const EMAILID_KEY = @"emailId";
static NSString* const IMAGEURL_KEY = @"imageUrl";
@implementation CandidatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tbCandidates setTableFooterView:[[UIView alloc] init]];
    
    self.tbCandidates.rowHeight = UITableViewAutomaticDimension;
    self.tbCandidates.estimatedRowHeight = 100.0;
    // Do any additional setup after loading the view.
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:self.emailId,@"emailId", nil];
    [[[RESTfulServiceHelper alloc] init] downloadDataFromUrl:@"http://surya-interview.appspot.com/list"
                                                  parameters:params method:POST sucess:^(NSDictionary *dict) {
                                                      if (dict != nil) {
                                                          self.allCandidates = [NSArray arrayWithArray:[dict objectForKey:@"items"]];
                                                          [self.tbCandidates reloadData];
                                                      }
                                                      
                                                  } failure:^(NSString *error) {
                                                      
                                                  }];
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = false;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
#pragma mark TableView Data Source And Delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.allCandidates count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *candidateCellIdentifier = @"CandidateCell";
    CandidateCell *cell = [tableView dequeueReusableCellWithIdentifier:candidateCellIdentifier];
    NSDictionary *dict = [self.allCandidates objectAtIndex:indexPath.row];
    NSString *fName;
    NSString *lName;
    NSString *email;
    fName = [dict valueForKey:FIRST_NAME_KEY];
    lName = [dict valueForKey:LAST_NAME_KEY];
    email = [dict valueForKey:EMAILID_KEY];
    cell.lblCandidateName.text = [NSString stringWithFormat:@"%@ %@",fName,lName];
    cell.candidateEmailId.text = email;
    cell.imgCandidateImage.image = nil;
    [ImageUitlity downloadImageFromUrl:[dict valueForKey:IMAGEURL_KEY]
                          forIndexPath:indexPath
                     completionHandler:^(UIImage * image,NSIndexPath *tIndexPath) {
                         
                         CandidateCell *tCell = (CandidateCell*)[tableView cellForRowAtIndexPath:tIndexPath];
                         tCell.imgCandidateImage.image = image;
    }];
    
    
    return cell;
}
@end

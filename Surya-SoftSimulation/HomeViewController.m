//
//  HomeViewController.m
//  Surya-SoftSimulation
//
//  Created by Shaikh Shahid Akhtar on 10/07/15.
//  Copyright (c) 2015 Shaikh Shahid Akhtar. All rights reserved.
//

#import "HomeViewController.h"

#import "CandidatesViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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
#pragma mark TextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self loadCandidatesView];
}
#pragma mark -
#pragma mark Utility Method
-(void)loadCandidatesView{
    if ([self validateEmailId:self.tfEmailid.text]) {
        CandidatesViewController *candidatesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CandidatesViewController"];
        [candidatesVC setEmailId:self.tfEmailid.text];
        [self.navigationController pushViewController:candidatesVC animated:YES];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Error!"
                                    message:@"Please enter valid email Id"
                                   delegate:nil
                          cancelButtonTitle:@"Okay"
                          otherButtonTitles: nil] show];
    }
}
-(BOOL)validateEmailId:(NSString*)emailId{
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if ([emailTest evaluateWithObject:emailId] == YES)
    {
        return true;
    }
    return false;
}
@end

//
//  CandidatesViewController.h
//  Surya-SoftSimulation
//
//  Created by Shaikh Shahid Akhtar on 10/07/15.
//  Copyright (c) 2015 Shaikh Shahid Akhtar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandidatesViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSString *emailId;
@property (weak, nonatomic) IBOutlet UITableView *tbCandidates;

@end

//
//  CandidateCell.h
//  Surya-SoftSimulation
//
//  Created by Shaikh Shahid Akhtar on 10/07/15.
//  Copyright (c) 2015 Shaikh Shahid Akhtar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandidateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgCandidateImage;
@property (weak, nonatomic) IBOutlet UILabel *lblCandidateName;
@property (weak, nonatomic) IBOutlet UILabel *candidateEmailId;
@end

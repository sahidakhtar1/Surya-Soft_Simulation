//
//  ImageUitlity.h
//  ANZSimulation
//
//  Created by Shahid Akhtar Shaikh on 5/13/15.
//  Copyright (c) 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImageUitlity : NSObject
+(void)downloadImageFromUrl:(NSString*)imageUrl
               forIndexPath:(NSIndexPath*)indexPath
          completionHandler:(void(^)(UIImage*,NSIndexPath*))handler;
@end

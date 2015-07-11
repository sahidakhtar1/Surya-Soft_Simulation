//
//  ImageUitlity.m
//  ANZSimulation
//
//  Created by Shahid Akhtar Shaikh on 5/13/15.
//  Copyright (c) 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "ImageUitlity.h"
@implementation ImageUitlity

+(void)downloadImageFromUrl:(NSString*)imageUrl
               forIndexPath:(NSIndexPath*)indexPath
          completionHandler:(void(^)(UIImage*,NSIndexPath*))handler{
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSString *lastPathComp = [imageUrl lastPathComponent];
            NSString* filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:lastPathComp];
            NSData *imageData = [NSData dataWithContentsOfFile:filePath];
            if (imageData != nil) {
                UIImage *image = [UIImage imageWithData:imageData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(image,indexPath);
                });
            }else{
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
                [imageData writeToFile:filePath atomically:YES];
                UIImage *image = [UIImage imageWithData:imageData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(image,indexPath);
                });
            }
     });
}
@end

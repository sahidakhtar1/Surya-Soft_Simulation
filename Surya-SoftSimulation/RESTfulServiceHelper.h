//
//  RESTfulServiceHelper.h
//  RESTfulServiceHelper
//
//  Created by Shahid Akhtar Shaikh on 5/11/15.
//  Copyright (c) 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import <Foundation/Foundation.h>
enum HTTP_METHOD_TYPE{
    GET,
    POST,
};
@interface RESTfulServiceHelper : NSObject<NSURLSessionDelegate>
-(void)downloadDataFromUrl:(NSString*)endPointUrl
                parameters:(NSDictionary*)params
                    method:(enum HTTP_METHOD_TYPE)methodType
                sucess:(void(^)(NSDictionary*))sucess
                failure:(void(^)(NSString*))failure;
@end

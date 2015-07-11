//
//  RESTfulServiceHelper.m
//  RESTfulServiceHelper
//
//  Created by Shahid Akhtar Shaikh on 5/11/15.
//  Copyright (c) 2015 Shahid Akhtar Shaikh. All rights reserved.
//

#import "RESTfulServiceHelper.h"

@interface RESTfulServiceHelper()

@end

@implementation RESTfulServiceHelper
-(void)downloadDataFromUrl:(NSString*)endPointUrl
                parameters:(NSDictionary*)params
                    method:(enum HTTP_METHOD_TYPE)methodType
                    sucess:(void(^)(NSDictionary*))sucess
                   failure:(void(^)(NSString*))failure{
    assert(endPointUrl);
    switch (methodType) {
        case GET:
            {
                [self getDataFromUrl:endPointUrl parameters:params sucess:^(NSData *downloadedData) {

                    
                } failure:^(NSString *erroeMsg) {
                    failure(erroeMsg);
                }];
            }
            break;
        case POST:
            {
                [self postDataFromUrl:endPointUrl parameters:params sucess:^(NSData *downloadedData) {
                    
//                       NSString *stringFromdata = [[NSString alloc] initWithData:downloadedData encoding:NSASCIIStringEncoding];
                        NSError *error = nil;
                        id obj = [NSJSONSerialization JSONObjectWithData:downloadedData options:NSJSONReadingMutableLeaves
                                                                   error:&error];
                        if (error == nil ) {
                            if ([obj isKindOfClass:[NSDictionary class]]) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    sucess(obj);
                                });
                            }else{
                               failure(@"Response is not a dictionary");
                            }
                            
                        }else{
                           failure([error localizedDescription]);
                        }
                    
                    
                } failure:^(NSString *erroeMsg) {
                    failure(erroeMsg);
                }];

            }
            break;
            
        default:
            break;
    }
    
}
-(void)getDataFromUrl:(NSString*)endPointUrl
           parameters:(NSDictionary*)params
               sucess:(void(^)(NSData*))sucess
              failure:(void(^)(NSString*))failure{
    if (params != nil) {
        endPointUrl =  [self addQueryStringToUrlString:endPointUrl withDictionary:params];
    }
    NSURLSessionConfiguration *sessionConfig =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfig setTimeoutIntervalForRequest:300];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfig
                                                             delegate:self
                                                        delegateQueue:nil];
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithURL:[NSURL URLWithString:endPointUrl]
                                               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                   if (error == nil) {
                                                       sucess(data);
                                                   }else{
                                                       NSInteger statusCode = 0;
                                                       if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                                           NSHTTPURLResponse *httpResponse  = (NSHTTPURLResponse*)response;
                                                           statusCode = [httpResponse statusCode];
                                                           NSLog(@"Status code= %ld",(long)statusCode);
                                                       }
                                                       failure(error.localizedDescription);
                                                   }
                                               }];
    [dataTask resume];
}
-(void)postDataFromUrl:(NSString*)endPointUrl
           parameters:(NSDictionary*)params
               sucess:(void(^)(NSData*))sucess
              failure:(void(^)(NSString*))failure{

    NSURLSessionConfiguration *sessionConfig =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfig
                                                             delegate:self
                                                        delegateQueue:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:endPointUrl]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:300.0];
    
    NSString *jsonString;
    NSData *jsonData;
    if (params != nil) {
        
        jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        [request setHTTPBody:jsonData];
    }
    
    [request addValue:@"application/json"  forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json"                   forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];

    
    
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:request
                                               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                   if (error == nil) {
                                                       sucess(data);
                                                   }else{
                                                       NSInteger statusCode = 0;
                                                       if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                                           NSHTTPURLResponse *httpResponse  = (NSHTTPURLResponse*)response;
                                                           statusCode = [httpResponse statusCode];
                                                           NSLog(@"Status code= %ld",(long)statusCode);
                                                       }
                                                       failure(error.localizedDescription);
                                                   }
                                               }];
    [dataTask resume];
}
-(NSString*)addQueryStringToUrlString:(NSString *)urlString withDictionary:(NSDictionary *)dictionary
{
    NSMutableString *urlWithQuerystring = [[NSMutableString alloc] initWithString:urlString];
    for (id key in dictionary) {
        NSString *keyString = [key description];
        NSString *valueString = [[dictionary objectForKey:key] description];
        
        if ([urlWithQuerystring rangeOfString:@"?"].location == NSNotFound) {
            [urlWithQuerystring appendFormat:@"?%@=%@", [self urlEscapeString:keyString], [self urlEscapeString:valueString]];
        } else {
            [urlWithQuerystring appendFormat:@"&%@=%@", [self urlEscapeString:keyString], [self urlEscapeString:valueString]];
        }
    }
    return urlWithQuerystring;
}
-(NSString*)urlEscapeString:(NSString *)unencodedString
{
    CFStringRef originalStringRef = (__bridge CFStringRef)unencodedString;
    NSString *s = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,originalStringRef, NULL, NULL,kCFStringEncodingUTF8);
    CFRelease(originalStringRef);
    return s ;
}


@end

//
//  ServerController.m
//  iOS_OUTDemo
//
//  Created by Sagar Kudale on 04/02/14.
//  Copyright (c) 2014 CUELogic. All rights reserved.
//

#import "ServerController.h"
#import "Constants.h"
#import "Reachability.h"
#import "ASIHTTPRequest.h"
#import "SBJsonWriter.h"
#import "ActivityAlertView.h"
#import "ASIFormDataRequest.h"
#import "Utils.h"


#define MSG_LOGIN @"Authenticating you, Please wait..."
#define MSG_PLEASE_WAIT @"Please wait..."
#define MSG_REGISTERING @"Registering. Please wait..."
#define MSG_LOADING_MERCANT_BIKES @"Loading vehicles. Please wait..."


@implementation ServerController{
    ActivityAlertView *actAlertView;
}

static ServerController *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (ServerController *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[ServerController alloc]init];
        
    }
    return sharedInstance;
}

#pragma mark-
#pragma mark======================
#pragma mark Private Methods
#pragma mark======================

-(BOOL)isNetworkAvailable{
    DebugLog(@"");
    
    NetworkStatus internetStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    
    if(internetStatus== NotReachable){
        return NO;
    }
    return YES;
    
}



- (void) sendServerRequestForLoginUserOrRegisterUserWithJsonDataDictionary:(NSDictionary *) jsonDataDic withServiceName:(NSString *) serviceName{
    DebugLog(@"");
    SBJsonWriter *writer = [SBJsonWriter new];
    NSString * jsonData = [writer stringWithObject:jsonDataDic];
    
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@%@",SERVICE_URL,serviceName];
    DebugLog(@"RequestURL : %@",url);
    
    NSString *safestring=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:safestring]];
    [request setShouldContinueWhenAppEntersBackground:NO];
    [request setDelegate:self];
    [request appendPostData:[jsonData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeOutSeconds:80];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request setRequestMethod:@"POST"];
    [request setDidFinishSelector:@selector(onDataFetchComplete:)];
    [request setDidFailSelector:@selector(onDataFetchFailed:)];
    [request setUserInfo:nil];
    [request startAsynchronous];
}

- (NSString *) getURLForServiceName:(NSString *)serviceName withDicData:(NSDictionary *) dicData
{
    DebugLog(@"");
    
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@%@",SERVICE_URL,serviceName];
    [url appendString:[self getUrlPartFromDictionary:dicData]];
    return url;
}

- (NSString *) getUrlPartFromDictionary:(NSDictionary *) dic
{
    DebugLog(@"");
    NSArray *keyArray = [dic allKeys];
    NSMutableString *urlPart = [NSMutableString stringWithFormat:@""];
    
    for (NSString *key in keyArray) {
        if (![urlPart isEqualToString:@""]) {
            [urlPart appendString:@"&"];
        }
        [urlPart appendString:[NSString stringWithFormat:@"%@=%@",key,[dic objectForKey:key]]];
    }
    
    return urlPart;
}

- (NSString *) getMessageForServiceName:(NSString *) serviceName
{
    DebugLog(@"");
    if ([serviceName isEqualToString:SERVICE_NAME_AUTHONTICATE]) {
        return MSG_LOGIN;
    }else if ([serviceName isEqualToString:SERVICE_NAME_REGISTER_USER]){
        return MSG_REGISTERING;
    }else if ([serviceName isEqualToString:SERVICE_MERCHANT_VEHICAL]){
        return MSG_LOADING_MERCANT_BIKES;
    }
    
    return MSG_PLEASE_WAIT;
}

#pragma mark-
#pragma mark======================
#pragma mark Upload Data to Server
#pragma mark======================

-(void)sendPOSTServiceRequestForService:(NSString *)serviceName withData:(NSDictionary *)dicData withDelegate:(id<ServiceControlerDelegate>) serviceDelegate{
    DebugLog(@"");
    [self setDelegate:serviceDelegate];
    
    if ([self isNetworkAvailable]) {
        actAlertView =[[ActivityAlertView alloc]initWithTitle:nil message:[self getMessageForServiceName:serviceName] delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [actAlertView showActivityIndicator];
        
        if ([serviceName isEqualToString:SERVICE_NAME_AUTHONTICATE] || [serviceName isEqualToString:SERVICE_NAME_REGISTER_USER]) {
            [self sendServerRequestForLoginUserOrRegisterUserWithJsonDataDictionary:dicData withServiceName:serviceName];
        }else{
            
            NSMutableString *url = [[self getURLForServiceName:serviceName withDicData:dicData] mutableCopy];
            DebugLog(@"RequestURL : %@",url);
            NSString *safestring=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:safestring]];
            [request setShouldContinueWhenAppEntersBackground:NO];
            [request setDelegate:self];
            [request setTimeOutSeconds:80];
            [request addRequestHeader:@"Content-Type" value:@"application/json"];
            [request setNumberOfTimesToRetryOnTimeout:2];
            [request setRequestMethod:@"POST"];
            [request setDidFinishSelector:@selector(onDataFetchComplete:)];
            [request setDidFailSelector:@selector(onDataFetchFailed:)];
            [request setUserInfo:nil];
            [request startAsynchronous];
        }
    }else{
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"No network connection found." withDelegate:nil];
    }
    
}

-(void)sendGETServiceRequestForService:(NSString *)serviceName withData:(NSDictionary *)dicData withDelegate:(id<ServiceControlerDelegate>) serviceDelegate
{
    DebugLog(@"");
    [self setDelegate:serviceDelegate];
    
    if ([self isNetworkAvailable])
    {
        actAlertView =[[ActivityAlertView alloc]initWithTitle:nil message:[self getMessageForServiceName:serviceName] delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [actAlertView showActivityIndicator];
        
        NSMutableString *url = [[self getURLForServiceName:serviceName withDicData:dicData] mutableCopy];
        DebugLog(@"RequestURL : %@",url);
        NSString *safestring=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:safestring]];
        [request setShouldContinueWhenAppEntersBackground:NO];
        [request setDelegate:self];
        [request setTimeOutSeconds:80];
        [request addRequestHeader:@"Content-Type" value:@"application/json"];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request setRequestMethod:@"GET"];
        [request setDidFinishSelector:@selector(onDataFetchComplete:)];
        [request setDidFailSelector:@selector(onDataFetchFailed:)];
        [request setUserInfo:nil];
        [request startAsynchronous];
    }else{
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"No network connection found." withDelegate:nil];
    }
    
}
#pragma mark-
#pragma mark======================
#pragma mark Server Response
#pragma mark======================

-(void)onDataFetchComplete:(ASIHTTPRequest *)request{
    DebugLog(@"");
    
    [actAlertView hideActivityIndicator];
    
    if([request responseData]!=nil)
    {
        NSDictionary* responseDict = [NSJSONSerialization
                                      JSONObjectWithData:[request responseData]
                                      options:kNilOptions
                                      error:nil];
        NSLog(@"%@",[responseDict debugDescription]);
        [self.delegate onDataFetchComplete:responseDict];
    }
}
-(void)onDataFetchFailed:(ASIHTTPRequest *)request{
    DebugLog(@"");
    
    [actAlertView hideActivityIndicator];
}

@end

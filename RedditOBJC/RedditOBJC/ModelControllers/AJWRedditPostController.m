//
//  AJWRedditPostController.m
//  RedditOBJC
//
//  Created by Austin West on 5/22/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

#import "AJWRedditPostController.h"
#import "AJWRedditPost.h"
#import <UIKit/UIKit.h>

static NSString * const baseURLString = @"http://www.reddit.com/.json";

@implementation AJWRedditPostController

+(instancetype)shared
{
    static AJWRedditPostController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [AJWRedditPostController new];
    });
    return shared;
}

- (void)fetchPosts:(void (^)(BOOL))completion
{
    NSURL *url = [[NSURL alloc] initWithString:baseURLString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching posts :%@", error.localizedDescription);
            completion(false);
            return;
        }
        
        if (!data) {
            NSLog(@"Data is missing");
            completion(false);
            return;
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSDictionary *dataDictionary = topLevelJSON[@"data"];
        
        NSArray<NSDictionary *> *childrenArray = dataDictionary[@"children"];
        
        NSMutableArray<AJWRedditPost *> *arrayOfPosts = [NSMutableArray new];
        
        for (NSDictionary *currentDictionary in childrenArray) {
            AJWRedditPost *post = [[AJWRedditPost alloc] initWithDictionary:currentDictionary];
            [arrayOfPosts addObject:post];
        }
        
        AJWRedditPostController.shared.posts = arrayOfPosts;
        completion(true);
    }] resume];
}

- (void)fetchImageForPost:(AJWRedditPost *)post completion:(void (^)(UIImage * _Nullable))completion
{
    
    NSURL *url = [NSURL URLWithString:post.thumbnail];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching imageL %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (!data) {
            NSLog(@"Data is missing for image");
            completion(nil);
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        completion(image);
        
        
    }]resume];
}

@end


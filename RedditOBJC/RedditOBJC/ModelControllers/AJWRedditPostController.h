//
//  AJWRedditPostController.h
//  RedditOBJC
//
//  Created by Austin West on 5/22/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AJWRedditPost;

NS_ASSUME_NONNULL_BEGIN

@interface AJWRedditPostController : NSObject

@property (nonatomic, copy) NSArray<AJWRedditPost *> *posts;

+(instancetype) shared;

-(void)fetchPosts:(void (^)(BOOL))completion;

-(void)fetchImageForPost:(AJWRedditPost *)post completion:(void (^) (UIImage * _Nullable))completion;

@end


NS_ASSUME_NONNULL_END

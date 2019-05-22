//
//  AJWRedditPost.h
//  RedditOBJC
//
//  Created by Austin West on 5/22/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJWRedditPost : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy, nullable) NSString *thumbnail;

-(instancetype) initWithTitle:(NSString *)title thumbnail:(NSString *)thumbnail;

@end

@interface AJWRedditPost (JSONConvertable)

-(instancetype) initWithDictionary:(NSDictionary<NSString *,id> *)dictionary;

@end

NS_ASSUME_NONNULL_END

//
//  AJWRedditPost.m
//  RedditOBJC
//
//  Created by Austin West on 5/22/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

#import "AJWRedditPost.h"

@implementation AJWRedditPost

-(instancetype)initWithTitle:(NSString *)title thumbnail:(NSString *)thumbnail
{
    self = [super init];
    if (self)
    {
        _title = title;
        _thumbnail = thumbnail;
    }
    return self;
}

@end

@implementation AJWRedditPost (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSDictionary *data = dictionary[@"data"];
    NSString *title = data[@"title"];
    NSString *thumbnail = data[@"thumbnail"];
    
    return [self initWithTitle:title thumbnail:thumbnail];
}

@end

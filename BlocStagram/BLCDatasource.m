//
//  BLCDatasource.m
//  BlocStagram
//
//  Created by Coby West on 4/29/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BLCDatasource.h"
#import "BLCUser.h"
#import "BLCMedia.h"
#import "BLCComment.h"
#import "ImagesTableViewController.h"

@interface BLCDatasource ()

@end

@implementation BLCDatasource

+ (instancetype) sharedInstace {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype) init
{
    self = [super init];
    
    if (self)
    {
        [self addRandomData];
    }
    
    return self;
}

- (void) addRandomData
{
    NSMutableArray *randomMediaItems = [NSMutableArray array];
    
    for (int index = 1; index <= 10; index++)
    {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", index];
        UIImage *image = [UIImage imageNamed: imageName];
        
        if (image)
        {
            BLCMedia *media = [[BLCMedia alloc] init];
            media.user = [self randomUser];
            media.image = image;
            
            NSUInteger commentCount = arc4random_uniform(10);
            NSMutableArray *randomComments = [NSMutableArray array];
            
            for (int i = 0; i <= commentCount; i++)
            {
                BLCComment *randomComment = [self randomComment];
                [randomComments addObject:randomComment];
            }
            
            media.comments = randomComments;
            
            [randomMediaItems addObject:media];
        }
    }
    self.mediaItems = randomMediaItems;
}

- (BLCUser *) randomUser
{
    BLCUser *user = [[BLCUser alloc] init];
    
    user.userName = [self randomCapitolStringOfLength:( 3+ arc4random_uniform(7))];
    
    NSString *firstName = [self randomCapitolStringOfLength: (1 +arc4random_uniform(7))];
    NSString *lastName = [self randomCapitolStringOfLength: (1 + arc4random_uniform(12))];
    user.fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    return user;
}

- (BLCComment *) randomComment
{
    BLCComment *comment = [[BLCComment alloc] init];
    
    comment.from = [self randomUser];
    
    NSInteger wordCount = (1+arc4random_uniform(20));
    
    NSMutableString *randomSentence = [[NSMutableString alloc] init];
    
    for (int i = 0; i <= wordCount; i++)
    {
        NSString *randomWord = [self randomStringOfLength:(1 + arc4random_uniform(12))];
        [randomSentence appendFormat:@"%@ ", randomWord];
    }
    
    comment.text = randomSentence;
    
    return comment;
}

- (NSString *) randomStringOfLength: (NSUInteger) length
{
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyz";
    
    NSMutableString *randomStringToBeReturned = [NSMutableString string];
    for (NSUInteger i = 0U; i < length; i++)
    {
        u_int32_t randomIndex = arc4random_uniform((u_int32_t) [alphabet length]);
        unichar characterToBeAppended = [alphabet characterAtIndex:randomIndex];
        [randomStringToBeReturned appendFormat:@"%C", characterToBeAppended];
    }
    
    return [NSString stringWithString: randomStringToBeReturned];
}


- (NSString *) randomCapitolStringOfLength: (NSUInteger) length
{
    NSString *upperAlphabet = @"ABCDEFGHIJKLMNOPQRSTUVQXYZ";
    NSString *lowerAlphabet = @"abcdefghijklmnopqrstuvwxyz";
    NSUInteger alphaLegth = upperAlphabet.length;
    
    NSMutableString *randomStringToBeReturned = [NSMutableString string];
    for (NSUInteger i = 0U; i < length; i++)
    {
        if ( i ==0 )
        {
            u_int32_t randomIndex = arc4random_uniform((u_int32_t) alphaLegth);
            unichar characterToBeAppended = [upperAlphabet characterAtIndex:randomIndex];
            [randomStringToBeReturned appendFormat:@"%C", characterToBeAppended];
        }
        else
        {
            u_int32_t randomIndex = arc4random_uniform((u_int32_t) alphaLegth);
            unichar characterToBeAppended = [lowerAlphabet characterAtIndex:randomIndex];
            [randomStringToBeReturned appendFormat:@"%C", characterToBeAppended];
        }
        
    }
    
    return [NSString stringWithString: randomStringToBeReturned];
}

@end

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
#import "BLCLoginViewController.h"

@interface BLCDatasource ()
{
    NSMutableArray *_mediaItems;
}

@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL isLoadingOlderItems;

@property (nonatomic, strong) NSString *accessToken;

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
        [self registerForAccessTokenNotification];
    }
    
    return self;
}

- (void) registerForAccessTokenNotification {
    [[NSNotificationCenter defaultCenter] addObserverForName:BLCLoginViewControllerDidGetAccessTokenNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.accessToken = note.object;
    }];
}

#pragma mark - Key/Value Observing

- (NSUInteger) countOfMediaItems {
    return self.mediaItems.count;
}

-(id) objectInMediaItemsAtIndex:(NSUInteger)index {
    return [self.mediaItems objectAtIndex:index];
}

-(NSArray *) mediaItemsAtIndexes:(NSIndexSet *)indexes {
    return [self.mediaItems objectsAtIndexes:indexes];
}

-(void) insertObject:(BLCMedia *)object inMediaItemsAtIndex:(NSUInteger)index {
    [_mediaItems insertObject:object atIndex:index];
}

-(void) removeObjectFromMediaItemsAtIndex:(NSUInteger)index {
    [_mediaItems removeObjectAtIndex:index];
}

-(void) replaceObjectInMediaItemsAtIndex:(NSUInteger)index withObject:(id)object {
    [_mediaItems replaceObjectAtIndex:index withObject:object];
}

- (void) deleteMediaItem:(BLCMedia *)item {
    NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
    
    [mutableArrayWithKVO removeObject:item];
}

#pragma - Get new/old items

-(void) requestNewItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler {
    if (!self.isRefreshing) {
        self.isRefreshing = YES;
        
        //add new images
        
        self.isRefreshing = NO;
        
        if (completionHandler) {
            completionHandler(nil);
        }
    }
}

-(void) requestOldItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler {
    if (!self.isLoadingOlderItems) {
        self.isLoadingOlderItems = YES;
        //add older images
        
        self.isLoadingOlderItems = NO;
        
        if(completionHandler) {
            completionHandler(nil);
        }
    }
}

#pragma - Instagram Information

+(NSString *) instagramClientID {
    return @"3812965b7a874c31be26294282de297a";
}

@end

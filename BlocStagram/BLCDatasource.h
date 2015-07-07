//
//  BLCDatasource.h
//  BlocStagram
//
//  Created by Coby West on 4/29/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BLCMedia;

typedef void (^BLCNewItemCompletionBlock)(NSError *error);

@interface BLCDatasource : NSObject

+(instancetype) sharedInstace;
@property (nonatomic, strong) NSMutableArray *mediaItems;

-(void) deleteMediaItem: (BLCMedia *) item;

-(void) requestNewItemsWithCompletionHandler: (BLCNewItemCompletionBlock) completionHandler;
-(void) requestOldItemsWithCompletionHandler: (BLCNewItemCompletionBlock) completionHandler;

@end

//
//  BLCDatasource.h
//  BlocStagram
//
//  Created by Coby West on 4/29/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BLCMedia;

@interface BLCDatasource : NSObject

+(instancetype) sharedInstace;
@property (nonatomic, strong) NSMutableArray *mediaItems;

-(void) deleteMediaItem: (BLCMedia *) item;

@end

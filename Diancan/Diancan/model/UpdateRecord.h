//
//  UpdateRecord.h
//  Diancan
//
//  Created by 李炜 on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UpdateRecord : NSManagedObject

@property (nonatomic, retain) NSDate * updateTime;

@end

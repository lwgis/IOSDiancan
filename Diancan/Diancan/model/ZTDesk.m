//
//  Desk.m
//  Diancan
//
//  Created by 李炜 on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZTDesk.h"


@implementation ZTDesk

@synthesize dCapacity;
@synthesize dID;
@synthesize dName;

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.dID forKey:@"dID"];
	[coder encodeObject:self.dName forKey:@"dName"];
	[coder encodeObject:self.dCapacity forKey:@"dCapacity"];
}


- (id)initWithCoder:(NSCoder *)coder {
	self = [super init];
	if (self != nil) {
		self.dID = [coder decodeObjectForKey:@"dID"];
		self.dName = [coder decodeObjectForKey:@"dName"];
		self.dCapacity = [coder decodeObjectForKey:@"dCapacity"];
	}
	return self;
}
@end

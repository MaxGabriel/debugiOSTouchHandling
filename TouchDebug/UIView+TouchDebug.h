//
//  UIView+TouchDebug.h
//  TouchDebug
//
//  Created by Maximilian Tagher on 12/17/12.
//  Copyright (c) 2012 Max. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TouchDebug)

@property (nonatomic, readonly, copy) NSArray *siblings;

//- (NSArray *)recursiveAllSubviews;

- (void)debugTouchHandling;

@end

//
//  UIView+TouchDebug.m
//  TouchDebug
//
//  Created by Maximilian Tagher on 12/17/12.
//  Copyright (c) 2012 Max. All rights reserved.
//

#import "UIView+TouchDebug.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (TouchDebug)

- (void)debugTouchHandling
{
    // Debug frame not containing subview:
    UIView *subview = self;
    
    
    // Debug gesture recognizers:
    NSArray *gestureRecognizers = subview.gestureRecognizers;
    if (![gestureRecognizers count]) {
        NSLog(@"UIView+TouchDebug: The view %@ does not have any gesture recognizers",subview);
    }
    
    // Debug UIControl target-action pairs
    if ([subview isKindOfClass:[UIControl class]]) {
        
        UIControl *control = (UIControl *)subview;
        NSSet *targets = control.allTargets;
        if ([targets count] == 0) {
            NSLog(@"UIView+TouchDebug: The UIControl %@ has no targets in its target-action pairs",control);
        } else if ([targets count] > 1) {
            NSLog(@"UIView+TouchDebug: The UIControl %@ has multiple targets in its target-action pairs. Not wrong, but may be a warning flag",control);
        }
        
        UIControlEvents events = [control allControlEvents];
        if (!(events & UIControlEventAllTouchEvents)) {
            NSLog(@"The UIControl %@ wasn't handling any touch events",control);
        }
    }

    
    // Debug a subview not being within its superview's bounds. 
    UIView *superview = subview.superview;
    if (!superview) {
        NSLog(@"The view being debugged, %@, doesn't have a superview",self);
        if (self.userInteractionEnabled == NO) {
            NSLog(@"UIView+TouchDebug: The view %@ is does not have user interaction enabled and cannot receive touch events",self);
        }
        if (self.hidden == YES) {
            NSLog(@"UIView+TouchDebug: The view %@ is hidden and cannot receive touch events",self);
        }
        
    }
    // Debug superviews not containing self, or superviews being hidden/not interaction enabled
    while (superview != nil) {
        if (!CGRectContainsRect(superview.bounds, subview.frame)) {
            NSLog(@"UIView+TouchDebug: The superview %@'s bounds: %@ do not contain it's subview, %@,'s frame: %@",superview, NSStringFromCGRect(superview.bounds),subview,NSStringFromCGRect(subview.frame));
        }
        if (superview.userInteractionEnabled == NO) {
            NSLog(@"UIView+TouchDebug: The view %@ does not have user interaction enabled -- it's subviews will not be able to receive touch events.",superview);
        }
        if (superview.hidden == YES) {
            NSLog(@"UIView+TouchDebug: The view %@ is hidden and cannot receive touch events",superview);
        }
        
        subview = superview;
        superview = superview.superview;
        
    }
    
    // Debug other view's in the hierarchy overlapping self
    // (Grab all the siblings and check all their subviews, and when finished, go one level up the chain.
    UIView *sender = self;
    while (sender.superview != nil) {
        for (UIView *sibling in sender.siblings) {
            for (UIView *view in [sibling recursiveAllSubviewsAndSelf]) {
                if ([view intersectsView:self]) {
                    NSLog(@"View %@ intersects the %@",view,self);
                }
            }
            

        }
        sender = sender.superview;
    }

}

- (BOOL)intersectsView:(UIView *)view
{
    return CGRectIntersectsRect([view.superview convertRect:view.frame toView:nil], [self.superview convertRect:self.frame toView:nil]);
}

- (NSArray *)siblings
{
    NSMutableSet *allSubviews = [NSMutableSet setWithArray:self.superview.subviews];
    [allSubviews minusSet:[NSSet setWithObject:self]];
    return [[allSubviews allObjects] copy];
}

- (NSArray *)recursiveAllSubviewsAndSelf
{
    NSArray *subviews = @[self];
    for (UIView *subview in self.subviews) {
        subviews = [subviews arrayByAddingObject:subview];
        subviews = [subviews arrayByAddingObjectsFromArray:[subview recursiveAllSubviews]];
    }
    return subviews;
}

- (NSArray *)recursiveAllSubviews
{
    NSArray *subviews = @[];
    for (UIView *subview in self.subviews) {
        subviews = [subviews arrayByAddingObject:subview];
        subviews = [subviews arrayByAddingObjectsFromArray:[subview recursiveAllSubviews]];
    }
    return subviews;
}

//            for (UIView *nephew in sibling.subviews) {
//                if ([nephew intersectsView:self]) {
//
//                    NSLog(@"UIView+TouchDebug: View %@ intersects the receiver.",nephew);
//                }
//                for (UIView *child in [nephew recursiveAllSubviews]) {
//                    if ([self intersectsView:child]) {
//                        NSLog(@"UIView+TouchDebug: View %@ intersects the receiver.",child);
//                    }
//                }
//            }

@end

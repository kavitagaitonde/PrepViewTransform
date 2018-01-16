//
//  ViewController.m
//  PrepViewTransform
//
//  Created by Kavita Gaitonde on 1/15/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

BOOL isDragging = NO;
CGFloat prevX;
CGFloat prevY;
UIView *object;
UIView *box;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect1 = CGRectMake(200, 300, 20 , 20);
    object = [[UIView alloc] initWithFrame:rect1];
    object.backgroundColor = [UIColor redColor];
    object.userInteractionEnabled = YES;
    object.tag = 100;
    [self.view addSubview:object];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [object addGestureRecognizer:panGesture];
    
    CGRect rect2 = CGRectMake(10, 10, 100 , 100);
    box = [[UIView alloc] initWithFrame:rect2];
    box.backgroundColor = [UIColor blueColor];
    box.tag = 101;
    [self.view addSubview:box];
}

- (void) handlePanGesture:(id)sender {
    CGPoint location = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        prevX = [sender view].center.x;
        prevY = [sender view].center.y;
    } else if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        CGPoint newLocation = CGPointMake(prevX+location.x, prevY+location.y);
        [sender view].center = newLocation;
         [self.view bringSubviewToFront:object];
    } else if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        CGPoint endLocation = [sender locationInView:self.view];
        if (CGRectContainsPoint(box.frame, endLocation)) {
            NSLog(@"Inside the box");
            [self.view bringSubviewToFront:object];
        } else {
            NSLog(@"NOT Inside the box");
            CGPoint newLocation = CGPointMake(prevX, prevY);
            object.center = newLocation;
            
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    isDragging = YES;
    prevLocation = touchLocation;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesMoved");
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    if (isDragging) {
        object.center = touchLocation;
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesEnded");
    UITouch *touch = [touches anyObject];
    isDragging = NO;
    CGPoint touchLocation = [touch locationInView:self.view];
    if (CGRectContainsPoint(box.frame, touchLocation)) {
        NSLog(@"Inside the box");
    } else {
        NSLog(@"NOT Inside the box");
        object.center = prevLocation;
        [self.view bringSubviewToFront:object];
    }
}*/

@end

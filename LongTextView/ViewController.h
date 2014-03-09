//
//  ViewController.h
//  LongTextView
//
//  Created by Sagi Rorlich on 3/9/14.
//  Copyright (c) 2014 Sagi Rorlich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>



@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end

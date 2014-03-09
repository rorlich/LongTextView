//
//  PALongTextView.h
//  LongTextView
//
//  Created by Sagi Rorlich on 3/9/14.
//  Copyright (c) 2014 Sagi Rorlich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PALongTextView : UIView<UIScrollViewDelegate>



@property (nonatomic,copy) NSString* text;

@property (nonatomic,strong) UIScrollView* scrollView;
@property (nonatomic,strong) UIPageControl* pageControl;

@end

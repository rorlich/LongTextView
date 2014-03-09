//
//  PALongTextView.m
//  LongTextView
//
//  Created by Sagi Rorlich on 3/9/14.
//  Copyright (c) 2014 Sagi Rorlich. All rights reserved.
//

#import "PALongTextView.h"

@interface PALongTextView()

@property (nonatomic,strong) NSArray* sectionViews;

@end

@implementation PALongTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];

    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if  ( self) {
        [self baseInit];
    }
    return self;
}


-(void)baseInit {
    
    CGRect scrollFrame = self.bounds;
    scrollFrame.size.height -=40;
    
    CGRect pageControlFrame = self.bounds;
    pageControlFrame.size.height = 40;
    pageControlFrame.origin.y = scrollFrame.origin.y + scrollFrame.size.height;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate  = self;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:pageControlFrame];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    
}
-(void)layoutSubviews {
    [super layoutSubviews];

}


-(void)setText:(NSString *)text {
    _text = text;
    [self calculate];
}


-(void)calculate {

    if ( self.sectionViews) {
        for ( UIView* view in self.sectionViews)
             [view removeFromSuperview];
        self.sectionViews = nil;
    }
    
    NSMutableArray *words = [NSMutableArray arrayWithArray: [self.text componentsSeparatedByString:@" "]];
    
    
    
    UILabel* testLabel = [[UILabel alloc] initWithFrame:self.scrollView.bounds];
    testLabel.numberOfLines = 20;
    testLabel.text  = @"Text";
    CGSize currentSize = testLabel.frame.size;
    currentSize.width -= 50;
    
    CGSize bestSize =  [testLabel sizeThatFits:currentSize];
    int lineHeight = bestSize.height;
    
    
    //int pages = ceilf(bestSize.height/currentSize.height);
    int pages = 0;
    int cursur = 0;
    NSMutableArray* texts = [[NSMutableArray alloc] init];
    NSMutableString* section = [[NSMutableString alloc] init];
    
    while ( cursur < words.count) {
        
        // Get next word
        NSString* word = [words objectAtIndex:cursur];
        
        // Append
        [section appendFormat:@"%@ ",word ];
        
        // Set Text & Check the new size
        testLabel.text = section;
        CGSize bestSize = [testLabel sizeThatFits:currentSize];
        
        if (  bestSize.height+lineHeight >= currentSize.height) {
            [texts addObject:[section copy] ];
            [section setString:@""];
        }
        cursur++;
        
    }
    // Add the last part
    [texts addObject:[section copy] ];
    
    
    pages = texts.count;
    
    NSMutableString* resultString = [[NSMutableString alloc] init];
    for ( NSString* section in texts)
        [resultString appendFormat:@"%@ ",section];
    
    
    NSMutableArray* textViews = [NSMutableArray arrayWithCapacity:texts.count];
    NSArray* colors = [NSArray arrayWithObjects:[UIColor yellowColor],[UIColor redColor],[UIColor blueColor], nil];
    
    int i=0;
    for ( NSString* text in texts) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        UIView* view = [[UIView alloc] initWithFrame:frame];
        view.backgroundColor = [UIColor grayColor];
        
        
        CGRect labelFrame = self.scrollView.bounds;
        labelFrame.origin.x+=25;
        labelFrame.size.width -=50;
        
        UILabel* label = [[UILabel alloc] initWithFrame:labelFrame];
        
        label.numberOfLines = 100;
        label.text  = text;
        [label sizeToFit];
        label.backgroundColor = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
        
        // int colorIndex = i% colors.count;
        // label.backgroundColor = [colors objectAtIndex:colorIndex];
        //        UITextView* textView = [[UITextView alloc] initWithFrame:frame];
        //      textView.text = text;
        
        [view addSubview:label];
        [self.scrollView addSubview:view];
        [textViews addObject:view];
        i++;
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [texts count], self.scrollView.frame.size.height);
    
    self.pageControl.numberOfPages = texts.count;
    self.pageControl.currentPage = 0;

    
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

@end

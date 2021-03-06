//
//  ViewController.m
//  LongTextView
//
//  Created by Sagi Rorlich on 3/9/14.
//  Copyright (c) 2014 Sagi Rorlich. All rights reserved.
//

#import "ViewController.h"
#import "PALongTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.longTextView.text = @"This text, is a very boring text and I bet you will not manage to read the whole text since the only period in the text is the one that ends the whole text that is by the way so long and pointless that writing it is just as fun as the text becomes boring since it is so long and pointless and also quite boring since it does not happen a single thing the whole time it is going on which is very long so you will probably not even manage reading to this point which is somewhere halfway and yet you do incredibly as it is since you are reading these words in this long and boring text where nothing happens at all but you will probably stop reading soon as it is just too boring and long and pointless and I notice you are still reading my boring text and wonder how you can withstand it since it is so long and boring plus there is more fun things to do that I would prefer to do rather than reading this soulless text that is really damn boring and now even I am starting to get tired of it so now I am cutting it out.";
    
}


-(void)viewWillAppear:(BOOL)animated {

   
    /*
    NSString* longText = @"This text, is a very boring text and I bet you will not manage to read the whole text since the only period in the text is the one that ends the whole text that is by the way so long and pointless that writing it is just as fun as the text becomes boring since it is so long and pointless and also quite boring since it does not happen a single thing the whole time it is going on which is very long so you will probably not even manage reading to this point which is somewhere halfway and yet you do incredibly as it is since you are reading these words in this long and boring text where nothing happens at all but you will probably stop reading soon as it is just too boring and long and pointless and I notice you are still reading my boring text and wonder how you can withstand it since it is so long and boring plus there is more fun things to do that I would prefer to do rather than reading this soulless text that is really damn boring and now even I am starting to get tired of it so now I am cutting it out.";
    
    NSMutableArray *words = [NSMutableArray arrayWithArray: [longText componentsSeparatedByString:@" "]];
    
    
    
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
    
    
    
    // TEST
    NSMutableString* resultString = [[NSMutableString alloc] init];
    for ( NSString* section in texts)
        [resultString appendFormat:@"%@ ",section];
    
    int originalLen = longText.length;
    int len = resultString.length;
    
    
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
    */
    
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

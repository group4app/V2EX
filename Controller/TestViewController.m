//
//  TestViewController.m
//  V2EX
//
//  Created by Chris Huang on 14-7-31.
//  Copyright (c) 2014年 group4app. All rights reserved.
//

#import "TestViewController.h"
#import "SymbolAttributedLabel.h"
#import "UIView+Xib.h"

#import "AppClient.h"
#import <HTMLReader.h>

#import "Topic.h"
#import "TopicParser.h"
#import "Reply.h"
#import "ReplyParser.h"
#import "TestView.h"
#import "UIView+Frame.h"

@interface CMTextAttachment : NSTextAttachment

@end

@implementation CMTextAttachment

//- (CGRect) attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex{
//    
//    CGRect bound;
//    bound.origin = CGPointMake(0, 0);
//    bound.size = CGSizeMake(100, 100);
//    
//    return bound;
//}

@end

@interface TestViewController (){

//    SymbolAttributedLabel *label;
    UITextView *label;
    
}

@property(nonatomic,weak) IBOutlet UILabel      *label;

@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    
}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSString *key = @"hello";
    NSString *text = @"sfsdfs,sdfsd2w sdfo2,sdf dflsd fsefow rpwf sd flsfs ofsld kfmsd kfsldfsdfds";
    
    TestView *testView = (TestView*)[TestView viewFromXib];
//    testView.frame = CGRectMake(10, 100, 200, 400);
    testView.keyLabel.text = key;
    testView.contentLabel.text = text;
    [self.view addSubview:testView];
    
//    CGFloat preferredWidth = testView.contentLabel.preferredMaxLayoutWidth;
//    testView.contentLabel.preferredMaxLayoutWidth = 162;
    CGSize size = [testView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"size = (%.2f,%.2f)",size.width,size.height);
    testView.sizeH = size.height;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    label = [[UITextView alloc] initWithFrame:CGRectMake(10, 30, 300, 300)];
//    label.editable = NO;
//    label.selectable = YES;
////    label = [[SymbolAttributedLabel alloc] initWithFrame:CGRectMake(10, 30, 300, 300)];
////    label.numberOfLines = 0;
//    label.font = [UIFont systemFontOfSize:20];
//    label.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:label];
//    
//    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:@"first line\nhello\n world \nhttp://www.baidu.com \n hrx00747@gmail.com  \n @hrx"];
//    label.attributedText = attrText;
//    label.dataDetectorTypes = UIDataDetectorTypeAddress;
//    label.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor redColor]};
//    
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 360, 120, 40)];
//    [button setTitle:@"Press" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"before after"];
//    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
//    textAttachment.image = [UIImage imageNamed:@"arrow.png"];
//    
//    CGFloat oldWidth = textAttachment.image.size.width;
//    
//    //I'm subtracting 10px to make the image display nicely, accounting
//    //for the padding inside the textView
//    CGFloat scaleFactor = oldWidth / (label.frame.size.width - 100);
//    textAttachment.image = [UIImage imageWithCGImage:textAttachment.image.CGImage scale:scaleFactor orientation:UIImageOrientationUp];
//    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
//    [attributedString replaceCharactersInRange:NSMakeRange(6, 1) withAttributedString:attrStringWithImage];
//    label.attributedText = attributedString;
    
    
    
}

- (void) buttonPressed:(id)sender{
    
    UIImage *image = [UIImage imageNamed:@"arrow.png"];
    image = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationUp];
    CMTextAttachment *attach = [[CMTextAttachment alloc] init];
    attach.image = image;
    NSAttributedString *attrImage = [NSAttributedString attributedStringWithAttachment:attach];
    
    NSMutableAttributedString *attrText = [label.attributedText mutableCopy];
    [attrText replaceCharactersInRange:NSMakeRange(17, 1) withAttributedString:attrImage];
    
    label.attributedText = attrText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

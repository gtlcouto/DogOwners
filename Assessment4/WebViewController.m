//
//  WebViewController.m
//  Assessment4
//
//  Created by Gustavo Couto on 2015-01-30.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRequestFromString:@"http://www.saveuspets.org/"];
    self.webView.delegate = self;

    NSLog(@"WebView: %@", self  .webView);
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.spinner startAnimating];
    self.spinner.hidden = FALSE;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner stopAnimating];
    self.spinner.hidden = true;
}


//HELPER FUNCTIONS

#pragma mark HELPER METHODS

-(void)loadRequestFromString:(NSString *)stringAddress
{
    NSString *addressString = stringAddress;
    NSURL *addressURL = [NSURL URLWithString:addressString];
    NSURLRequest *addressRequest = [NSURLRequest requestWithURL:addressURL];
    [self.webView loadRequest:addressRequest];
}


@end

//
//  MPViewController.m
//  FileManager
//
//  Created by Alex Manzella on 31/05/14.
//  Copyright (c) 2014 mpow. All rights reserved.
//

#import "MPViewController.h"

@interface MPViewController ()

@end

@implementation MPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    mangaer=[[MPImageManager alloc] init];
    
    imageView=[[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageView];
    
    [mangaer getImageWithUrl:@"http://miriadna.com/desctopwalls/images/max/Ideal-landscape.jpg" andComplentionblock:^(UIImage *image) {
        imageView.image=image;
    }];
    
        
}





- (void
   
   
   )didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ObjectiveCSearch.m
//  git-search
//
//  Created by Matheus Rocco Ferreira on 06/11/16.
//  Copyright © 2016 Rocco. All rights reserved.
//

#import "ObjectiveCSearch.h"


@implementation ObjectiveCSearch

// Get image from url
+ (void)imageForUrl:(NSString*) baseUrl
         completion:(void ( ^ ) ( BOOL success , UIImage *image ))completionHandler {
    
    // build url
    NSURL *url = [[NSURL alloc] initWithString:baseUrl];
    
    // retrieve data
    NSData *imgData = [[NSData alloc] initWithContentsOfURL:url];
    
    // create uiimage
    UIImage *img = [[UIImage alloc] initWithData:imgData];
    
    //call completion
    completionHandler(true, img);
    
}

@end

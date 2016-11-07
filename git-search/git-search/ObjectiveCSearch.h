//
//  ObjectiveCSearch.h
//  git-search
//
//  Created by Matheus Rocco Ferreira on 06/11/16.
//  Copyright © 2016 Rocco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ObjectiveCSearch : NSObject

// Get image from url
+ (void)imageForUrl:(NSString*) url completion:(void ( ^ ) ( BOOL success , UIImage *image ))completionHandler;


@end

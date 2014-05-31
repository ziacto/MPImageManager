//
//  MPFileManager.h
//  FileManager
//
//  Created by Alex Manzella on 31/05/14.
//  Copyright (c) 2014 mpow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPImageManager : NSObject{
    
    NSCache *cache;
}

typedef void(^MPSetImage)(UIImage *image);

- (void)getImageWithUrl:(NSString *)url andComplentionblock:(MPSetImage)complentionBlock;
- (void)downloadImageWithUrl:(NSString *)url withComplentionblock:(MPSetImage)complentionBlock;
- (void)saveImage:(UIImage *)image withName:(NSString *)name;
- (UIImage *)getImageFromCahche:(NSString *)name;


@end

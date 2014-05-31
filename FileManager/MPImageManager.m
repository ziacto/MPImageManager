//
//  MPFileManager.m
//  FileManager
//
//  Created by Alex Manzella on 31/05/14.
//  Copyright (c) 2014 mpow. All rights reserved.
//

#import "MPImageManager.h"

@interface NSString (FileSystemSafety)

@end

@implementation NSString (FileSystemSafety)
- (NSString *)stringSafeForFilesystem{
    return [[[[self stringByReplacingOccurrencesOfString:@"/" withString:@"_"] stringByReplacingOccurrencesOfString:@":" withString:@"_"] stringByReplacingOccurrencesOfString:@"." withString:@"_"] stringByReplacingOccurrencesOfString:@"?" withString:@"_"];
}
@end

@implementation MPImageManager


- (void)getImageWithUrl:(NSString *)url andComplentionblock:(MPSetImage)complentionBlock{
 
    if (!cache) {
        cache=[[NSCache alloc] init];
    }
    
    NSString *prettyName=[url stringSafeForFilesystem];
    
    UIImage *image=[cache objectForKey:prettyName];
    
    if(image){
        
        NSLog(@"Was In memory cache");
        complentionBlock(image);
        
        return;
    }
    
    
    image=[self getImageFromCahche:prettyName];
    
    if (image) {
        
        NSLog(@"Was In cache");
        
        [cache setObject:image forKey:prettyName];
        
        complentionBlock(image);
        
    }else{
        
        [self downloadImageWithUrl:url withComplentionblock:complentionBlock];
        
    }
    
}

- (void)downloadImageWithUrl:(NSString *)url withComplentionblock:(MPSetImage)complentionBlock{
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSLog(@"Downloaded");

        
        UIImage *image=[UIImage imageWithData:data];
        
        if (!image) {
            return ;
        }
        
        [self saveImage:image withName:[url stringSafeForFilesystem]];
        
        complentionBlock(image);
        
        
    }];
    
}

- (void)saveImage:(UIImage *)image withName:(NSString *)name{
    
    NSLog(@"saved");
    
    [cache setObject:image forKey:name];
    
    [UIImagePNGRepresentation(image) writeToFile:[[@"~/Library/Caches" stringByExpandingTildeInPath] stringByAppendingPathComponent:name] atomically:YES];
    
}


- (UIImage *)getImageFromCahche:(NSString *)name{
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[[@"~/Library/Caches" stringByExpandingTildeInPath] stringByAppendingPathComponent:name]]) {
        
        return [UIImage imageWithContentsOfFile:[[@"~/Library/Caches" stringByExpandingTildeInPath] stringByAppendingPathComponent:name]];
    }
    
    return  nil;
}







@end

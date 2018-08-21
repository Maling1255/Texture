//
//  Utilities.h
//  Texture
//
//  Copyright (c) 2017-present, Pinterest, Inc.  All rights reserved.
//  Licensed under the Apache License, Version 2.0 (the "License").
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (Additions)
+ (UIColor *)darkBlueColor;
+ (UIColor *)lightBlueColor;
@end

@interface UIImage (Additions)
- (UIImage *)makeCircularImageWithSize:(CGSize)size withBorderWidth:(CGFloat)width;
+ (UIImage *)imageWithSize:(CGSize)size fillColor:(UIColor *)fillColor shapeBlock:(UIBezierPath *(^)(void))shapeBlock;
@end

@interface NSAttributedString (Additions)
+ (NSAttributedString *)attributedStringWithString:(NSString *)string fontSize:(CGFloat)size color:(UIColor *)color;
@end

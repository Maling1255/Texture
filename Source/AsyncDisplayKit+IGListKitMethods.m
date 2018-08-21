//
//  AsyncDisplayKit+IGListKitMethods.m
//  Texture
//
//  Copyright (c) 2017-present, Pinterest, Inc.  All rights reserved.
//  Licensed under the Apache License, Version 2.0 (the "License").
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//

#import <AsyncDisplayKit/ASAvailability.h>

#if AS_IG_LIST_KIT

#import "AsyncDisplayKit+IGListKitMethods.h"
#import <AsyncDisplayKit/ASAssert.h>
#import <AsyncDisplayKit/_ASCollectionViewCell.h>
#import <AsyncDisplayKit/_ASCollectionReusableView.h>


@implementation ASIGListSectionControllerMethods

+ (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index sectionController:(IGListSectionController *)sectionController
{
  // Cast to id for backwards-compatibility until 3.0.0 is officially released – IGListSectionType was removed. This is safe.
  return [sectionController.collectionContext dequeueReusableCellOfClass:[_ASCollectionViewCell class] forSectionController:(id)sectionController atIndex:index];
}

+ (CGSize)sizeForItemAtIndex:(NSInteger)index
{
  ASDisplayNodeFailAssert(@"Did not expect %@ to be called.", NSStringFromSelector(_cmd));
  return CGSizeZero;
}

@end

@implementation ASIGListSupplementaryViewSourceMethods

+ (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind
                                                                 atIndex:(NSInteger)index
                                                       sectionController:(IGListSectionController *)sectionController
{
  return [sectionController.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:(id)sectionController class:[_ASCollectionReusableView class] atIndex:index];
}

+ (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index
{
  ASDisplayNodeFailAssert(@"Did not expect %@ to be called.", NSStringFromSelector(_cmd));
  return CGSizeZero;
}

@end

#endif // AS_IG_LIST_KIT

//
//  FeedHeaderNode.m
//  Texture
//
//  Copyright (c) 2017-present, Pinterest, Inc.  All rights reserved.
//  Licensed under the Apache License, Version 2.0 (the "License").
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//

#import "FeedHeaderNode.h"
#import "Utilities.h"

static UIEdgeInsets kFeedHeaderInset = { .top = 20, .bottom = 20, .left = 10, .right = 10 };

@interface FeedHeaderNode ()
@property (nonatomic, strong, readonly) ASTextNode *textNode;
@end

@implementation FeedHeaderNode

- (instancetype)init
{
  if (self = [super init]) {
    _textNode = [[ASTextNode alloc] init];
    self.automaticallyManagesSubnodes = YES;
    _textNode.attributedText = [NSAttributedString attributedStringWithString:@"Latest Posts" fontSize:18 color:[UIColor darkGrayColor] firstWordColor:nil];
  }
  return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
  return [ASInsetLayoutSpec insetLayoutSpecWithInsets:kFeedHeaderInset child:_textNode];
}

@end

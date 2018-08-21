//
//  ASCollectionElement.mm
//  Texture
//
//  Copyright (c) 2017-present, Pinterest, Inc.  All rights reserved.
//  Licensed under the Apache License, Version 2.0 (the "License").
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//

#import <AsyncDisplayKit/ASCollectionElement.h>
#import <AsyncDisplayKit/ASCellNode+Internal.h>
#import <mutex>

@interface ASCollectionElement ()

/// Required node block used to allocate a cell node. Nil after the first execution.
@property (nonatomic) ASCellNodeBlock nodeBlock;

@end

@implementation ASCollectionElement {
  std::mutex _lock;
  ASCellNode *_node;
}

- (instancetype)initWithNodeModel:(id)nodeModel
                        nodeBlock:(ASCellNodeBlock)nodeBlock
         supplementaryElementKind:(NSString *)supplementaryElementKind
                  constrainedSize:(ASSizeRange)constrainedSize
                       owningNode:(id<ASRangeManagingNode>)owningNode
                  traitCollection:(ASPrimitiveTraitCollection)traitCollection
{
  NSAssert(nodeBlock != nil, @"Node block must not be nil");
  self = [super init];
  if (self) {
    _nodeModel = nodeModel;
    _nodeBlock = nodeBlock;
    _supplementaryElementKind = [supplementaryElementKind copy];
    _constrainedSize = constrainedSize;
    _owningNode = owningNode;
    _traitCollection = traitCollection;
  }
  return self;
}

- (ASCellNode *)node
{
  std::lock_guard<std::mutex> l(_lock);
  if (_nodeBlock != nil) {
    ASCellNode *node = _nodeBlock();
    _nodeBlock = nil;
    if (node == nil) {
      ASDisplayNodeFailAssert(@"Node block returned nil node!");
      node = [[ASCellNode alloc] init];
    }
    node.owningNode = _owningNode;
    node.collectionElement = self;
    ASTraitCollectionPropagateDown(node, _traitCollection);
    node.nodeModel = _nodeModel;
    _node = node;
  }
  return _node;
}

- (ASCellNode *)nodeIfAllocated
{
  std::lock_guard<std::mutex> l(_lock);
  return _node;
}

- (void)setTraitCollection:(ASPrimitiveTraitCollection)traitCollection
{
  ASCellNode *nodeIfNeedsPropagation;
  
  {
    std::lock_guard<std::mutex> l(_lock);
    if (! ASPrimitiveTraitCollectionIsEqualToASPrimitiveTraitCollection(_traitCollection, traitCollection)) {
      _traitCollection = traitCollection;
      nodeIfNeedsPropagation = _node;
    }
  }
  
  if (nodeIfNeedsPropagation != nil) {
    ASTraitCollectionPropagateDown(nodeIfNeedsPropagation, traitCollection);
  }
}

@end

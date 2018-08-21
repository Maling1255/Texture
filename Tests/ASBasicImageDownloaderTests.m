//
//  ASBasicImageDownloaderTests.m
//  Texture
//
//  Copyright (c) 2017-present, Pinterest, Inc.  All rights reserved.
//  Licensed under the Apache License, Version 2.0 (the "License").
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//

#import <XCTest/XCTest.h>

#import <AsyncDisplayKit/ASBasicImageDownloader.h>

@interface ASBasicImageDownloaderTests : XCTestCase

@end

@implementation ASBasicImageDownloaderTests

- (void)testAsynchronouslyDownloadTheSameURLTwice
{
  XCTestExpectation *firstExpectation = [self expectationWithDescription:@"First ASBasicImageDownloader completion handler should be called within 3 seconds"];
  XCTestExpectation *secondExpectation = [self expectationWithDescription:@"Second ASBasicImageDownloader completion handler should be called within 3 seconds"];

  ASBasicImageDownloader *downloader = [ASBasicImageDownloader sharedImageDownloader];
  NSURL *URL = [NSURL URLWithString:@"http://wrongPath/wrongResource.png"];

  [downloader downloadImageWithURL:URL
                     callbackQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                  downloadProgress:nil
                        completion:^(id<ASImageContainerProtocol>  _Nullable image, NSError * _Nullable error, id  _Nullable downloadIdentifier, id _Nullable userInfo) {
                          [firstExpectation fulfill];
                        }];
  
  [downloader downloadImageWithURL:URL
                     callbackQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                  downloadProgress:nil
                        completion:^(id<ASImageContainerProtocol>  _Nullable image, NSError * _Nullable error, id  _Nullable downloadIdentifier, id _Nullable userInfo) {
                          [secondExpectation fulfill];
                        }];

  [self waitForExpectationsWithTimeout:30 handler:nil];
}

@end

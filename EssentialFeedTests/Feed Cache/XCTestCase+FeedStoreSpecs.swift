//
//  XCTestCase+FeedStoreSpecs.swift
//  EssentialFeedTests
//
//  Created by Marek Stránský on 30.10.2023.
//

import EssentialFeed
import XCTest

extension FeedStoreSpecs where Self: XCTestCase {
    @discardableResult
    func insert(_ cache: (feed: [LocalFeedImage], timestamp: Date), to sut: FeedStore) -> Error? {
        
        let exp = expectation(description: "Wait for cache insertion")
        var insertionError: Error?
        sut.insert(cache.feed, timestamp: cache.timestamp) { receivedError in
            insertionError = receivedError
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        return insertionError
    }
    
    @discardableResult
    func deleteCache(from sut: FeedStore) -> Error? {
        let exp = expectation(description: "Wait for cache deletion")
        var deletionError: Error?
        sut.deleteCachedFeed { receivedDeletionError in
            deletionError = receivedDeletionError
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        return deletionError
    }
    
    func expect(_ sut: FeedStore, toRetrieveTwice expectedResult: RetrievedCachedFeedResult, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
    }
    
    func expect(_ sut: FeedStore, toRetrieve expectedResult: RetrievedCachedFeedResult, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "Wait for cache retrieval")
        
         sut.retrieve { receivedResult in
             switch (expectedResult, receivedResult) {
             case (.empty, .empty),
                 (.failure, .failure):
                 break
                 
             case let (.found(expectedFeed, expectedTimestamp), .found(retrievedFeed, retrievedTimestamp)):
                 XCTAssertEqual(retrievedFeed, expectedFeed, file: file, line: line)
                 XCTAssertEqual(retrievedTimestamp, expectedTimestamp, file: file, line: line)
                 
             default:
                 XCTFail("Expected to retrieve \(expectedResult), got \(receivedResult) instead", file: file, line: line)
             }
             
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
}

//
//  LoadFeedFromCacheUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Marek Stránský on 01.08.2023.
//

import XCTest
import EssentialFeed

class LoadFeedFromCacheUseCaseTests: XCTestCase {
    
    /**
        DRY is a good principle but not every code that looks alike is duplicate.
        Before deleting duplication, investigate if it's just an accidental duplication:
            code that seems the same but conceptually represents something else.
        Mixing different concepts makes it harder to reason about separate parts of the system in isolation,
        increasing its complexity
        -> this test may look "duplicate", but it's and "accidental duplication"
        Altough we decided to keep the "Save" and "Load" methods in the same type (LocalFeedLoader),
        they belong to different contexts / Uses  cases
     
        By creating separate tests, if we ever decide to break those actions in separate types, it's much easier to do so.
        The tests are al;ready separated and with all the necessary assertions.
     */
     
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_load_requestsCacheRetrieeval() {
        let (sut, store) = makeSUT()

        sut.load()
        
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #file, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
}

//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Marek Stránský on 07.02.2023.
//

import Foundation

public enum LoadFeedResult<Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}

extension LoadFeedResult: Equatable where Error: Equatable {}

protocol FeedLoader {
    associatedtype Error: Swift.Error
    func load(copletion: @escaping (LoadFeedResult<Error>) -> Void)
}

//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Marek Stránský on 07.02.2023.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(copletion: @escaping (LoadFeedResult) -> Void)
}

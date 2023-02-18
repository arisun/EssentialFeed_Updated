//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Marek Stránský on 07.02.2023.
//

import Foundation

public struct FeedItem: Equatable {
    // should i add  public to preporties???
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
    
    // in video this is also public
    init(id: UUID, description: String?, location: String?, imageURL: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.imageURL = imageURL
    }
}

extension FeedItem: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case description
        case location
        case imageURL = "image"
    }
}
	

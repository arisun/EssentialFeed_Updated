//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Marek Stránský on 07.02.2023.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
	

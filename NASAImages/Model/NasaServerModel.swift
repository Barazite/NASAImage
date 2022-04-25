//
//  NasaServerModel.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 14/4/22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let nasaServerModel = try? newJSONDecoder().decode(NasaServerModel.self, from: jsonData)

import Foundation

// MARK: - NasaServerModel
struct NasaServerModel: Codable {
    var collection: Collection?

    enum CodingKeys: String, CodingKey {
        case collection = "collection"
    }
}

// MARK: - Collection
struct Collection: Codable {
    var version: String?
    var href: String?
    var items: [Item]?
    var metadata: Metadata?
    var links: [CollectionLink]?

    enum CodingKeys: String, CodingKey {
        case version = "version"
        case href = "href"
        case items = "items"
        case metadata = "metadata"
        case links = "links"
    }
}

// MARK: - Item
struct Item: Codable{
    var href: String?
    var data: [Datum]?
    var links: [ItemLink]?

    enum CodingKeys: String, CodingKey {
        case href = "href"
        case data = "data"
        case links = "links"
    }
}

// MARK: - Datum
struct Datum: Codable {
    var center: String?
    var title: String?
    var location: String?
    var nasaid: String?
    var mediaType: String?
    var keywords: [String]?
    var dateCreated: String?
    var datumDescription: String?
    var album: [String]?
    var description508: String?
    var secondaryCreator: String?
    var photographer: String?

    enum CodingKeys: String, CodingKey {
        case center = "center"
        case title = "title"
        case location = "location"
        case nasaid = "nasa_id"
        case mediaType = "media_type"
        case keywords = "keywords"
        case dateCreated = "date_created"
        case datumDescription = "description"
        case album = "album"
        case description508 = "description_508"
        case secondaryCreator = "secondary_creator"
        case photographer = "photographer"
    }
}

// MARK: - ItemLink
struct ItemLink: Codable {
    var href: String?
    var rel: String?
    var render: String?

    enum CodingKeys: String, CodingKey {
        case href = "href"
        case rel = "rel"
        case render = "render"
    }
}

// MARK: - CollectionLink
struct CollectionLink: Codable {
    var rel: String?
    var prompt: String?
    var href: String?

    enum CodingKeys: String, CodingKey {
        case rel = "rel"
        case prompt = "prompt"
        case href = "href"
    }
}

// MARK: - Metadata
struct Metadata: Codable {
    var totalHits: Int?

    enum CodingKeys: String, CodingKey {
        case totalHits = "total_hits"
    }
}

//
//  FlickerSrarchModels.swift.swift
//  FlickerApp
//
//  Created by Naveen Reddy on 09/07/24.
//

import Foundation


struct FlickrResponse: Decodable {
    let photos: Photos
}

struct Photos: Decodable {
    let photo: [Photo]
}

struct Photo: Decodable, Identifiable, Equatable {
    let id: String
    let title: String
    let farm: Int
    let server: String
    let secret: String

    var imageURL: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
    }
}

struct PhotoInfoResponse: Codable {
    let photo: PhotoInfo
}

struct PhotoInfo: Codable {
    let id: String
    let title: PhotoTitle
    let description: PhotoDescription
    let dates: Dates
    
    struct PhotoTitle: Codable {
        let _content: String
    }
    
    struct PhotoDescription: Codable {
        let _content: String
    }
    
    struct Dates: Codable {
        let taken: String
        let posted: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "title"
        case description = "description"
        case dates = "dates"
    }
}

extension Photo {
    static var mockedArray: [Photo] {
        return [Photo(id: "1", title: "title", farm: 1, server: "Test server", secret: "Test secret")]
    }
}

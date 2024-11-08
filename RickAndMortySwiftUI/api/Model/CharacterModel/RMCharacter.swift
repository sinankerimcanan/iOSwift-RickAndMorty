import Foundation

struct RMCharacter : Codable , Identifiable{
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: RMSingleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

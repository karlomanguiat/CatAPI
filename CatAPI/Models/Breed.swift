//
//  Breed.swift
//  CatAPI
//
//  Created by Glenn Karlo Manguiat on 6/5/25.
//

import Foundation

struct Breed: Codable, Identifiable {
    let id: String
    let name: String
    let temperament: String
    let breedExplanation: String
    let energyLevel: Int
    let isHairless: Bool
    let image: BreedImage?
    
    var description: String {
        return "\(name): \(temperament), Description: \(breedExplanation), Energy Level: \(energyLevel), isHairless: \(isHairless ? "YES" : "NO")"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case temperament
        case breedExplanation = "description"
        case energyLevel = "energy_level"
        case isHairless = "hairless"
        case image
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(String.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.temperament = try values.decode(String.self, forKey: .temperament)
        self.breedExplanation = try values.decode(String.self, forKey: .breedExplanation)
        self.energyLevel = try values.decode(Int.self, forKey: .energyLevel)
        
        let hairless = try values.decode(Int.self, forKey: .isHairless)
        self.isHairless = hairless == 1
        self.image = try values.decodeIfPresent(BreedImage.self, forKey: .image)
    }
    
    init(name: String, id: String, temperament: String, breedExplanation: String, energyLevel: Int, isHairless: Bool, image: BreedImage?) {
        self.name = name
        self.id = id
        self.temperament = temperament
        self.breedExplanation = breedExplanation
        self.energyLevel = energyLevel
        self.isHairless = isHairless
        self.image = image
        
    }
     
    static func example() -> Breed {
        return Breed(name: "Persian",
                     id: "1",
                     temperament: "Affectionate",
                     breedExplanation: "Persian cats are known for their long, flowing coats and gentle nature.",
                     energyLevel: 1,
                     isHairless: false,
                     image: nil)
    }
    
    static func exampleAgain() -> Breed {
        return Breed(name: "Maine Coon",
                     id: "2",
                     temperament: "Gentle",
                     breedExplanation: "Maine Coons are known for their large size, soft fur, and friendly disposition.",
                     energyLevel: 2,
                     isHairless: false,
                     image: nil)
    }
    
}

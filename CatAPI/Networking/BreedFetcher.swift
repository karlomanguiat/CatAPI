//
//  BreedFetcher.swift
//  CatAPI
//
//  Created by Glenn Karlo Manguiat on 6/5/25.
//
import Foundation

class BreedFetcher: ObservableObject {
    @Published var breeds: [Breed] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    let service: APIServiceProtocol
    
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
        fetchAllBreeds()
    }
    
    func fetchAllBreeds() {
        isLoading = true
        
        service.fetchBreeds(url: URL(string: "https://api.thecatapi.com/v1/breeds")!)  { [unowned self] result in
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        print(error)
                    
                    case .success (let breeds):
                        self.breeds = breeds
                        print(self.breeds)
                }
            }
            
        }
        
    }
    
    static func errorState() -> BreedFetcher {
        let fetcher = BreedFetcher()
        
        fetcher.errorMessage = APIError.url(URLError.init(.notConnectedToInternet)).localizedDescription
        
        return fetcher
    }
    
    static func successState() -> BreedFetcher {
        let fetcher = BreedFetcher()
        
        fetcher.breeds = [Breed.example(), Breed.exampleAgain()]
        return fetcher
    }
}

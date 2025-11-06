import Foundation
//


class MovieService{
   private let baseUrl = "https://api.themoviedb.org/3"
   private let apiKey = "5b7daa9d15680c08f8a6516739b91403"

    func fetchMoivie() throws -> [Movie]{
    let urlAsString = "\(baseUrl)/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        print(urlAsString)
        guard let url = URL(string: urlAsString) else {throw URLError(.badURL)
        }
        
        
        
        return[]
    }
}

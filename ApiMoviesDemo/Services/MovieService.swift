import Foundation
//


class MovieService{
   private let baseUrl = "https://api.themoviedb.org/3"
   private let apiKey = "5b7daa9d15680c08f8a6516739b91403"
    
    func searchMovies(query: String)  async throws -> [Movie]{
        let q = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    let urlAsString = "\(baseUrl)/search/movie?api_key=\(apiKey)&query=\(q)"
        print(urlAsString)
        return try await fetchMovies(urlAsString: urlAsString)

    }
    
    func fetchPopularMovies()  async throws -> [Movie]{
        let urlAsString = "\(baseUrl)/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        return try await fetchMovies(urlAsString: urlAsString)
        
    }
    
    
    
    private func fetchMovies(urlAsString: String)  async throws -> [Movie]{
 
        guard let url = URL(string: urlAsString) else {throw URLError(.badURL)
        }
        
        do{
          let(data, _) = try  await URLSession.shared.data(from: url)
           let response =  try JSONDecoder().decode(MovieResponse.self, from: data)
            return response.results
        }catch let DecodingError.keyNotFound(key, context){
            print("ERROR: key \(key.stringValue) not found")
        }catch let DecodingError.valueNotFound(value, context){
            print("ERROR: value \(value) not found")
        }catch let DecodingError.typeMismatch(type, context){
            print("ERROR: Type \(type) mismatch")
        }catch let DecodingError.dataCorrupted(_){
            print("ERROR: DATA CORRUPTED")
        }catch{
            print("ERROR: other decoding error: \(error.localizedDescription)")
        }
        
        return[]
    }

   
}

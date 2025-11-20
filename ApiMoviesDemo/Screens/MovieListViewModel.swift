import Foundation
import Combine



@MainActor
final class MovieListViewModel: ObservableObject {
    @Published  var movies: [Movie] = []
    @Published var searchText = "";
    @Published var isLoading = false;
    @Published var errorMessage: String?
    

    private let movieService = MovieService();
    
    func fetchPopularMovies() async{
        isLoading = true;
        
        defer{isLoading = false}
        
        
        
        do{
            
            let fetchMovies = try await movieService.fetchPopularMovies()
            movies = fetchMovies
        }catch{
            errorMessage = "une erreur est survenue avec la requette. veuille reesayer plus tard "
            print ("ERROR: Failed to fetch popular movies with error: \(error)")
            
        }
        
    }
    
    
    
    func seachMovies() async{
        isLoading = true;
        
        defer{isLoading = false}
        
        do{
            
            let fetchMovies = try await movieService.searchMovies(query: searchText, )
            movies = fetchMovies
        }catch{
            errorMessage = "une erreur est survenue avec la requette. veuille reesayer plus tard"
            print ("ERROR: Failed to f search movie by query: '\(searchText)' with error: \(error)")
            
        }
        
    }
}

import Foundation
import Combine
import SwiftData



@MainActor
final class MovieListViewModel: ObservableObject {
    @Published  var movies: [MovieEntity] = []
    @Published var searchText = "";
    @Published var isLoading = false;
    @Published var errorMessage: String?
    

    private let movieService = MovieService();
    
    private var context: ModelContext!
    
    func setContextNeaded(_ context: ModelContext){
        if self.context == nil{
            self.context = context
        }
    }
    
    private let CacheDuration: TimeInterval = 24 * 60 * 60
    
    private func isExpired(movie: MovieEntity) -> Bool{
        return Date().timeIntervalSince(movie.cacheAt) > CacheDuration
    }
    
    private func loadCachedMovies(){
        let descriptor = FetchDescriptor<MovieEntity>(
            sortBy: [SortDescriptor(\.title)]
        )
        
        movies = (try? context.fetch(descriptor)) ?? []
        
    }
    
    func refresh() async{
        try? context.delete(model: MovieEntity.self)
        
        await fetchPopularMovies()
    }
    
    
    func fetchPopularMovies() async{
        isLoading = true;
        
      
        
        defer{isLoading = false}
        
        loadCachedMovies()
        
        let hasCachedMovies = !movies.isEmpty
        let isCacheExpired = movies.contains(where: isExpired)
        
        if hasCachedMovies && !isCacheExpired{
            return
        }
        
        
        
        do{
            
            let fetchMovies = try await movieService.fetchPopularMovies()
           
            try? context.delete(model: MovieEntity.self)
            
            for movie in fetchMovies{
                context.insert(movie)
            }
            
              loadCachedMovies()
//            movies = fetchMovies
            
            
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

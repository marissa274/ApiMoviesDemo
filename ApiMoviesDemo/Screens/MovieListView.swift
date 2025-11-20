import SwiftUI

struct MovieListView: View {
 @StateObject private var viewModel = MovieListViewModel()
        
    var body: some View {
        NavigationView {
            List {
                ForEach($viewModel.movies) { $movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieRow(movie: $movie)
                    }
                }
            }
            .navigationTitle("Films")
            .searchable(text: $viewModel.searchText, placement:  .navigationBarDrawer(displayMode: .automatic), prompt: "Rechercher des films")
            .onSubmit(of: .search) {
                Task{
                    await viewModel.seachMovies()
                    
                }
            }
            .overlay{
                if let errorMessage =
                    viewModel.errorMessage{
                    HStack{
                        Text(errorMessage)
                    }
                    
                }
                
                if viewModel.isLoading{
                    HStack{
                        ProgressView()
                        Text("chargement des movies")
                    }
                    
                   
                }
            }
            
            .refreshable {
               await viewModel.fetchPopularMovies()
            }
            .task {
                await viewModel.fetchPopularMovies()
            }
          
        }
    }

}

#Preview {
    MovieListView()
}

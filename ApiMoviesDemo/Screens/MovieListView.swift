import SwiftUI

struct MovieListView: View {
    @State private var movies = MockData.movies
    @State private var searchText = ""
    
    private var movieSevice = MovieService()
        
    var body: some View {
        NavigationView {
            List {
                ForEach($movies) { $movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieRow(movie: $movie)
                    }
                }
            }
            .navigationTitle("Films")
            .searchable(text: $searchText, placement:  .navigationBarDrawer(displayMode: .automatic), prompt: "Rechercher des films")
            .onSubmit(of: .search) {
                Task{
                    movies =  try! await movieSevice.searchMovies(query: searchText)
                    
                }
            }
            
            .refreshable {
                movies =  try! await movieSevice.fetchPopularMoivie()
            }
            .task {
                movies =  try! await movieSevice.fetchPopularMoivie()
            }
          
        }
    }

}

#Preview {
    MovieListView()
}

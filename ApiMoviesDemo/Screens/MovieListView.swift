import SwiftUI
import SwiftData

struct MovieListView: View {
    @Environment(\.modelContext) var modelContext
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
               await viewModel.refresh()
            }
            .task {
                viewModel.setContextNeaded(modelContext)
                await viewModel.fetchPopularMovies()
            }
          
        }
    }

}
enum PreviewData{
    static var container: ModelContainer = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        return try! ModelContainer(for: MovieEntity.self, configurations: config)
     }()
    }


#Preview {
    MovieListView()
        .modelContainer(PreviewData.container)
}

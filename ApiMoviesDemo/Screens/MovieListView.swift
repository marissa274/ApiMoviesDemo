import SwiftUI

struct MovieListView: View {
    @State private var movies = MockData.movies
        
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
        }
    }

}

#Preview {
    MovieListView()
}

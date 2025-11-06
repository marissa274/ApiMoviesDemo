import SwiftUI

struct MovieRow: View {
    @Binding var movie: Movie

    var body: some View {
        HStack(spacing: 12) {
            if let url = movie.posterURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 60, height: 90)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 90)
                            .clipped()
                            .cornerRadius(6)
                    case .failure:
                        Color.gray
                            .frame(width: 60, height: 90)
                            .cornerRadius(6)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Color.gray
                    .frame(width: 60, height: 90)
                    .cornerRadius(6)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(2)
                Text(movie.releaseDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(String(format: "⭐️ %.1f • %d votes", movie.voteAverage, movie.voteCount))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()            
        }
        .padding(.vertical, 8)
    }
}

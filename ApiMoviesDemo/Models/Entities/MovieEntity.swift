import Foundation
import SwiftData

@Model
class MovieEntity{
    var id: Int
    var title: String
    var overview: String
    var releaseDate: String
    var backdropPath:String?
    var posterPath: String?
    var  voteAverage: Double
    var voteCount: Int
    
    var cacheAt: Date = Date()
    
    init(id: Int, title: String, overview: String, releaseDate: String, backdropPath: String? = nil, posterPath: String? = nil, voteAverage: Double, voteCount: Int) {
        self.id = id
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }

}

extension MovieEntity{
    var posterURL : URL?{
        guard let path =  posterPath else {return nil}
        return URL (string: "https://image.tmdb.org/t/p/w500\(path)")
            
   }
}

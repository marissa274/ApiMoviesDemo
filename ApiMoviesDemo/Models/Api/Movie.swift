import Foundation

//
// API endpoints
//
// https://api.themoviedb.org/3/movie/popular?api_key=5b7daa9d15680c08f8a6516739b91403&language=en-US&page=1
// https://api.themoviedb.org/3/search/movie?api_key=5b7daa9d15680c08f8a6516739b91403&query=Lord+Of+The+Rings

//
// API docs
//
// Popular Movies docs: https://developer.themoviedb.org/reference/movie-popular-list
// Search Movies docs: https://developer.themoviedb.org/reference/search-movie
// Image basics: https://developer.themoviedb.org/docs/image-basics


//    {
//      "adult": false,
//      "backdrop_path": "/gMJngTNfaqCSCqGD4y8lVMZXKDn.jpg",
//      "genre_ids": [
//        28,
//        12,
//        878
//      ],
//      "id": 640146,
//      "original_language": "en",
//      "original_title": "Ant-Man and the Wasp: Quantumania",
//      "overview": "Super-Hero partners Scott Lang and Hope van Dyne, along with with Hope's parents Janet van Dyne and Hank Pym, and Scott's daughter Cassie Lang, find themselves exploring the Quantum Realm, interacting with strange new creatures and embarking on an adventure that will push them beyond the limits of what they thought possible.",
//      "popularity": 8567.865,
//      "poster_path": "/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg",
//      "release_date": "2023-02-15",
//      "title": "Ant-Man and the Wasp: Quantumania",
//      "video": false,
//      "vote_average": 6.5,
//      "vote_count": 1886
//    }

struct Movie: Identifiable {
    
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let releaseDate: String
    let backdropPath:String
    let posterPath: String
    let voteAverage: Double
    let voteCount: Int
    let genreIds: [Int]
    
    
    var posterURL : URL?{
        return URL (string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            
    
        
    }
    

}

//
//  MovieCardView.swift
//  MetFlix
//
//  Created by Apple on 23/11/2023.
//

import Foundation
import SwiftUI

struct MovieCardView: View {
    @Binding var movie: MovieUIM
    @State var isBackgroundImageDownloaded: Bool = false
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color.black
            if let posterPath = movie.posterPath {
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        if !isBackgroundImageDownloaded {
                            Spacer()
                        }
                        RemoteImageView(
                            image: Config.moviesImageHost.hostScheme + posterPath,
                            lottiePlaceholder: Config.Lottie.loadingAnimation,
                            lottieError: Config.Lottie.errorAnimation,
                            overlayColor: .black.opacity(0.3),
                            size: .init(width: 50, height: 50),
                            isDownloaded: $isBackgroundImageDownloaded
                        )
                        .shadow(color: isBackgroundImageDownloaded ? .clear : .red, radius: 15)
                        if !isBackgroundImageDownloaded {
                            Spacer()
                        }
                    }
                    if !isBackgroundImageDownloaded {
                        Spacer()
                    }
                }
            }
            // Circular container for backdrop image
            if let backdropPath = movie.backdropPath {
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        Spacer()
                        RemoteImageView(
                            image: Config.moviesImageHost.hostScheme + backdropPath,
                            lottiePlaceholder: Config.Lottie.loadingAnimation,
                            lottieError: Config.Lottie.errorAnimation, size: .init(width: 50, height: 50)
                        )
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .offset(x: -16, y: 16)
                        .shadow(color: .red, radius: 15)
                    }
                    Spacer()
                }
            }

            // Title, Release Date, Star Rating, and Vote Count
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.largeTitle.bold())
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .red, radius: 3, x: 3, y: -3)

                Text("Release Date: \(movie.releaseDate)")
                    .foregroundColor(.white)
                    .font(.title2.bold())
                    .shadow(color: .red, radius: 3, x: 3, y: -3)

                RatingView(
                    rate: Int(movie.voteAverage),
                    ratingSubtitle: "(\(movie.voteCount)) Votes",
                    size: 15,
                    font: .title3.bold(),
                    selectedColor: .orange,
                    unSelectedColor: .white
                )
                .frame(maxHeight: 40)
                
//                HStack {
//                    // Star Rating (you may need to implement a custom star rating view)
//                    Text("⭐️⭐️⭐️⭐️⭐️")
//                        .foregroundColor(.white)
//                        .font(.title)
//                        .shadow(color: .red, radius: 3, x: 3, y: -3)
//
//                    Text("(\(movie.voteCount) votes)")
//                        .foregroundColor(.white)
//                        .font(.subheadline)
//                        .fontWeight(.bold)
//                        .shadow(color: .red, radius: 3, x: 3, y: -3)
//                }
            }
            .padding()
        }
        .cornerRadius(16)
        .shadow(color: .red.opacity(0.35), radius: 10)
        .padding()
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        let model = PaginatedResult<Movie>.preview
        let uimodel = PaginatedResultUIM<MovieUIM>.init(dataModel: model)
        let result = uimodel.results
        let resultBinding = Binding.constant(result)
        
        ScrollView(content: {
            VStack {
                ForEach(resultBinding, content: { movie in
                    MovieCardView(movie: movie)
                        .padding(.horizontal)
                        .frame(height: 500)
                        .id(movie.id)
                })
            }
        })
        .background(Color.black)
        .previewLayout(.sizeThatFits)
        
        
        
    }
}

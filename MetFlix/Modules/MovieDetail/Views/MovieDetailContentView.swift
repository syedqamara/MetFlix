//
//  MovieDetailContentView.swift
//  MetFlix
//
//  Created by Apple on 27/11/2023.
//

import SwiftUI
import PreviewSnapshots

struct MovieDetailContentView: View {
    // Inject MovieDetailUIM as the ViewModel
    @State private var debugText: String
    @State private var movieDetail: MovieDetailUIM
    static private let defaultHeight: CGFloat = 300
    static private let offsetMultiplier: CGFloat = 2
    @State private var coverSize: CGRect = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: MovieDetailContentView.defaultHeight)
    init(movieDetail: MovieDetailUIM) {
        self.movieDetail = movieDetail
        self.debugText = ""
    }

    var body: some View {
        ScrollView {
            // Cover Photo with dynamic height based on scroll position
            GeometryReader { geometry in
                if let post = movieDetail.posterPath {
                    RemoteImageView(
                        image: Config.moviesImageHost.hostScheme + post,
                        lottiePlaceholder: Config.Lottie.loadingAnimation,
                        lottieError: Config.Lottie.errorAnimation,
                        size: .init(width: coverSize.width, height: coverSize.height)
                    )
                        .onAppear() {
                            setupCoverPhotoFrame(offset: geometry.frame(in: .global).minY)
                        }
                        .onChange(of: geometry.frame(in: .global).minY, perform: { offset in
                            setupCoverPhotoFrame(offset: offset)
                        })
                        .offset(x: coverSize.origin.x ,y: coverSize.origin.y)
                        .frame(width: coverSize.width, height: coverSize.height, alignment: .top)
                }
            }
            .frame(height: coverSize.height)
            
            // Other movie details
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top, spacing: 15) {
                    if let backdropPath = movieDetail.backdropPath {
                        RemoteImageView(
                            image: Config.moviesImageHost.hostScheme + backdropPath,
                            lottiePlaceholder: Config.Lottie.loadingAnimation,
                            lottieError: Config.Lottie.errorAnimation, size: .init(width: 50, height: 50)
                        )
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .shadow(color: .red, radius: 15)
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text(movieDetail.title)
                            .font(.title.bold())
                            .foregroundColor(.red)
                            .shadow(color: .red, radius: 5, x: 3, y: -3)
                        
                        RatingView(
                            rate: Int(movieDetail.voteAverage),
                            ratingSubtitle: "(\(movieDetail.voteCount)) Votes",
                            size: 15,
                            font: .title3.bold(),
                            selectedColor: .red,
                            unSelectedColor: .white
                        )
                        .frame(maxHeight: 40)
                    }
                }
                .padding(20)
                
                // Overview Text
                ExpandableTextView(text: movieDetail.overview)
                    .padding()
                
                lineView()
                // Info Section
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        // Display "18+" if it's an adult movie
                        if !movieDetail.adult {
                            Text("18+")
                                .lineLimit(1)
                                .font(.title3.bold())
                                .tagViewStyle()
                        }
                        
                        Text("Release Date: \(movieDetail.releaseDate)")
                            .font(.title3.bold())
                            .lineLimit(1)
                            .fixedSize()
                            .tagViewStyle()

                        // Budget
                        Text("Budget: \(movieDetail.budget)")
                            .font(.title3.bold())
                            .lineLimit(1)
                            .fixedSize()
                            .tagViewStyle()
                        // Other info items...
                    }
                }
                .padding()
                
                lineView()
                
                VStack {
                    
                    // Genre TagListView in horizontal carousel
                    TagListView(title: "Production Countries", tags: movieDetail.productionCountries.map { $0.name })
                        .padding(.horizontal)
                    lineView()
                }
                
                VStack {
                    // Genre TagListView in horizontal carousel
                    TagListView(title: "Genre", tags: movieDetail.genres.map { $0.name })
                        .padding(.horizontal)
                    lineView()
                }
                

                VStack {
                    // Spoken Language TagView in horizontal carousel
                    TagListView(title: "Languages", tags: movieDetail.spokenLanguages.map { $0.name })
                        .padding(.horizontal)
                    lineView()
                }
                
                VStack {
                    companiesCarousel()
                    lineView()
                }
                
            }
            .background(.black)
        }
        .ignoresSafeArea(.all, edges: [.top, .bottom])
    }
    
    @ViewBuilder
    func companiesCarousel() -> some View {
        CardCarouselView(companies: movieDetail.productionCompanies)
            .background(.black)
    }
    @ViewBuilder
    func lineView() -> some View {
        LineView(color: .red, lineHeight: 1)
            .padding(.horizontal, UIScreen.main.bounds.width/2.5)
            .padding(.vertical, 5)
    }
    func setupCoverPhotoFrame(offset: CGFloat) {
        var newValue = offset / 2
        guard offset > 0 else { return }
        let size = CGSize(
            width: newValue * Self.offsetMultiplier + UIScreen.main.bounds.width,
            height: newValue * (Self.offsetMultiplier) + MovieDetailContentView.defaultHeight
        )
        let origin = CGPoint(x: newValue * -1, y: newValue * -Self.offsetMultiplier)
        self.coverSize.size = size
        self.coverSize.origin = origin
    }
}

struct MovieDetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    static var snapshots: PreviewSnapshots<MovieDetail> {
        .init(
            configurations: [
                .init(name: "The Creator Preview", state: .preview)
            ]) { movieDetail in
                MovieDetailContentView(movieDetail: .init(dataModel: movieDetail))
                    .navigationTitle("AAA")
                    .background(.black)
                    .ignoresSafeArea(edges: .top)
                    .overlay(alignment: .top) {
                        Color.black
                            .ignoresSafeArea(edges: .top)
                            .frame(height: 0)
                    }
            }
    }
}

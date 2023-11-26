//
//  MovieDetailView.swift
//  MetFlix
//
//  Created by Apple on 22/11/2023.
//

import Foundation
import core_architecture
import SwiftUI



public struct MovieDetailView<V: MovieDetailViewModeling>: MovieDetailViewProtocol {
    public typealias ViewModelType = V
    @ObservedObject var viewModel: V
    @Environment(\.dismiss) var dismiss
    public init(viewModel: V) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all, edges: [.top, .bottom])
            VStack {
                if viewModel.isLoading {
                    AnimatedView(
                        animationFileName: Config.Lottie.loadingAnimation,
                        loopMode: .loop,
                        size: .init(
                            width: 100,
                            height: 100
                        )
                    )
                    .frame(height: 100)
                    Spacer()
                } else {
                    if let err = viewModel.error {
                        PlaceholderView(placeholder: .error(err.localizedDescription))
                    } else {
                        mainView()
                            .ignoresSafeArea(.all, edges: [.top, .bottom])
                    }
                }
            }
            .ignoresSafeArea(.all, edges: [.top, .bottom])
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.title2.bold())
                        .foregroundColor(.red)
                    Spacer()
                    if let detail = viewModel.movieDetail{
                        Text(detail.title)
                            .font(.title.bold())
                            .foregroundColor(.red)
                            .shadow(color: .red, radius: 5, x: 3, y: -3)
                            .padding(.trailing)
                    }
                }
                .onTapGesture {
                    dismiss.callAsFunction()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all, edges: [.top, .bottom])
        .onAppear() {
            viewModel.onAppear()
        }
    }
    @ViewBuilder
    private func mainView() -> some View {
        if let detail = viewModel.movieDetail {
            MovieDetailContentView(
                movieDetail: detail
            )
            .ignoresSafeArea(.all, edges: [.top, .bottom])
            .navigationTitle(detail.title)
        } else {
            EmptyView()
        }
    }
}



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

extension View {
    // Custom tag view style
    func tagViewStyle() -> some View {
        self
            .foregroundColor(.white)
            .padding(8)
            .background(Color.red)
            .cornerRadius(8)
            .shadow(color: .red, radius: 5)
    }
}



// MARK: - TagListView

struct TagListView: View {
    let title: String
    var tags: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.largeTitle.bold())
                .foregroundColor(.red)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(tags, id: \.self) { tag in
                        TagView(tag: tag)
                    }
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 2)
            }
        }
    }
}

// MARK: - TagView

struct TagView: View {
    var tag: String
    
    var body: some View {
        Text(tag)
            .lineLimit(1)
            .fixedSize()
            .font(.title3.bold())
            .tagViewStyle()
    }
}

// MARK: - ExpandableTextView

struct ExpandableTextView: View {
    @State private var expanded: Bool = false
    
    var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Overview")
                .font(.largeTitle.bold())
                .foregroundColor(.red)
            Text(text)
                .font(.headline.bold())
                .foregroundColor(.white)
                .lineLimit(expanded ? nil : 3)
                .overlay(
                    Button(action: {
                        withAnimation {
                            expanded.toggle()
                        }
                    }) {
                        Text(expanded ? "Read Less" : "Read More")
                            .font(.title3.bold())
                            .padding(.horizontal, 4)
                            .padding(.vertical, 0)
                            .foregroundColor(.red)
                            .background(.black)
                            
                    }
                    .padding(.top, 4),
                    alignment: .bottomTrailing
                )
        }
    }
}
// MARK: - AsyncImage Extension

extension AsyncImage {
    func onAppear(perform action: @escaping () -> Void) -> Self {
        self.onAppear {
            action()
        }
    }
}

struct CardView: View {
    let company: ProductionCompanyUIM

    var body: some View {
        ZStack {
            Color.red.opacity(0.7)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            VStack(spacing: 10) {
                if let logo = company.logoPath {
                    RemoteImageView(
                        image: Config.moviesImageHost.hostScheme + logo,
                        lottiePlaceholder: Config.Lottie.loadingAnimation,
                        lottieError: Config.Lottie.errorAnimation,
                        size: .init(width: 50, height: 50)
                    )
                    .padding(.horizontal)
                }
                Text(company.name)
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .shadow(color: .red, radius: 5)
                    .padding()
                    
            }
        }
        .frame(maxHeight: 200)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.red)
                .shadow(color: .red, radius: 10)
        )
        .padding()
    }
}

struct CardCarouselView: View {
    @State private var isExpanded: Bool = false
    var companies: [ProductionCompanyUIM]
    public init(companies: [ProductionCompanyUIM] = []) {
        self.companies = companies
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Production Companies")
                    .font(.largeTitle.bold())
                    .foregroundColor(.red)
                Spacer()
                Image(systemName: isExpanded ? "arrow.down.circle.fill" : "arrow.down.circle")
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    .font(.largeTitle.bold())
                    .foregroundColor(.red)
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            .padding(.horizontal)
            if isExpanded {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        ForEach(companies) { company in
                            CardView(company: company)
                        }
                    }
                }
            }
        }
        .padding(.vertical)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample MovieDetail data for preview
        MovieDetailContentView(movieDetail: .init(dataModel: .preview))
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

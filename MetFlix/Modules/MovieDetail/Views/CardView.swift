//
//  CardView.swift
//  MetFlix
//
//  Created by Apple on 27/11/2023.
//

import Foundation
import SwiftUI
import PreviewSnapshots

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
                        size: .init(width: 75, height: 75)
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
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    static var snapshots: PreviewSnapshots<ProductionCompany> {
        .init(
            configurations: [
                .init(name: "Preview New Regency", state: .previewNewRegency),
                .init(name: "Preview Entertainment", state: .previewEntertainment),
                .init(name: "Preview Regency", state: .previewRegency),
                .init(name: "Preview Bad Dreams", state: .previewBadDreams)
            ]) { state in
                CardView(company: .init(dataModel: state))
            }
    }
    static var languagePreviewState: String {
        """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum euismod justo id efficitur commodo. Curabitur vel purus non enim dictum fermentum. Suspendisse potenti. Praesent ac sollicitudin orci. Nullam et diam nec odio eleifend suscipit. Vivamus sodales, odio eu tempor lacinia, orci turpis viverra dolor, vel sodales risus felis in turpis. Proin venenatis odio vel dolor feugiat, et efficitur libero cursus. Integer euismod dapibus massa, vel tincidunt purus cursus eu. Vivamus convallis, augue vel consectetur convallis, lacus velit sodales mauris, at fringilla turpis tortor id lacus.

        Sed consectetur, justo a suscipit tincidunt, neque orci vehicula justo, vel hendrerit enim elit ac leo. Maecenas finibus orci vel nisl faucibus bibendum. Aliquam sagittis tellus eu arcu luctus lacinia. Fusce ut mauris sed tellus consectetur aliquet. Duis bibendum odio et turpis dignissim bibendum. In hac habitasse platea dictumst. Vivamus eget imperdiet ex. Integer hendrerit quam euismod, euismod odio eu, auctor elit. Nullam bibendum augue eget velit sollicitudin, vitae egestas nulla malesuada.
        """
    }
}


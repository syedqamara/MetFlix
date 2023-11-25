//
//  StartView.swift
//  MetFlix
//
//  Created by Apple on 24/11/2023.
//

import Foundation
import SwiftUI

struct StarView: View {
    @State var isSelected: Bool
    @State private var scale: CGFloat = 0.5

    let selectedColor: Color
    let unSelectedColor: Color
    let delay: TimeInterval
    

    init(selectedColor: Color, unSelectedColor: Color, isSelected: Bool, delay: TimeInterval) {
        self.selectedColor = selectedColor
        self.unSelectedColor = unSelectedColor
        self.isSelected = isSelected
        self.delay = delay
    }

    var body: some View {
        Image(systemName: "star.fill")
            .resizable()
            .foregroundColor(isSelected ? selectedColor : unSelectedColor)
            .shadow(color: isSelected ? selectedColor : unSelectedColor, radius: 5)
            .scaleEffect(scale)
            .onTapGesture {
                isSelected.toggle()
                toggle(scale: 1.0)
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05 + self.delay) {
                    toggle(scale: 1.0)
                }
            }
    }
    func toggle(scale: CGFloat) {
        self.scale = 0.0
        withAnimation(Animation.spring(response: 0.5, dampingFraction: 0.15, blendDuration: 0.5)) {
            self.scale = scale
        }
    }
}
struct CharacterView: View {
    @State private var scale: CGFloat = 0.5
    @State private var angle: Angle = .degrees(0)
    
    let delay: TimeInterval
    let text: String
    let font: Font
    let color: Color
    let shadowColor: Color

    init(text: String, font: Font, color: Color, shadowColor: Color, delay: TimeInterval) {
        self.text = text
        self.delay = delay
        self.color = color
        self.shadowColor = shadowColor
        self.font = font
    }

    var body: some View {
        Text(text)
            .font(font)
            .foregroundColor(color)
            .shadow(color: shadowColor, radius: 3, x: 3, y: -3)
            .scaleEffect(scale)
            .rotationEffect(angle, anchor: .center)
            .onTapGesture {
                toggle(scale: 1.0)
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + self.delay) {
                    toggle(scale: 1.0)
                }
            }
    }
    func toggle(scale: CGFloat) {
        self.scale = 0.0
        self.angle = .degrees(0)
        withAnimation(Animation.spring(response: 1, dampingFraction: 0.45, blendDuration: 0.5)) {
            self.scale = scale
            self.angle = .degrees(360)
        }
    }
}
let totalRating: IntegerLiteralType = 10
struct RatingView: View {
    let rate: Int
    let ratingSubtitle: String
    let size: CGFloat
    let font: Font
    let selectedColor: Color
    let unSelectedColor: Color
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                AnimatedTextView(ratingSubtitle: ratingSubtitle, font: font, selectedColor: selectedColor, unSelectedColor: unSelectedColor)
                HStack(alignment: .top, spacing: 1) {
                    ForEach(0..<totalRating) { index in
                        StarView(selectedColor: selectedColor, unSelectedColor: unSelectedColor, isSelected: index < self.rate, delay: 0.05 * TimeInterval(index))
                            .frame(width: size, height: size)
                    }
                }
            }
        }
    }
}
struct AnimatedTextView: View {
    let ratingSubtitle: String
    let font: Font
    let selectedColor: Color
    let unSelectedColor: Color
    @State var isAnimating: Bool = false
    private func characters(str: String) -> [String] {
        str.map { String($0) }
    }
    
    func color(i: Int) -> Color {
        if i % 2 == 0 {
            return selectedColor
        }
        return unSelectedColor
    }
    var separatedSubtitles: [String] {
        ratingSubtitle.components(separatedBy: " ")
    }
    @ViewBuilder
    func viewFor(strings: [String], color: Color) -> some View {
        ForEach(0..<strings.count) { index in
            CharacterView(
                text: strings[index],
                font: font,
                color: color,
                shadowColor: color,
                delay: delay(index)
            )
            .onAppear() {
                isAnimating = true
                DispatchQueue.main.asyncAfter(deadline: .now() + delay(ratingSubtitle.count / 2)) {
                    withAnimation(Animation.spring(response: 0.5, dampingFraction: 0.25, blendDuration: 0.5)) {
                        isAnimating = false
                    }
                }
            }
        }
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: isAnimating ? 5 : 0) {
                ForEach(0..<separatedSubtitles.count) { index in
                    viewFor(
                        strings: characters(
                            str: separatedSubtitles[index]
                        ),
                        color: color(
                            i: index
                        )
                    )
                }
            }
        }
    }
    func delay(_ index: Int) -> TimeInterval {
        0.05 * TimeInterval(index)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RatingView(rate: 6, ratingSubtitle: "(120) Votes", size: 20, font: .title2.bold(), selectedColor: .red, unSelectedColor: .white)
                .background(.black)
        }
    }
}

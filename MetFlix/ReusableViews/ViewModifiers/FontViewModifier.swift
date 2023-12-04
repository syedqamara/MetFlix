//
//  FontViewModifier.swift
//  MetFlix
//
//  Created by Apple on 02/12/2023.
//

import Foundation
import SwiftUI

public struct RobotoFontModifier: ViewModifier {
    public var style: FontStyle

    public enum FontStyle {
        case regular(FontSize), bold(FontSize), italic(FontSize), medium(FontSize), light(FontSize), thin(FontSize), black(FontSize)
        case mediumItalic(FontSize), thinItalic(FontSize), boldItalic(FontSize), lightItalic(FontSize), blackItalic(FontSize)
        var name: String {
            let fontName: String
            switch self {
            case .regular(_):
                fontName = "Roboto-Regular"
            case .bold(_):
                fontName = "Roboto-Bold"
            case .italic(_):
                fontName = "Roboto-Italic"
            case .medium(_):
                fontName = "Roboto-Medium"
            case .light(_):
                fontName = "Roboto-Light"
            case .thin(_):
                fontName = "Roboto-Thin"
            case .black(_):
                fontName = "Roboto-Black"
            case .mediumItalic(_):
                fontName = "Roboto-MediumItalic"
            case .thinItalic(_):
                fontName = "Roboto-ThinItalic"
            case .boldItalic(_):
                fontName = "Roboto-BoldItalic"
            case .lightItalic(_):
                fontName = "Roboto-LightItalic"
            case .blackItalic(_):
                fontName = "Roboto-BlackItalic"
            }

            return fontName
        }
        var size: CGFloat {
            switch self {
            case .regular(let size):
                return size.rawValue
            case .bold(let size):
                return size.rawValue
            case .italic(let size):
                return size.rawValue
            case .medium(let size):
                return size.rawValue
            case .light(let size):
                return size.rawValue
            case .thin(let size):
                return size.rawValue
            case .black(let size):
                return size.rawValue
            case .mediumItalic(let size):
                return size.rawValue
            case .thinItalic(let size):
                return size.rawValue
            case .boldItalic(let size):
                return size.rawValue
            case .lightItalic(let size):
                return size.rawValue
            case .blackItalic(let size):
                return size.rawValue
            }
        }
    }
    #if os(iOS)
    public enum FontSize: CGFloat {
        case headline = 35
        case title = 30
        case subtitle = 27
        case normal = 25
        case small = 20
        case xSmall = 15
        case xxSmall = 10
    }
    #else
    public enum FontSize: CGFloat {
        case headline = 45
        case title = 40
        case subtitle = 37
        case normal = 35
        case small = 30
        case xSmall = 25
        case xxSmall = 20
    }
    #endif

    public func body(content: Content) -> some View {
        var fontName: String
        var fontWeight: CGFloat
        switch style {
        case .regular(let size):
            fontName = "Roboto-Regular"
            fontWeight = size.rawValue
        case .bold(let size):
            fontName = "Roboto-Bold"
            fontWeight = size.rawValue
        case .italic(let size):
            fontName = "Roboto-Italic"
            fontWeight = size.rawValue
        case .medium(let size):
            fontName = "Roboto-Medium"
            fontWeight = size.rawValue
        case .light(let size):
            fontName = "Roboto-Light"
            fontWeight = size.rawValue
        case .thin(let size):
            fontName = "Roboto-Thin"
            fontWeight = size.rawValue
        case .black(let size):
            fontName = "Roboto-Black"
            fontWeight = size.rawValue
        case .mediumItalic(let size):
            fontName = "Roboto-MediumItalic"
            fontWeight = size.rawValue
        case .thinItalic(let size):
            fontName = "Roboto-ThinItalic"
            fontWeight = size.rawValue
        case .boldItalic(let size):
            fontName = "Roboto-BoldItalic"
            fontWeight = size.rawValue
        case .lightItalic(let size):
            fontName = "Roboto-LightItalic"
            fontWeight = size.rawValue
        case .blackItalic(let size):
            fontName = "Roboto-BlackItalic"
            fontWeight = size.rawValue
        }

        return content.font(.custom(fontName, size: fontWeight)) // Adjust the size as needed
    }
}

extension View {
    public func robotoFont(style: RobotoFontModifier.FontStyle) -> some View {
        modifier(RobotoFontModifier(style: style))
    }
}

struct RobotoFontView: View {
    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack {
                    titles(font: .black(.headline))
                    titles(font: .black(.title))
                    titles(font: .black(.subtitle))
                    titles(font: .black(.normal))
                    titles(font: .black(.small))
                    titles(font: .black(.xSmall))
                    titles(font: .black(.xxSmall))
                }
                VStack {
                    titles(font: .bold(.headline))
                    titles(font: .bold(.title))
                    titles(font: .bold(.subtitle))
                    titles(font: .bold(.normal))
                    titles(font: .bold(.small))
                    titles(font: .bold(.xSmall))
                    titles(font: .bold(.xxSmall))
                }
                VStack {
                    titles(font: .medium(.headline))
                    titles(font: .medium(.title))
                    titles(font: .medium(.subtitle))
                    titles(font: .medium(.normal))
                    titles(font: .medium(.small))
                    titles(font: .medium(.xSmall))
                    titles(font: .medium(.xxSmall))
                }
                VStack {
                    titles(font: .regular(.headline))
                    titles(font: .regular(.title))
                    titles(font: .regular(.subtitle))
                    titles(font: .regular(.normal))
                    titles(font: .regular(.small))
                    titles(font: .regular(.xSmall))
                    titles(font: .regular(.xxSmall))
                }
                VStack {
                    titles(font: .light(.headline))
                    titles(font: .light(.title))
                    titles(font: .light(.subtitle))
                    titles(font: .light(.normal))
                    titles(font: .light(.small))
                    titles(font: .light(.xSmall))
                    titles(font: .light(.xxSmall))
                }
                VStack {
                    titles(font: .thin(.headline))
                    titles(font: .thin(.title))
                    titles(font: .thin(.subtitle))
                    titles(font: .thin(.normal))
                    titles(font: .thin(.small))
                    titles(font: .thin(.xSmall))
                    titles(font: .thin(.xxSmall))
                }
            }
            .padding()
        }
    }
    @ViewBuilder
    func titles(font: RobotoFontModifier.FontStyle) -> some View {
        VStack {
            Text(font.name)
                    .robotoFont(style: font)
        }
    }
}

struct RobotoFontView_Previews: PreviewProvider {
    static var previews: some View {
        RobotoFontView()
    }
}

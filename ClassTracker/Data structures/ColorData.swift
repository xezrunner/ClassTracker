import SwiftUI

struct ColorData: Codable {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
    
    var color: Color {
        Color(red: red, green: green, blue: blue, opacity: alpha)
    }
    
    init(_ color: Color) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}

extension Color {
    init(_ colorData: ColorData) {
        self.init(
            red: colorData.red,
            green: colorData.green,
            blue: colorData.blue,
            opacity: colorData.alpha
        )
    }
    var uiColor: UIColor {
        UIColor(self)
    }
}

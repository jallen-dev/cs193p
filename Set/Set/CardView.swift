import SwiftUI

struct CardView: View {
    private let card: SetModel.Card
    private let color: Color
    private var borderColor: Color = .black
    private var borderWidth = 0.025

    init(_ card: SetModel.Card, matching: Bool = false, error: Bool = false) {
        self.card = card

        switch card.color {
        case .red: color = .red
        case .blue: color = .blue
        case .green: color = .green
        }

        if card.selected {
            borderWidth = 0.05
            if matching {
                borderColor = .green
            } else if error {
                borderColor = .red
            } else {
                borderColor = .blue
            }
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: geometry.size.width * 0.05)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(borderColor, lineWidth: geometry.size.width * borderWidth)
                    VStack {
                        Spacer()
                        ForEach(0 ..< card.number.rawValue, id: \.self) { _ in
                            CardSymbol().frame(height: geometry.size.height * 0.15)
                            Spacer()
                        }
                    }.padding(geometry.size.width * 0.1)
                } else {
                    shape.fill(.white)
                    shape.strokeBorder(.black, lineWidth: geometry.size.width * borderWidth)
                    let inset = RoundedRectangle(cornerRadius: geometry.size.width * 0.05)
                    inset.fill(.red).frame(width: geometry.size.width - 20, height: geometry.size.height - 20)
                }
            }.padding(geometry.size.width * 0.025)
        }
    }

    @ViewBuilder func CardSymbol() -> some View {
        switch card.shape {
        case .oval:
            Oval()
        case .squiggle:
            Squiggle()
        case .diamond:
            Diamond()
        }
    }

    @ViewBuilder func Oval() -> some View {
        GeometryReader { geometry in
            let shape = RoundedRectangle(cornerRadius: geometry.size.height).size(width: geometry.size.width, height: geometry.size.height)

            switch card.shading {
            case .open: shape.stroke(color, lineWidth: geometry.size.width * 0.05)
            case .solid: shape.fill(color)
            case .striped: shape.fill(color).opacity(0.3)
            }
        }
    }

    @ViewBuilder func Squiggle() -> some View {
        GeometryReader { geometry in
            let shape = Rectangle().size(width: geometry.size.width, height: geometry.size.height)

            switch card.shading {
            case .open: shape.stroke(color, lineWidth: geometry.size.width * 0.05)
            case .solid: shape.fill(color)
            case .striped: shape.fill(color).opacity(0.3)
            }
        }
    }

    @ViewBuilder func Diamond() -> some View {
        GeometryReader { geometry in
            let shape = DiamondShape()

            switch card.shading {
            case .open: shape.stroke(color, lineWidth: geometry.size.width * 0.05)
            case .solid: shape.fill(color)
            case .striped: shape.fill(color).opacity(0.3)
            }
        }
    }
}

struct DiamondShape: Shape {
    func path(in rect: CGRect) -> Path {
        let top = CGPoint(x: rect.midX, y: rect.maxY)
        let right = CGPoint(x: rect.maxX, y: rect.midY)
        let bottom = CGPoint(x: rect.midX, y: rect.minY)
        let left = CGPoint(x: rect.minX, y: rect.midY)
        var p = Path()
        p.move(to: top)
        p.addLine(to: right)
        p.addLine(to: bottom)
        p.addLine(to: left)
        p.addLine(to: top)

        return p
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        var card = SetModel.Card(color: SetModel.ColorEnum.green, number: SetModel.NumberEnum.three, shape: SetModel.ShapeEnum.diamond, shading: SetModel.ShadingEnum.open, id: 0)
        card.selected = false
        return CardView(card)
    }
}

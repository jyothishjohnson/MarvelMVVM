//
//  TriangleShape.swift
//  SwiftUIAnimations
//
//  Created by Jyothish New on 23/05/21.
//

import SwiftUI

struct TriangleShape: View {
    var body: some View {
        TriangleShapeStruct()
            .stroke(lineWidth: 1)
            .frame(width: 200, height: 200)
    }
}

struct TriangleShapeStruct : Shape {
    
    func path(in rect: CGRect) -> Path {

        let length = rect.size.width < rect.size.height ? rect.size.width : rect.size.height

        return Path { path in
            
            path.move(to: .init(x: length/2, y: 0))
            path.addLine(to: .init(x: length, y: length))
            path.addLine(to: .init(x: 0, y: length))
            path.addLine(to: .init(x: length/2, y: 0))
        }
        
    }
}

struct TriangleShape_Previews: PreviewProvider {
    static var previews: some View {
        TriangleShape()
    }
}

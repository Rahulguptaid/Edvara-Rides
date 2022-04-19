//
//  TextWithImage.swift
//  Rahul Gupta Edvora Test
//
//  Created by Rahul Gupta on 18/04/22.
//

import SwiftUI
struct TextWithImage: View {
    var textValue: String
    var body: some View {
        HStack {
            Text(textValue)
                .font(.custom(AppFonts.Inter_Medium.rawValue, size: 14))
                .foregroundColor(.black)
            Spacer()
            Image("dropDownImage")
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8).fill(Color.appCellBackground)
        )
    }
}

struct TextWithImage_Previews: PreviewProvider {
    static var previews: some View {
        TextWithImage(textValue: "State")
    }
}

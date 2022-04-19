//
//  SelectedTabItemView.swift
//  Rahul Gupta Edvora Test
//
//  Created by Rahul Gupta on 18/04/22.
//

import SwiftUI
// Custom call for Selected and unselected tab button
struct SelectedTabItemView: View {
    var isSelected : Bool
    var title : String
    // property closure to update data on tab according to selected tab
    var didSelectCell : (()->())
    var body: some View {
        VStack(alignment:.leading,spacing: 3) {
            Button {
                didSelectCell()
            } label: {
                if isSelected {
                    Text(title)
                        .font(.custom(AppFonts.Inter_Bold.rawValue, size: 14))
                        .foregroundColor(.black)
                    
                }
                else {
                    Text(title)
                        .font(.custom(AppFonts.Inter_Medium.rawValue, size: 14))
                        .foregroundColor(.gray)
                }
            }
            if isSelected {
                Rectangle()
                    .fill(Color.appBlue)
                    .frame(width: 40, height: 2)
            }
        }
    }
}

struct SelectedTabItemView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedTabItemView(isSelected: true, title: "Nearest", didSelectCell: {})
    }
}

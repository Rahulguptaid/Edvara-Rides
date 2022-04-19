//
//  RideListViewCell.swift
//  Rahul Gupta Edvora Test
//
//  Created by Rahul Gupta on 18/04/22.
//

import SwiftUI

struct RideListViewCell: View {
    var cellData : RidesModelElement
    var didSelectCell : ((RidesModelElement)->())?
    var body: some View {
            VStack {
                // Show Ride image coming in its model
                AsyncImage(url:  URL(string: cellData.mapURL)!,
                           placeholder: { Image("SampleImage").resizable() }, image: { Image(uiImage: $0)
                    .resizable() })
                    .frame(height:200)
                HStack {
                    HStack{
                        Image("rideIDImage")
                            .resizable()
                            .frame(width: 14, height: 14)
                        Text("\(cellData.id)")
                            .foregroundColor(.black)
                            .font(.custom(AppFonts.Inter_Medium.rawValue, size: 14))
                    }
                    Spacer()
                    HStack{
                        Image("dateImage")
                            .resizable().frame(width: 14, height: 14)
                        // Show Date which is calculated in its model
                        Text(cellData.rideFormattedDate)
                            .foregroundColor(.black)
                            .font(.custom(AppFonts.Inter_Medium.rawValue, size: 14))
                    }
                }.padding()
            }.background(Color.appCellBackground)
            .cornerRadius(10)
            .padding()
            .onTapGesture {
            didSelectCell?(cellData)
        }
    }
}

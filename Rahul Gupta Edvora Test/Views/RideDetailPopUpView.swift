//
//  RideDetailPopUpView.swift
//  Rahul Gupta Edvora Test
//
//  Created by iOS TL on 19/04/22.
//

import SwiftUI

struct RideDetailPopUpView: View {
    var cellData : RidesModelElement
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 40, height: 2)
            }.padding(.bottom)
            AsyncImage(url:  URL(string: cellData.mapURL)!,
                       placeholder: { Image("SampleImage").resizable() }, image: { Image(uiImage: $0)
                .resizable() })
                .frame(height:200)
                .cornerRadius(25)
                .padding(.horizontal)
            Group {
                VStack {
                    HStack {
                        VStack(alignment:.leading) {
                            Text("Ride ID")
                                .font(.custom(AppFonts.Inter_Medium.rawValue, size: 10))
                            Text("\(cellData.id)")
                        }
                        Spacer()
                        VStack(alignment:.leading) {
                            Text("Origin Station")
                                .font(.custom(AppFonts.Inter_Medium.rawValue, size: 10))
                            Text("\(cellData.originStationCode)")
                        }.frame(width:100)
                    }.padding()
                    Divider()
                    HStack {
                        VStack(alignment:.leading) {
                            Text("Date")
                                .font(.custom(AppFonts.Inter_Medium.rawValue, size: 10))
                            Text(cellData.rideFormattedDate)
                        }
                        Spacer()
                        VStack(alignment:.leading) {
                            Text("Distance        ")
                                .font(.custom(AppFonts.Inter_Medium.rawValue, size: 10))
                                // Calculating deistance in the Model class according to current user Station code
                            Text("\(cellData.distance)")
                        }.frame(width:100)
                    }.padding()
                    Divider()
                    HStack {
                        VStack(alignment:.leading) {
                            Text("State")
                                .font(.custom(AppFonts.Inter_Medium.rawValue, size: 10))
                            Text(cellData.state)
                        }
                        Spacer()
                        VStack(alignment:.leading) {
                            Text("City                  ")
                                .font(.custom(AppFonts.Inter_Medium.rawValue, size: 10))
                            Text(cellData.city)
                        }.frame(width:100)
                    }.padding()
                    Divider()
                    HStack {
                        VStack(alignment:.leading) {
                            Text("Station Path")
                                .font(.custom(AppFonts.Inter_Medium.rawValue, size: 10))
                            Text(cellData.stationPathString)
                        }
                        Spacer()
                    }.padding()
                }.padding()
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
            }.padding()

            
        }
        .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
        .background(Color.popUpBackground.blur(radius: 2))
        .cornerRadius(25)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.4), radius: 10.0)
    }
}


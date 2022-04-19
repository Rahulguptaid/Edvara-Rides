//
//  FilterPopupView.swift
//  Rahul Gupta Edvora Test
//
//  Created by Rahul Gupta on 19/04/22.
//

import SwiftUI

struct FilterPopupView: View {
    @Binding var displayItem:Bool
    @ObservedObject var viewModel : RidesTabViewModel
    var body: some View {
      ZStack{
          Rectangle()
          .fill(Color.clear)
          VStack {
              Spacer()
              HStack {
                  Spacer()
                  VStack(alignment:.leading) {
                      Text("Filter")
                          .font(.custom(AppFonts.Inter_Medium.rawValue, size: 14))
                          .foregroundColor(.black)
                      // Show DropDown for State list
                      Menu {
                          ForEach(viewModel.stateCityList, id: \.self){ client in
                              Button(client.name) {
                                  viewModel.selectedState = client.name
                                  viewModel.selectedCity  = "City"
                              }
                          }
                      } label: {
                          TextWithImage(textValue: viewModel.selectedState)
                      }.padding(.vertical)
                      // Show DropDown for City list of selected state
                      Menu {
                          ForEach(viewModel.cityListForSelectedState(), id: \.self){ client in
                              Button(client) {
                                  viewModel.selectedCity = client
                              }
                          }
                      } label: {
                          TextWithImage(textValue: viewModel.selectedCity)
                      }
                  }.padding()
              }
              .frame(width: 300, height: 210)
              .fixedSize(horizontal: true, vertical: true)
              .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(1)))
              .cornerRadius(16)
              .overlay(
                      RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray, lineWidth: 0.5)
                  )
              Spacer()
            }
        }
    }
}
struct FilterPopupView_Previews: PreviewProvider {
    @State static var display : Bool = true
    static var previews: some View {
        FilterPopupView(displayItem: FilterPopupView_Previews.$display, viewModel: RidesTabViewModel())
    }
}

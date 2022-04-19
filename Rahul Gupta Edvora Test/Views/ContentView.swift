//
//  ContentView.swift
//  Rahul Gupta Edvora Test
//
//  Created by Rahul Gupta on 17/04/22.
//

import SwiftUI
import PopupView
import AlertToast
struct ContentView: View {
    // View Model for handling Data or Api related task
    @ObservedObject var viewModel   : RidesTabViewModel
    @State var selected             = 0
    @State var displayFilter : Bool = false
    init() {
        // Initialising viewModel
        viewModel = RidesTabViewModel()
        UITableView.appearance().backgroundColor = .clear
    }
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Edvora")
                        .font(.custom(AppFonts.SF_Pro_Display_Bold.rawValue, size: 44))
                    Spacer()
                    if let user = viewModel.userDetail {
                        // Load user image from the user coming the User Detail form Api
                        AsyncImage(url: user.imageURL,
                                   placeholder: { Image("user_img") }, image: { Image(uiImage: $0).resizable() }).frame(width: 60, height: 60)
                            .clipShape(Circle())
                    }
                    else {
                        Image("user_img")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 60, height: 60)
                    }
                }
                .padding(.horizontal)
                HStack {
                    // Use custom Button view to show the desired Button selected and unselected view
                    SelectedTabItemView(isSelected: viewModel.selectedRidesType == .nearest, title: "Nearest", didSelectCell: {
                        viewModel.selectedRidesType = .nearest
                        selected = 0
                    })
                    SelectedTabItemView(isSelected: viewModel.selectedRidesType == .upComming, title: "Upcoming (\(viewModel.upcomingRides.count))", didSelectCell: {
                        viewModel.selectedRidesType = .upComming
                        selected = 1
                    })
                    SelectedTabItemView(isSelected: viewModel.selectedRidesType == .past, title: "Past (\(viewModel.pastRides.count))", didSelectCell: {
                        viewModel.selectedRidesType = .past
                        selected = 2
                    })
                    
                    Spacer()
                    // Filter Button
                    Button {
                        displayFilter.toggle()
                    } label: {
                        Image("filterImage").frame( height: 20)
                        Text("Filters").font(.custom(AppFonts.Inter_Medium.rawValue, size: 14))
                            .foregroundColor(.black)
                    }
                }.padding(.horizontal)
                // Add All the the Tab Views to show according to selected tab
                TabView(selection: $selected){
                    // For Nearest
                    RideListView(viewModel: viewModel, type: .nearest).tag(0)
                    
                    // For Upcoming
                    RideListView(viewModel: viewModel, type: .upComming).tag(1)
                    
                    // For Past
                    RideListView(viewModel: viewModel, type: .past).tag(2)
                    
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            // Show filter when user tap on filter button
            if displayFilter {
                // Add filer popup view to desired location
                FilterPopupView(displayItem: $displayFilter, viewModel:viewModel)
                    .padding(.top, -300)
                    .padding(.trailing,-50)
            }
        }.popup(isPresented: $viewModel.displayDetail, type: .toast, position: .bottom) {
            if let detail = viewModel.selectedCellDetail  {
                // Show Detail View popup when user click on any cell it action is handeled by the viewodel class
                RideDetailPopUpView(cellData: detail)
            }
        }
        // For showing toast on the screen. This toast is being handled be Viewmodel it published error to the toast to show
        .toast(isPresenting: $viewModel.showAlert){
            AlertToast(displayMode: .banner(.slide), type: .regular, title: viewModel.error ?? "Server Error!")
        }
        // For showing Loader on the screen. This loader is being handled by Viewmodel it published loading bool
        .toast(isPresenting: $viewModel.showLoading){
                        AlertToast(type: .loading)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

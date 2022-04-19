//
//  RideListView.swift
//  Rahul Gupta Edvora Test
//
//  Created by Rahul Gupta on 18/04/22.
//

import SwiftUI

struct RideListView: View {
    @ObservedObject var viewModel : RidesTabViewModel
    var type : RidesType
    var body: some View {
        // Show the selected tab data and also filetered data. this data is managed in teh viewModel class according to user choice
        List(viewModel.selectedRidesData, rowContent: { cellData in
            RideListViewCell(cellData: cellData, didSelectCell: { data in
                // handle the user selection of the cell and update the View model according to that to the detail popup
                viewModel.selectedCellDetail = data
                viewModel.displayDetail.toggle()
            }).listRowBackground(Color.white)
        }).listStyle(GroupedListStyle())
    }
}

struct RideListView_Previews: PreviewProvider {
    static var previews: some View {
        RideListView(viewModel: RidesTabViewModel(), type: .nearest)
    }
}

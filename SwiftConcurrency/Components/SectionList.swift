    //
    //  SectionList.swift
    //  SwiftConcurrency
    //
    //  Created by IACD-013 on 2022/06/27.
    //

import SwiftUI

struct SectionList: View {
    @EnvironmentObject var sectionViewModel : SectionViewModel
    
    var body: some View {
        List{
                ///the `$` lets us use binding to allow us to modify the is pinnned variable
                ///Swipe Actions implemented
            ForEach($sectionViewModel.sections, id: \.id){$section in
                HStack {
                    Text(section.title)
                    Spacer()
                    
                    if section.isPinned {
                        Image(systemName: "pin.fill")
                            .foregroundColor(.yellow)
                    }
                }
                .swipeActions {
                    Button{
                        section.isPinned.toggle()
                        sectionViewModel.orderSectionsByPinned()
                    }label: {
                        if section.isPinned {
                            Label("Unpin", systemImage: "pin.slash")
                        }
                        else{
                            Label("Pin", systemImage: "pin")
                        }
                    }
                }
                .tint(.yellow)
            }
        }.task {
            await sectionViewModel.fetch()
        }
        .refreshable {
                //pull down function for refreshing
            await sectionViewModel.randomizeSections()
        }
    }
}

struct SectionList_Previews: PreviewProvider {
    static var previews: some View {
        SectionList()
            .environmentObject(SectionViewModel())
    }
}

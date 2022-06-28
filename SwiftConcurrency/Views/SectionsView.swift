    //
    //  SectionsView.swift
    //  SwiftConcurrency
    //
    //  Created by IACD-013 on 2022/06/27.
    //

import SwiftUI

struct SectionsView: View {
        //update the seach so the searhced items show
    @EnvironmentObject var sectionsViewModel: SectionViewModel
        //restore the list to the way it was when the search is done
    @Environment(\.isSearching) var isSearching
    var body: some View {
        VStack{
            if isSearching {
                if sectionsViewModel.filteredSections.count > 0{
                        //Display the filtered sections
                    List(sectionsViewModel.filteredSections) { section in
                        Text(section.title)
                    }
                } else{
                    //array is empty
                    List(0..<1) {section in
                        Text("No results")
                    }
                }
            } else{
                SectionList()
                    .listStyle(.plain)
            }
            
        }
        .navigationTitle(Text("All Sections"))
    }
}

struct SectionsView_Previews: PreviewProvider {
    static var previews: some View {
        SectionsView()
            .environmentObject(SectionViewModel())
    }
}

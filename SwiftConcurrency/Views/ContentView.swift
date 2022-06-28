    //
    //  ContentView.swift
    //  SwiftConcurrency
    //
    //  Created by IACD-013 on 2022/06/24.
    //

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var courseViewModel: CourseViewModel
    @EnvironmentObject var sectionViewModel: SectionViewModel
    @StateObject var modalManager = ModalManager()
    
    @State private var text = ""
    
    var body: some View {
        ZStack {
            TabView{
                HomeView()
                    .environmentObject(modalManager) // allows us to access and change it in the home view
                    .tabItem {
                        Image(systemName: "house")
                        Text("Learn Now")
                    }
                NavigationView{
                    SectionsView()
                        ///implement the searchable modifier
                        .searchable(text: $text){
                            ForEach(sectionViewModel.sections.prefix(3)){ section in
                                Text(section.title)
                                    .searchCompletion(section.title)
                            }
                        }
                }
                .onSubmit(of: .search) {
                    sectionViewModel.filterSections(for: text)
                }
                .tabItem {
                    Image(systemName: "square.stack.3d.down.right.fill")
                    Text("Sections")
                }
                AccountView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Account")
                    }
            }
                ///`Task` handles async function and `OnAppear` doesn't handle async
            .task{
                await courseViewModel.fetch()
            }
            if modalManager.showModal{
                ModalManagerView()
                    .environmentObject(modalManager)// passing the modal manager instance we created in content view
                    
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CourseViewModel())
            .environmentObject(SectionViewModel())
    }
}

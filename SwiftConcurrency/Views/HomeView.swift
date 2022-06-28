    //
    //  HomeView.swift
    //  SwiftConcurrency
    //
    //  Created by IACD-013 on 2022/06/24.
    //

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var courseViewModel: CourseViewModel
    @EnvironmentObject var modalManager: ModalManager
    //adding an attributed string to the featured word and not the whole thing
    var attributedString: AttributedString {
        var subject = AttributedString(courseViewModel.featuredSubject.rawValue)
        var container  = AttributeContainer()
        
        //prevent crashh becasue the array statrs empty
        if courseViewModel.featuredCourses.count > 0 {
        let color = Color.init(hex: courseViewModel.featuredCourses[0].colors[0]!)
        container.foregroundColor = color
        }
        else{
            container.foregroundColor = .red
        }
        subject.mergeAttributes(container)
        return "Learn " + subject
    }
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView{
                VStack(spacing: 0){
                    HStack {
                        DateTitle(title: attributedString)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top,20)
                        
                        
                        Spacer()
                        
                        ProfileIcon().onTapGesture {
                            modalManager.showModal.toggle()
                        }
                    }
                    .padding(.horizontal,20)
                    
                    FeaturedCourseList(featuredCourses: courseViewModel.featuredCourses)
                        .padding(.top,20)
                    
                    Text("All Courses")
                        .fontWeight(.bold)
                        .padding(.horizontal, 20)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top,40)
                    
                    CourseList(courses: courseViewModel.courses)
                        .padding(.top, 20)
                }
            }
                ///This will give the top status bar a white color
            Color(.white)
                .animation(.easeIn)
                .ignoresSafeArea()
                .frame(height: 0)
            
            
        }.navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(CourseViewModel())
            .environmentObject(ModalManager())
    }
}

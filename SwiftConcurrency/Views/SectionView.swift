    //
    //  SectionView.swift
    //  SwiftConcurrency
    //
    //  Created by IACD-013 on 2022/06/28.
    //

import SwiftUI

struct SectionView: View {
        //custom back button
    @Environment(\.presentationMode) var presentationMode
    var course: Course
    var section: SectionsCollection.Section
    
    var body: some View {
        ZStack(alignment: .top) {
            content
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    CloseButton()
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .frame(maxWidth: .infinity)
            .frame(height: 44)
        }
        .navigationBarHidden(true)
    }
    
    var content: some View {
        ScrollView {
            SectionViewCover(course: course, section: section)
            
            Text(section.content)
                .padding(16)
                .padding(.bottom, 100)
        }
        .ignoresSafeArea()
    }
}


struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(course: coursePreviewData, section:( coursePreviewData.sectionCollection?.sections[0])!)
    }
}

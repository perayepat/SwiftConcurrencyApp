    //
    //  CourseList.swift
    //  SwiftConcurrency
    //
    //  Created by IACD-013 on 2022/06/24.
    //

import SwiftUI

struct CourseList: View {
    var courses : [Course]
    var columns = [GridItem(.adaptive(minimum: 160),spacing: 15)]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ///Adding a redacted placeholder and using a if statement to switch between the place holder and the actual data
            if courses.count > 0 {
                ForEach(courses, id: \.id){ course in
                    CourseCard(course: course)
                }
            } else {
                ForEach(0..<4, id: \.self) { number in
                    CourseCard(course: coursePreviewData)
                        .redacted(reason: .placeholder)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList(courses: [coursePreviewData])
    }
}

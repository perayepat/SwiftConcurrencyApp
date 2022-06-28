    //
    //  CourseModel.swift
    //  SwiftConcurrency
    //
    //  Created by IACD-013 on 2022/06/26.
    //
    ///we use acuston initializer beacuse the data is stored in a specific  way which also gives us more control over how the data is captured

import Foundation
import SwiftUI

    ///shortcut to the Course Collection
    ///
typealias CoursesData  = CourseQuery.Data.CourseCollection

struct CoursesCollection: Decodable {
    let courses: [Course]
        ///pass graphQL data through this ini
        ///`Map` goes through each element in the array
    init(_ CoursesCollection: CoursesData?){
        self.courses = CoursesCollection?.courses.map({ course -> Course in
            /// go through each course and initialize it with the data from graohQL
            Course(course)
        }) ?? []
    }
}

///process graphQL Data
struct Course: Identifiable, Decodable {
    let id: String
    let publishedAt: String
    let title: String
    let subtitle: String
    let numberOfSections: Int
    let numberOfHours: Int
    let subject: String
    let colors: [String?]
    let illustration: String
    let sectionCollection: SectionsCollection?
    
    ///initialize each course since we map through each course
    init(_ course: CoursesData.Course?) {
        self.id = course?.sys.id ?? ""
        self.publishedAt = course?.sys.publishedAt ?? ""
        self.title = course?.title ?? ""
        self.subtitle = course?.subtitle ?? ""
        self.numberOfSections = course?.numberOfSections ?? 0
        self.numberOfHours = course?.numberOfHours ?? 0
        self.subject = course?.subject ?? ""
        self.colors = course?.colors ?? ["#0279FF","#4FA3FF"]
        self.illustration = course?.illustration?.url ?? ""
        self.sectionCollection = SectionsCollection(course?.sectionCollection)
    }
}

struct SectionsCollection: Decodable{
    let sections: [Section]
    
    init(_ sectionsCollection: CoursesData.Course.SectionCollection?){
        self.sections = sectionsCollection?.sections.map({ section -> Section in
            Section(section)
        }) ?? []
    }
    
    struct Section: Identifiable, Decodable{
        let id: String
        let title: String
        let subtitle: String
        let content: String
        
        init(_ section: CoursesData.Course.SectionCollection.Section?) {
            self.id = section?.sys.id ?? ""
            self.title = section?.title ?? ""
            self.subtitle = section?.subtitle ?? ""
            self.content = section?.content ?? ""
        }
    }
}

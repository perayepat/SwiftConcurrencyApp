    //
    //  CourseViewModel.swift
    //  SwiftConcurrency
    //
    //  Created by IACD-013 on 2022/06/26.
    //
    /// we are able to alert the whole program of changes using the `ObservableObject`
    /// Using `Continuation` which acts like a bridge between completion handlers and async functions
    /// Turning an old fucntion that uses completion handlers to a async one
    /// `Throws` because it might return an error
    /// make it optional to incase we have nothing to return
    ///
import Foundation
import Apollo


//this determines which subject was selected
enum FeaturedSubject: String, CaseIterable{
    case SwiftUI = "SwiftUI"
    case Design = "Design"
}


class CourseViewModel: ObservableObject{
    @Published public private(set) var courses: [Course] = []
    @Published public private(set) var featuredCourses: [Course] = []
    
    var featuredSubject: FeaturedSubject = FeaturedSubject.allCases.randomElement() ?? .SwiftUI

       
    private func queryCourses() async throws -> GraphQLResult<CourseQuery.Data>?{
        return await withCheckedContinuation{ continuation in
                ///The closure `result` is a completion handler
            let preferredLanguage = Locale.preferredLanguages[0] // using the language that's set on the phone
            let locale = preferredLanguage.contains("en") ? "en-US" : "es"
            Network.shared.apollo.fetch(query: CourseQuery(locale: locale )) { result in
                    ///access the results
                switch result{
                case .success(let graphQLResult):
                    continuation.resume(returning: graphQLResult)
                case .failure(let error):
                    print("Network or response format error:  \(error)")
                    if let error = error as? Never{
                        continuation.resume(throwing: error)
                    }
                }
                
            }
        }
        
    }
    
    func fetch() async{
        do{
            let result = try await queryCourses()
            if let result = result {
                ///if we have a course collection from the graphQL results
                if let courseCollection = result.data?.courseCollection{
                    //process returns and array of courses
                    DispatchQueue.main.async {
                        self.courses = self.process(data: courseCollection)
                        self.findFeaturedCourses()
                    }
                }
            }
        }
        catch {
        print("Error", error)
        }
    }
    // return an array of courses and process the data from contentful
    private func process(data: CoursesData) -> [Course]{
        let content = CoursesCollection.init(data)
        return content.courses
    }
    
    ///Get the subject by using the enum to filter through courses that have the same subject
    private func findFeaturedCourses() {
        guard courses.count > 0 else {return}
        
        featuredCourses = courses.filter { course in
            course.subject == featuredSubject.rawValue
        }
    }
}

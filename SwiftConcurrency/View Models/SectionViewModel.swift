//
//  SectionViewModel.swift
//  SwiftConcurrency
//
//  Created by IACD-013 on 2022/06/27.
//

import Foundation
import Apollo

//same as the course view model
class SectionViewModel: ObservableObject {
    @Published public var sections: [SectionsDataCollection.SectionModel] = []
    @Published public private(set) var filteredSections: [SectionsDataCollection.SectionModel] = []
    
    //get data from contentful using apollo graphql
    private func querySections() async throws -> GraphQLResult<SectionQuery.Data>?{
        return await withCheckedContinuation{ continuation in
                ///The closure `result` is a completion handler
            Network.shared.apollo.fetch(query: SectionQuery()) { result in
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
    //fetch data from contentful
    func fetch() async{
        do{
            let result = try await querySections()
            if let result = result {
                ///if we have a course collection from the graphQL results
                if let sectionCollection = result.data?.sectionCollection{
                    //process returns and array of courses
                    DispatchQueue.main.async {
                        self.sections = self.process(data: sectionCollection)
                    }
                }
            }
        }
        catch {
        print("Error", error)
        }
    }
    
        // return an array of courses and process the data from contentful
    private func process(data: SectionsCollectionData) -> [SectionsDataCollection.SectionModel]{
            let content = SectionsDataCollection.init(data)
        
        return content.sections
        }
    
    //Allowing the user to refresh by pulling down the screen
    func randomizeSections() async {
        DispatchQueue.main.async {
            self.sections.shuffle()
        }
    }
 
    //place the pinned sections at the top of the list
    func orderSectionsByPinned(){
        //takes a look at all the elements and puts the isPinned to the top of the list 
        sections.sort{ $0.isPinned && !$1.isPinned}
    }
    
    //search through the sections array
    func filterSections(for text:String){
        filteredSections = []
        let serachText = text.lowercased()
    
        sections.forEach { section in
            let searchContent = section.title
            //check if we have a section title that matches the one the user inputed
            if searchContent.lowercased().range(of: serachText, options: .regularExpression) != nil{
                filteredSections.append(section)
            }
        }
    }
    
}

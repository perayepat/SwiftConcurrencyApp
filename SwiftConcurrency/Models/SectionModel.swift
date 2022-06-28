    //
    //  SectionModel.swift
    //  SwiftConcurrency
    //
    //  Created by IACD-013 on 2022/06/27.
    //

import Foundation

typealias SectionsCollectionData = SectionQuery.Data.SectionCollection

//each 
struct SectionsDataCollection: Decodable {
    let sections: [SectionModel]
    
    init(_ sectionsCollection: SectionsCollectionData?) {
        self.sections = sectionsCollection?.sections.map({ section -> SectionModel in
            SectionModel(section)
        }) ?? []
    }
    
    struct SectionModel: Decodable, Identifiable {
        let id: String
        let title: String
        var isPinned: Bool
        
        init(_ section: SectionQuery.Data.SectionCollection.Section?) {
            self.id = section?.sys.id ?? ""
            self.title = section?.title ?? ""
            self.isPinned = false
        }
    }
}

//
//  DateTitle.swift
//  SwiftConcurrency
//
//  Created by IACD-013 on 2022/06/24.
//

import SwiftUI

struct DateTitle: View {
    var title: AttributedString
    @State private var date: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            
            Text(date.uppercased())
                .font(.footnote)
                .fontWeight(.medium)
                .opacity(0.7)
            
            Text(title)
                .font(.largeTitle).bold()
        }
        .accessibilityAddTraits([.isHeader])
        .onAppear{
            date = Date.now.formatted(.dateTime.weekday().month().day())
        }
        
    }
}

struct DateTitle_Previews: PreviewProvider {
    static var attributedString:  AttributedString{
        var subject = AttributedString("SwiftUI")
        var container  = AttributeContainer()
        container.foregroundColor = .purple
        subject.mergeAttributes(container)
        return "Learn " + subject
    }
    static var previews: some View {
        DateTitle(title: attributedString)
    }
}

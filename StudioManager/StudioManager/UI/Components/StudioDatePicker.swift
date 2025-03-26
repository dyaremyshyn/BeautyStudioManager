//
//  StudioDatePicker.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 26/03/2025.
//

import SwiftUI

struct StudioDatePicker: View {
    let title: String
    @Binding var selection: Date
    var minuteInterval: Int
    var mode: UIDatePicker.Mode = .dateAndTime

    var body: some View {
        HStack{
            Text(title)
                .font(.callout)
            DatePickerRepresentable(date: $selection, minuteInterval: minuteInterval, mode: mode)
        }
    }
}

#Preview {
    VStack{
        StudioDatePicker(title: "NewAppointment", selection: .constant(.now), minuteInterval: 30, mode: .dateAndTime)
        StudioDatePicker(title: "Service", selection: .constant(Date(timeIntervalSince1970: 0)), minuteInterval: 10, mode: .time)
        Spacer()
    }
    .padding(.horizontal)
}

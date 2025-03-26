//
//  DatePickerRepresentable.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 26/03/2025.
//

import SwiftUI

struct DatePickerRepresentable: UIViewRepresentable {
    @Binding var date: Date
    var minuteInterval: Int
    var mode: UIDatePicker.Mode = .dateAndTime
    
    func makeUIView(context: Context) -> UIDatePicker {
        let picker = UIDatePicker()
        picker.datePickerMode = mode
        picker.minuteInterval = minuteInterval
        picker.addTarget(context.coordinator, action: #selector(Coordinator.dateChanged(_:)), for: .valueChanged)
        return picker
    }

    func updateUIView(_ uiView: UIDatePicker, context: Context) {
        uiView.date = date
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: DatePickerRepresentable
        init(_ parent: DatePickerRepresentable) { self.parent = parent }
        @objc func dateChanged(_ sender: UIDatePicker) {
            parent.date = sender.date
        }
    }
}

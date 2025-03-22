//
//  Localization.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 18/03/2025.
//

import Foundation

enum tr {
    private static func t(_ key: String.LocalizationValue) -> String {
        String(localized: key)
    }
}

// MARK: General
extension tr {
    static let save = t("save")
    static let date = t("date")
    static let servicesTitle = t("servicesTitle")
    static let filterToday = t("filterToday")
    static let filterWeek = t("filterWeek")
    static let filterMonth = t("filterMonth")
    static let filterYear = t("filterYear")
    static let filterAll = t("filterAll")
    static let errorTitle = t("errorTitle")
    static let cancel = t("cancel")
    static let successTitle = t("successTitle")
    static let emptyName = t("emptyName")
    static let emptyPrice = t("emptyPrice")
    static let invalidDate = t("invalidDate")
}

// MARK: Tab
extension tr {
    static let agendaTitle = t("agendaTitle")
    static let balanceTitle = t("balanceTitle")
}

// MARK: Agenda view
extension tr {
    static let emptyAppointmentsDescription = t("emptyAppointmentsDescription")
    static let errorDeletingAppointment = t("errorDeletingAppointment")
    static let noAppointmentsToAddToCalendar = t("noAppointmentsToAddToCalendar")
    static let errorAddingAppointmentToCalendar = t("errorAddingAppointmentToCalendar")
    static let appointmentsAddedToCalendar = t("appointmentsAddedToCalendar")
    static let appointmentAtHome = t("appointmentAtHome")
}

// MARK: NewAppointment view
extension tr {
    static let editAppointmentTitle = t("editAppointmentTitle")
    static let newAppointmentTitle = t("newAppointmentTitle")
    static let clientName = t("clientName")
    static let clientDetails = t("clientDetails")
    static let clientPhoneNumber = t("clientPhoneNumber")
    static let appointmentDetails = t("appointmentDetails")
    static let appointmentEmptyDescription = t("appointmentEmptyDescription")
    static let appointmentPrice = t("appointmentPrice")
    static let appointmentDate = t("appointmentDate")
    static let appointmentType = t("appointmentType")
    static let appointmentInResidence = t("appointmentInResidence")
    static let emptyClientName = t("emptyClientName")
    static let appointmentAddedSuccessfully = t("appointmentAddedSuccessfully")
    static let addServices = t("addServices")
}

// MARK: Expense view
extension tr {
    static let expenseTitle = t("expenseTitle")
    static let expenseName = t("expenseName")
    static let expensePrice = t("expensePrice")
    static let expenseDetails = t("expenseDetails")
    static let expenseAddedSuccessfully = t("expenseAddedSuccessfully")
}

// MARK: AppointmentService view
extension tr {
    static let serviceName = t("serviceName")
    static let servicePrice = t("servicePrice")
    static let serviceDuration = t("serviceDuration")
    static let serviceDetails = t("serviceDetails")
}

// MARK: Balance view
extension tr {
    static let addExpense = t("addExpense")
    static let expensesTitle = t("expensesTitle")
    static let incomeTitle = t("incomeTitle")
    static let noDataDescription = t("noDataDescription")
}

// MARK: Service
extension tr {
    static let editServiceTitle = t("editServiceTitle")
    static let newServiceTitle = t("newServiceTitle")
    static let serviceAddedSuccessfully = t("serviceAddedSuccessfully")
    static let invalidDuration = t("invalidDuration")
    static let emptyServicesDescription = t("emptyServicesDescription")
    static let makeupService = t("makeupService")
    static let hairstylesService = t("hairstylesService")
    static let nailsService = t("nailsService")
    static let skincareService = t("skincareService")
    static let liftingService = t("liftingService")
    static let eyebrowsService = t("eyebrowsService")
}

// MARK: Icon Picker
extension tr {
    static let iconsTitle = t("iconsTitle")
    static let suggestionsSubtitle = t("suggestionsSubtitle")
}

import Foundation

struct Bill: Codable, Hashable, Identifiable {
    static func == (lhs: Bill, rhs: Bill) -> Bool {
        return lhs.id == rhs.id &&
            lhs.creationTimestamp == rhs.creationTimestamp &&
            lhs.hospitalName == rhs.hospitalName &&
            lhs.hospitalAddress == rhs.hospitalAddress &&
            lhs.hospitalContactInfo == rhs.hospitalContactInfo &&
            lhs.patientID == rhs.patientID &&
            lhs.doctorID == rhs.doctorID &&
            lhs.billingDate == rhs.billingDate &&
            lhs.items == rhs.items &&
            lhs.totalAmountDue == rhs.totalAmountDue &&
            lhs.amountPaid == rhs.amountPaid &&
            lhs.paymentMethod == rhs.paymentMethod &&
            lhs.paymentDate == rhs.paymentDate &&
            lhs.outstandingBalance == rhs.outstandingBalance &&
            lhs.notes == rhs.notes &&
            lhs.discountsOrAdjustments == rhs.discountsOrAdjustments &&
            lhs.taxes == rhs.taxes &&
            lhs.referralInfo == rhs.referralInfo
    }
    
    var id: UUID
    var creationTimestamp: Date

    var hospitalName: String
    var hospitalAddress: String
    var hospitalContactInfo: String
     
    var patientID: String
    var doctorID: String

    var billingDate: Date
    var items: [BillItem]

    var totalAmountDue: Double?
    var amountPaid: Double?
    var paymentMethod: String
    var paymentDate: Date
    var outstandingBalance: Double?

    var notes: String?
   
    var discountsOrAdjustments: Double?
    var taxes: Double?
    var referralInfo: String?
}

struct BillItem: Codable, Hashable {
    var id: UUID
    var description: String
    var quantity: Int?
    var pricePerService: Double?
    var totalCharge: Double?
    
    init(id: UUID , description: String, quantity: Int? = nil, pricePerService: Double? = nil, totalCharge: Double? = nil) {
            self.id = id
            self.description = description
            self.quantity = quantity
            self.pricePerService = pricePerService
            self.totalCharge = totalCharge
        }
}

import FirebaseFirestore
import Firebase

class Services {
    static let shared = Services()
    let db = Firestore.firestore()
    
    func saveBill(_ bill: Bill, items: [BillItem]) {
        do {
            let billData = try Firestore.Encoder().encode(bill)
            
            db.collection("bills").addDocument(data: billData) { error in
                if let error = error {
                    print("Error adding bill document: \(error)")
                    return
                }
                
                self.db.collection("bills").addSnapshotListener { querySnapshot, error in
                    guard let documents = querySnapshot?.documents else {
                        print("Error fetching documents: \(error!)")
                        return
                    }
                    
                    for document in documents {
                        let documentID = document.documentID
                        for item in items {
                            do {
                                let itemData = try Firestore.Encoder().encode(item)
                                self.db.collection("bills").document(documentID).collection("billItems").addDocument(data: itemData)
                            } catch {
                                print("Error encoding bill item: \(error)")
                            }
                        }
                    }
                }
            }
        } catch let error {
            print("Error encoding bill: \(error)")
        }
    }
}

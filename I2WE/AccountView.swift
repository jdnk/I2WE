//
//  AccountView.swift
//  I2WE
//
//  Created by Jaden Kim on 11/2/20.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct AccountView: View {
    @EnvironmentObject var userInfo: UserInfo
    @Environment(\.presentationMode) var presentationMode
    @State private var showError = false
    @State private var errorString = ""
    
    private var curUser = Auth.auth().currentUser?.uid
    private var docRef = Firestore
        .firestore()
        .collection(FBKeys.CollectionPath.users)

    var body: some View {
        docRef.document(curUser!)
            .getDocument { (snapshot, err) in
            if let document = snapshot {
            let user = User.transformUser(dict: document.data()!, key: document.documentID)
                completion(user)
             } else {
              print("Document does not exist")
            }
        
        NavigationView {
            VStack {
                Group {
                    VStack(alignment: .leading) {
                    }
                        Text("Yo")
                    }
                }
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

//
//  CustomOrders.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 2/3/21.
//

import SwiftUI
import MessageUI

struct CustomOrders: View {
    
    @State var screenWidth = UIScreen.main.bounds.width
        @State var result: Result<MFMailComposeResult, Error>? = nil
        @State var isShowingMailView = false
    
    var body: some View {
            ScrollView{
                GroupBox{
                    HStack{
                        Image(systemName: "info.circle")
                            .padding(.leading, -120)
                        Text("Criterii si optiuni")
                            .padding(.leading, -95)
                            .font(.title3)
                    }
                    .padding(.bottom, -1)
                    
                    Divider()
                    HStack{
                        VStack{
                            Image("oj")
                                .resizable()
                                .frame(width: 80, height: 60)
                            Image("oj")
                                .resizable()
                                .frame(width: 80, height: 60)
                                .padding(.top, 30)
                        }
                        .padding(.trailing, 6)
                        Divider()
                        Text("Clientul nostru, prietenul nostru 😊 \nReFresh vă oferă acum posibilitatea de a comanda produse în cantități mari, la prețuri avantajoase. La orice comandă personalizată de minim 300 de lei, prețul final beneficiind de o reducere. Nu vă faceți griji în legătură cu transportul deoarece este inclus în preț.")
                            .font(.headline)
                            .padding([.bottom, .leading], 10)
                    }
                    .padding(.top, 10)
                } //box end
                .frame(width: screenWidth - 42)
                .padding(.top, -30)
                
                VStack(alignment: .center,spacing: 0){
                    Form{
                        Section(header: Text("Informatii Contact")){
                            
                            LinkCell(icon: "phone", text: "Telefon", link: "", text1: "0773792483 | 0774653234")
                            LinkCell(icon: "envelope", text: "Email", link: "", text1: "refresh-drinks@gmail.com")
                            LinkCell(icon: "globe", text: "Website", link: "https://google.com", text1: "refresh-drinks.ro")
                            NavigationLink( destination: ContactUs()){
                                LinkCell(icon: "homekit", text: "Locatia ReFresh", link: "", text1: "")
                            }
                        }
                    }
                    .frame(width: screenWidth, height: 235)
                } // contact info
                .padding(.top, 20)
                 /* VStack {
                 Button(action: {
                 self.isShowingMailView.toggle()
                 }) {
                 Text("Tap Me")
                 }
                 .disabled(!MFMailComposeViewController.canSendMail())
                 .sheet(isPresented: $isShowingMailView) {
                 MailView(result: self.$result)
                 }
                 }*/
            }
    }
}

struct CustomOrders_Previews: PreviewProvider {
    static var previews: some View {
        CustomOrders()
            .preferredColorScheme(.dark)
    }
}


struct MailView: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?
        
        init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation,
                           result: $result)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {
        
    }
}

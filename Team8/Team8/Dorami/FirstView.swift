import SwiftUI

struct FirstView: View {
    @State private var isShowingTextFieldPage = false
    
    var body: some View {
        VStack {
            if isShowingTextFieldPage {
                TimeInputView()
            } else {
                Button("텍스트 필드 페이지로 이동") {
                    isShowingTextFieldPage = true
                }
                .padding()
            }
        }.frame(width: 600, height: 572)
    }
}


#Preview {
    FirstView()
}

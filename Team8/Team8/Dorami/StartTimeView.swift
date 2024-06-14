import SwiftUI

struct StartTimeView: View {
    
    /// ✏️ (수정) 입력뷰에서 받아올 값
    @Binding var timeInput: String
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(timeInput)분 뒤에 돌아오세요!")
                
                NavigationLink(destination: TimerView(timeInput: timeInput)) {
                    Text("Start")
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
            .navigationTitle("Start Timer")
            .padding()
        }
    }
}

#Preview {
    StartTimeView(timeInput: .constant("15"))
}

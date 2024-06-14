import SwiftUI

struct StartTimeView: View {
    
    @Binding var timeInput: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.primary.ignoresSafeArea() // Set the entire background to primary color
                
                VStack {
                    Spacer()
                    Text("\(timeInput)분 뒤에 돌아오세요!")
                        .padding(.bottom, 20)
                        .foregroundColor(.white)
                        .font(.custom("Apple SD Gothic Neo", size: 22).weight(.bold))
                        .tracking(-0.44)
                    
                    Spacer()
                    
                    NavigationLink(destination: TimerView(timeInput: "\(timeInput)")) {
                        Text("확인")
                            .frame(width: 200, height: 28)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .font(.custom("Apple SD Gothic Neo", size: 13).weight(.medium))
                            .tracking(-0.44)
                    }
                    .buttonStyle(PlainButtonStyle()).navigationBarBackButtonHidden()
                }
                .padding()
            }
        }
    }
}

#Preview {
    StartTimeView(timeInput: .constant("15"))
        .frame(width: 600, height: 572)
}

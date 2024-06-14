import SwiftUI

struct TimeInputView: View {
    @State private var timeInput: String = ""
    @FocusState private var isFocused: Bool
    let workTime: Double = 2.5  // 작업 시간
    let restTime: Double = 1.5  // 쉬는 시간
    let totalTime: Double = 4.0  // 전체 시간
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack {
                    Spacer()
                    // 분 입력 필드
                    HStack{
                        Spacer()
                        TextField("", text: $timeInput)
                            .textFieldStyle(.plain)
                            .font(.system(size: 22))
                            .frame(width: 50, height: 16)
                            .bold()
                            .focused($isFocused)  // 텍스트 필드가 포커스 상태를 관리할 수 있도록 설정
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    isFocused = true  // 페이지가 나타날 때 텍스트 필드에 포커스를 설정
                                }
                            }
                        Text("분")
                            .bold()
                            .font(.system(size: 22))
                        Spacer()
                    }.padding(.top, 30)
                    
                    // 텍스트 필드 밑줄
                    Rectangle()
                        .frame(width: 50, height: 1)
                        .foregroundColor(.gray)
                        .padding(.top, -8)
                        .padding(.trailing, 22)
                    
                    // "쉬고 싶어요" 텍스트
                    Text("쉬고 싶어요")
                        .bold()
                        .font(.system(size: 22))
                    
                    Spacer()
                    
                    // 작업시간 및 쉬는시간 막대
                    HStack(spacing: 2) {
                        // 작업 시간을 나타내는 막대
                        Rectangle()
                            .fill(Color.pink)
                            .frame(width: CGFloat(workTime / totalTime * 440), height: 21)
                            .clipShape(.rect(topLeadingRadius: 2, bottomLeadingRadius: 2))
                        
                        // 쉬는 시간을 나타내는 막대
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: CGFloat(restTime / totalTime * 440), height: 21)
                            .clipShape(.rect(bottomTrailingRadius: 2,topTrailingRadius: 2))
                    }
                    .frame(width: 440, height: 21)
                    .padding()
                    
                    //작업 시간 쉰 시간 텍스트
                    HStack(spacing: 5) {
                        Circle()
                            .frame(width: 9, height: 9)
                            .foregroundColor(.pink)
                        Text("작업 시간")
                            .font(.system(size: 12))
                            .padding(.trailing, 5)
                        Circle()
                            .frame(width: 9, height: 9)
                            .foregroundColor(.green)
                        Text("쉬는 시간")
                            .font(.system(size: 12))
                        Spacer()
                    }
                    .padding(.bottom, 74)
                    .padding(.leading, 80)
                    
                    // 요청하기 버튼
                    NavigationLink(destination: StartTimeView(timeInput: $timeInput)) {
                        Text("요청하기")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 28)
                            .fontWeight(.semibold)
                            .opacity(0.7)
                    }.padding(.bottom, 20)
                }
                .navigationTitle("Gravity")
            }
        }
        .frame(width: 600, height: 572)
    }
}

#Preview{
    TimeInputView()
}

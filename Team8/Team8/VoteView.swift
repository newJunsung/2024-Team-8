import SwiftUI

struct VoteView: View {
    @EnvironmentObject private var gaManager: GroupActivityManager
    
    let minutes: Int
    
    var body: some View {
        VStack{
            Spacer()
            //토끼 이미지
            Image("Tokki")
                .resizable()
                .frame(width: 250, height: 250)
            
            HStack{
                Spacer()
                Text("\(minutes)")
                    .textFieldStyle(.plain)
                    .font(.system(size: 22))
                    .frame(width: 60, height: 16)
                    .bold()
                
                Text("분")
                    .bold()
                    .font(.system(size: 22))
                Spacer()
            }.padding(.top, 16)
            
            // "쉬고 싶어요" 텍스트
            Text("쉬고 싶어요")
                .bold()
                .font(.system(size: 22))
            
            // 원 두 개가 있는 HStack
            HStack(spacing: 60) {  // 원 사이의 간격을 60으로 설정
                Button(action: {
                    gaManager.appendStep(.voteToRest(argree: 0, disagree: 1))
                }) {
                    Circle()
                        .frame(width: 90, height: 90)
                        .foregroundColor(.pink)
                        .overlay(
                            Text("반대")
                                .foregroundColor(.white)
                                .font(.system(size: 22))
                                .bold()
                        )
                }.buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    gaManager.appendStep(.voteToRest(argree: 1, disagree: 0))
                }) {
                    Circle()
                        .frame(width: 90, height: 90)
                        .foregroundColor(.green)
                        .overlay(
                            Text("찬성")
                                .foregroundColor(.white)
                                .font(.system(size: 22))
                                .bold()
                        )
                }.buttonStyle(PlainButtonStyle())
            }
            .padding(.bottom, 52)
            
        }.frame(width: 600, height:  572)
    }
}

#Preview {
    VoteView(minutes: 5)
        .environmentObject(GroupActivityManager())
}


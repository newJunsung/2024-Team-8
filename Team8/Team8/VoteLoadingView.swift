import SwiftUI

struct VoteLoadingView: View {
    @EnvironmentObject private var gaManager: GroupActivityManager
    
    var body: some View {
        VStack {
            Text("아직 투표중이에요")
                .font(.title)
                .padding()
            DotLoadingIndicatorView()
                .padding()
        }
        .frame(width: 600, height: 572)
        .onChange(of: gaManager.agreeToRest) {
            print("agree +")
            if gaManager.agreeToRest >= gaManager.participantCount / 2 {
                Task {
                    try? await gaManager.send(.init(id: UUID(), step: .readyToRest(minutes: gaManager.minutes)))
                }
            }
        }
        .onChange(of: gaManager.disagreeToRest) {
            print("disagree +")
            if gaManager.disagreeToRest >= gaManager.participantCount / 2 {
                Task {
                    try? await gaManager.send(.init(id: UUID(), step: .failToRest))
                }
            }
        }
    }
}

#Preview {
    VoteLoadingView()
}

// 로딩 인디케이터 리소스
struct DotLoadingIndicatorView: View {
    @State private var isLoading = false  // 로딩 상태를 나타내는 상태 변수
    
    var body: some View {
        VStack {
            HStack(spacing: 8) {  // 점들 사이의 간격 8
                ForEach(0..<3) { index in  // 3개의 점을 생성
                    DotView(index: index, color: colorForIndex(index), isLoading: $isLoading)  // 각 점에 인덱스와 색상 및 로딩 상태 전달
                        .frame(width: 10, height: 10)  // 점의 크기 설정
                }
            }
            .onAppear {
                isLoading = true  // 뷰가 나타날 때 애니메이션 시작
            }
        }
    }
    
    // 인덱스에 따라 색상을 반환하는 함수
    private func colorForIndex(_ index: Int) -> Color {
        switch index {
        case 0:
            return .white
        case 1:
            return .white
        case 2:
            return .white
        default:
            return .gray
        }
    }
}

// 개별 점 뷰
struct DotView: View {
    let index: Int  // 점 인덱스
    let color: Color  // 점 색상
    @State private var opacity: Double = 1.0  // 점 투명도
    @Binding var isLoading: Bool  // 로딩 상태
    
    var body: some View {
        Circle()
            .frame(width: 10, height: 10)
            .foregroundColor(color)
            .opacity(opacity)
            .onAppear {
                if isLoading {
                    animate()
                }
            }
    }
    
    private func animate() {
        // 애니메이션을 설정하여 반복적으로 투명도 변경
        let baseAnimation = Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true)
        let delay = baseAnimation.delay(Double(index) * 0.2)
        
        withAnimation(delay) {
            opacity = 0.3
        }
    }
}



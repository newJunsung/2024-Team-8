//
//  RestSuccessView.swift
//  Team8
//
//  Created by 김준성 on 6/15/24.
//

import SwiftUI

struct JustRabbitView: View {
    let imageResource: ImageResource
    let text: String
    let buttonText: String
    let buttonTapHandler: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                Image(imageResource)
                    .resizable()
                    .frame(width: 250, height: 250)
                Text(text)
                    .foregroundStyle(.white)
                    .font(.system(size: 22))
            }
            Spacer()
            
            Button(action: buttonTapHandler) {
                Text("확인")
                    .frame(width: 200, height: 29)
            }
            .buttonStyle(BlueButtonStyle())
            .padding(.bottom, 20)
        }
        .frame(width: 600, height: 572)
        .background(.primary)
    }
}

#Preview {
    JustRabbitView(imageResource: .startRabbit, text: "fefe", buttonText: "확인") {
        print("123")
    }
}

import SwiftUI
import DesignSystemKit

public struct Home: View {
    public init() { }
    
    @EnvironmentObject var viewModel: HomeViewModel
    @State var isEdited: Bool = false
    
    public var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    self.topBarView
                    self.profileView
                    self.questionButton
                    self.friendRankView
                    self.myQuestionView
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

extension Home {
    private var topBarView: some View {
        WQTopBar(style: .title(.init(title: "LOGO")))
    }
    
    private var logoView: some View {
        HStack {
            Text("LOGO")
            Spacer()
        }
    }
    
    private var profileView: some View {
        let image = viewModel.profile.image
        let nickname = viewModel.profile.nickname
        let contents = viewModel.profile.contents
        
        return HStack {
            Image(systemName: image)
                .resizable()
                .scaledToFill()
                .frame(width: 85, height: 85)
                .padding(.leading, -20)
            
            VStack(alignment: .leading) {
                Text(nickname)
                    .font(.system(size: 20))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(
                        .designSystem(.g2)
                    )
                Text(contents)
                    .font(.system(size: 20))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(
                        .designSystem(.g4)
                    )
            }
            .padding(.leading, 24)
        }
    }
    
    private var questionButton: some View {
        WQButton(
            style: .single(
                .init(
                    title: "문제만들기 💬",
                    action: {
                        print("버튼이 눌렸습니다")
                    }
                )
            )
        )
    }
    
    private var friendRankBlankView: some View {
        let contents = "아직 랭킹이 없어요 ㅠㅠ"
        
        return VStack {
            Text(contents)
                .foregroundColor(.designSystem(.g2))
                .font(.pretendard(.regular, size: ._14))
        }
    }
    
    private var friendRankList: some View {
        VStack {
            CustomHeader(title: "친구 랭킹", nextView: AnyView(FriendsList(friends: $viewModel.friendsRank)))
            
            ForEach(viewModel.friendsRank.prefix(3), id: \.id) { friend in
                FriendsRow(friend: friend)
            }
        }
    }
    
    private var myQuestionBlankView: some View {
        let contents = "아직 생성된 문제가 없어요."
        let image = "doc.plaintext"
        
        return VStack {
            Image(systemName: image)
            Text(contents)
                .foregroundColor(.designSystem(.g2))
                .font(.pretendard(.regular, size: ._14))
        }
    }
    
    private var myQuestionList: some View {
        ScrollView {
            CustomHeader(title: "내가 낸 문제지 리스트", nextView: AnyView(QuestionGroupList(questions: $viewModel.questionGroups)))
                
            ForEach(viewModel.questionGroups.prefix(4)) { questionGroup in
                NavigationLink(destination: QuestionDetail(questions: .constant(questionGroup.questions))) {
                    QuestionGroupRow(
                        questionGroup: questionGroup)
                }
            }
        }
    }
    
    @ViewBuilder
    private var friendRankView: some View {
        if !viewModel.friendsRank.isEmpty {
            friendRankList
                .padding()
        } else if viewModel.friendsRank.isEmpty && !viewModel.questionGroups.isEmpty {
            EmptyView()
        } else {
            friendRankBlankView
                .padding()
        }
    }
    
    @ViewBuilder
    private var myQuestionView: some View {
        if !viewModel.questionGroups.isEmpty {
            myQuestionList
                .padding()
        } else if viewModel.questionGroups.isEmpty && !viewModel.friendsRank.isEmpty {
            EmptyView()
        } else {
            myQuestionBlankView
                .padding()
        }
    }
}

struct CustomHeader: View {
    var title: String
    var nextView: AnyView
    
    var body: some View {
        NavigationLink(destination: nextView) {
            Text(title)
                .foregroundColor(.designSystem(.g2))
                .font(.pretendard(.bold, size: ._20))
            Spacer()
            Image(Icon.Chevron.rightBig)
        }
        .buttonStyle(.plain)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(HomeViewModel())
    }
}

import SwiftUI
import DesignSystemKit
import HomeKit
import CoreKit
import QuizUI


public struct Home: View {
    public init() { }
    
    @EnvironmentObject var navigator: HomeNavigator
    @StateObject var viewModel: HomeViewModel = HomeViewModel(service: HomeService(Networking()))
    @State private var isEdited: Bool = false
    @State private var isPresentedQuestionDetail: Bool = false
    @State private var isPresentedMakeQuiz: Bool = false
    
    public var body: some View {
        NavigationStack(path: $navigator.path,  root: {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    self.topBarView
                    self.profileView
                    self.makeQuestionButton
                    self.friendRankView
                    self.myQuestionView
                }
            }
            .navigationDestination(for: Screen.self) { type in
                switch type {
                case .friendRankView:
                    friendRankBuilder()
                case .questionDetail(let quizId):
                    questionDetailBuilder(quizId: quizId)
                case .questionGroupView:
                    questionGroupBuilder()
                case .makeQuiz:
                    makeQuizBuilder()
                }
            }
        })
        .preferredColorScheme(.dark)
    }
    
    
    private func friendRankBuilder() -> some View {
        FriendsList(navigator: navigator, viewModel: FriendRankViewModel(service: HomeService(Networking())))
    }
    
    private func questionGroupBuilder() -> some View {
        QuestionGroupList(naivgator: navigator, viewModel: QuestionGroupViewModel(service: HomeService(Networking())))
    }
    
    private func questionDetailBuilder(quizId: Int) -> some View {
        QuestionDetail(viewModel: QuestionDetailViewModel(quizId: quizId, service: HomeService(Networking())), navigator: navigator)
    }
    
    private func makeQuizBuilder() -> some View {
        MakeQuizView()
    }
}

extension Home {
    private var topBarView: some View {
        WQTopBar(style: .title(.init(title: "LOGO")))
            .padding(.leading, 8)
    }
    
    private var profileView: some View {
        let image = viewModel.myInfo.image != nil ? viewModel.myInfo.image : "profileImage"
        let nickname = viewModel.myInfo.nickname
        let contents = viewModel.myInfo.description
        
        return HStack {
            if let image = image {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 85)
            }
            
            VStack(alignment: .leading) {
                Text(nickname)
                    .font(.pretendard(.bold, size: ._18))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(
                        .designSystem(.g2)
                    )
                    .padding(.bottom, 8)
                
                Text(contents)
                    .font(.pretendard(.medium, size: ._14))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(
                        .designSystem(.g4)
                    )
            }
            .padding(.leading, 20)
            
            Spacer()
        }
        .padding([.leading, .trailing], 20)
        .padding([.top, .bottom], 11)
    }
    
    private var makeQuestionButton: some View {
        WQButton(
            style: .single(
                .init(
                    title: "문제만들기 💬",
                    action: {
                        navigator.path.append(.makeQuiz)
                    }
                )
            )
        )
    }
    
    private var friendRankBlankView: some View {
        let contents = "아직 랭킹이 없어요"
        
        return VStack {
            Text(contents)
                .foregroundColor(.designSystem(.g2))
                .font(.pretendard(.regular, size: ._14))
        }
    }
    
    private var friendRankList: some View {
        VStack(spacing: 12) {
            CustomHeader(title: "친구 랭킹")
                .onTapGesture {
                    navigator.path.append(.friendRankView)
                }
            
            ForEach($viewModel.friendsRank.prefix(3)) { friend in
                FriendsRow(friend: friend)
            }
        }
    }
    
    private var myQuestionBlankView: some View {
        let image = "doc.plaintext"
        let contents = "아직 생성된 문제가 없어요"
        
        return VStack {
            Image(systemName: image)
            Text(contents)
                .foregroundColor(.designSystem(.g2))
                .font(.pretendard(.regular, size: ._14))
        }
    }
    
    private var myQuestionList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                CustomHeader(title: "내가 낸 문제지 리스트")
                    .onTapGesture {
                        navigator.path.append(.questionGroupView)
                    }
                
                ForEach($viewModel.questions.prefix(4)) { question in
                    ZStack {
                        QuestionGroupRow(question: question)
                    }
                    .onTapGesture {
                        navigator.path.append(.questionDetail(quizId: question.id))
                    }
                }
            }
            .onAppear() {
                viewModel.getQuestionGroup(QuestionGroupRequestModel(size: 15, cursor: nil))
            }
        }
    }
    
    @ViewBuilder
    private var friendRankView: some View {
        if !$viewModel.friendsRank.isEmpty {
            friendRankList
                .padding([.leading, .trailing], 20)
                .padding(.top, 9)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var myQuestionView: some View {
        if !$viewModel.questions.isEmpty {
            myQuestionList
                .padding([.leading, .trailing], 20)
                .padding(.top, 26)
        } else {
            myQuestionBlankView
                .padding([.leading, .trailing], 20)
                .padding(.top, 26)
        }
    }
}

struct CustomHeader: View {
    var title: String
    
    var body: some View {
        HStack {
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
        Home().environmentObject(HomeViewModel(service: HomeService(Networking())))
    }
}

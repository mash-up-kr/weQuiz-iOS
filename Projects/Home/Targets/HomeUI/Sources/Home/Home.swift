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
        //        NavigationStack(path: $navigator.path) {
        //            ScrollView(.vertical, showsIndicators: false) {
        //                VStack(spacing: 0) {
        //                    self.topBarView
        //                    self.profileView
        //                    self.makeQuestionButton
        //                    self.friendRankView
        //                    self.myQuestionView
        //                }
        //            }
        //            .navigationDestination(for: Screen.self) { type in
        //                switch type {
        //                case .friendRankView:
        //                case .questionDetail:
        //                case .questionGroupView:
        //
        //                }
        //            }
        //        }
        //        .preferredColorScheme(.dark)
        
        //        private func friendRankBuilder() -> FriendsList {
        //            return FriendsList(friends: <#T##Binding<[FriendModel]>#>)
        //        }
        //
        //        private func questionDetailBuilder() -> QuestionDetail {
        //            return QuestionDetail(friends: <#T##Binding<[FriendModel]>#>)
        //        }
        
        NavigationStack(root: {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    self.topBarView
                    self.profileView
                    self.makeQuestionButton
                    self.friendRankView
                    self.myQuestionView
                }
            }
            .navigationDestination(isPresented: $isPresentedMakeQuiz) {
                MakeQuizView()
            }
            .navigationDestination(isPresented: $isPresentedQuestionDetail) {
                QuestionDetail(quizInfo: $viewModel.detailQuizInfo, onRemove: { quizId in
                    viewModel.getQuestionGroup(QuestionGroupRequestModel(size: 100, cursor: nil)) })
                .environmentObject(viewModel)
            }
        })
        .preferredColorScheme(.dark)
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
                        isPresentedMakeQuiz.toggle()
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
            CustomHeader(title: "친구 랭킹", nextView: AnyView(FriendsList(friends: $viewModel.friendsRank)))
            
            ForEach(viewModel.friendsRank.indices.prefix(3)) { index in
                FriendsRow(friend: $viewModel.friendsRank[index], priority: index+1)
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
    
//    private var myQuestionList: some View {
//        ScrollView {
//            LazyVStack(spacing: 12) {
//                CustomHeader(title: "내가 낸 문제지 리스트", nextView: AnyView(QuestionGroupList(questions: $viewModel.questions)))
//
//                // 여기서 QuestionDetailView로 넘어가기 전에 통신을 통해서 DetailView 데이터를 받아와서 그려줘야 한다.
//                ForEach($viewModel.questions.prefix(4)) { question in
//                    NavigationLink(destination: QuestionDetail(quizInfo: .constant(questionDetailSample.quizInfo), quizStatistic: .constant(questionDetailSample.statistic), onRemove: { index in
//                        viewModel.questions.removeAll { $0.id == index }
//                    })) {
//                        QuestionGroupRow(question: question)
//                    }
//                }
//            }
//        }
//    }
    
    
    private var myQuestionList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                CustomHeader(title: "내가 낸 문제지 리스트", nextView: AnyView(QuestionGroupList(questions: $viewModel.questions)))
                
                ForEach($viewModel.questions.prefix(4)) { question in
                    Button(action: {
                        // 아래 통신을 하는 함수는 서버 모델이 제대로 떨어지면 그 때 반영해야한다.
                        viewModel.getQuestionStatistic(QuestionStatisticRequestModel(quizId: Int(question.id)))
                        self.isPresentedQuestionDetail = true
                    }) {
                        QuestionGroupRow(question: question)
//                        if isLoading {
//                            ProgressView()
//                        }
                    }
                }
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
        Home().environmentObject(HomeViewModel(service: HomeService(Networking())))
    }
}

import SwiftUI

public struct Home: View {
    public init() { }
    
    @EnvironmentObject var viewModel: HomeViewModel
    
    public var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    self.logoView
                    self.profileView
                    self.makeQuestionButton
                    self.createFriendRankView
                    self.myQuestionList
                }
                .padding()
            }
        }
        .preferredColorScheme(.dark)
    }
}

extension Home {
    
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
                Text(contents)
                    .font(.system(size: 20))
                    .multilineTextAlignment(.leading)
            }
            .padding(.leading, 24)
        }
    }
    
    private var makeQuestionButton: some View {
        Button(action: {
            // 소현이가 만드는 문제만들기 뷰와 연동되어야 함
            print("문제만들기 버튼이 클릭되었습니다.")
        }) {
            HStack {
                Spacer()
                Text("문제만들기")
                    .font(.system(size: 16))
                Image(systemName: "circle")
                    .imageScale(.large)
                    .frame(width: 16.25, height: 16.25)
                Spacer()
            }
            .frame(height: 56, alignment: .center)
            .background(Color.pink)
            .cornerRadius(16)
        }
    }
    
    private var questionExplainView: some View {
        let title = viewModel.explainContents.title
        let contents = viewModel.explainContents.contents
        
        return VStack {
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .padding(.top, 16)
            
            Text(contents)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .padding(.all, 16)
                .multilineTextAlignment(.leading)
        }
        .background(.blue)
        .cornerRadius(16)
    }
    
    private var friendRankList: some View {
        VStack {
            CustomHeader(title: "친구 랭킹", nextView: AnyView(FriendsList(friends: $viewModel.friendsRank)))
            
            ForEach(viewModel.friendsRank.prefix(3), id: \.id) { friend in
                FriendsRow(friend: friend)
            }
        }
    }
    
    private var myQuestionList: some View {
        ScrollView {
            CustomHeader(title: "내가 낸 문제지 리스트", nextView: AnyView(QuestionGroupList(questions: $viewModel.questionGroups)))
            
            ForEach(viewModel.questionGroups.prefix(4), id: \.id) { questionGroup in
                NavigationLink(destination: QuestionDetail(questionGroup: questionGroup)) {
                    QuestionGroupRow(questionGroup: questionGroup)
                }
            }
    
            if viewModel.questionGroups.isEmpty {
                Text("아직 생성된 문제가 없습니다.")
            }
        }
    }
    
    @ViewBuilder
    private var createFriendRankView: some View {
        if !viewModel.friendsRank.isEmpty {
            friendRankList
        } else {
            questionExplainView
        }
    }
}

struct CustomHeader: View {
    var title: String
    var nextView: AnyView
    
    var body: some View {
        NavigationLink(destination: nextView) {
            Text(title)
            Spacer()
            Image(systemName: "circle")
                .resizable()
                .scaledToFill()
                .frame(width: 15, height: 15)
        }
        .buttonStyle(.plain)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(HomeViewModel())
    }
}

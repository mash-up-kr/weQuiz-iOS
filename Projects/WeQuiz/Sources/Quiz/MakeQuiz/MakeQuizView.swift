import Combine
import SwiftUI

import DesignSystemKit

protocol MakeQuizDisplayLogic {
    func displayCompletionView(viewModel: MakeQuiz.RequestMakeQuiz.ViewModel)
}

public struct MakeQuizView: View {
    
    private let navigator: HomeNavigator
    var interactor: MakeQuizBusinessLogic?
    
    
    @State var isPresentProgressView: Bool = false
    @ObservedObject var viewModel = MakeQuizDataStore()
    
    public init(navigator: HomeNavigator) {
        self.navigator = navigator
    }
    
    @Environment(\.editMode) private var editMode
    @State private var removeItemPopupPresented = false
    @State private var removedIndex: (popupPresented: Bool, index: UUID?) = (false, nil)
    @State private var removeSuccessToastModal: WQToast.Model?
    @State private var isQuizEnabled: Bool = false
    
    
    public var body: some View {
        VStack {
            WQTopBar(style: .navigationWithListEdit(
                .init(
                    title: "문제 만들기",
                    editAction: {
                        self.editMode?.wrappedValue == .active ?
                        (self.editMode?.wrappedValue = .inactive) : (self.editMode?.wrappedValue = .active)
                    }, action: {
                        navigator.back()
                    })
            ))
            .background(
                Color.designSystem(.g9)
            )
            
            VStack {
                titleTextField()
                
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach($viewModel.quiz.questions, id: \.id) { item in
                            QuestionView(model: item, onRemove: { index in
                                removedIndex = (popupPresented: true, index: index)
                            }, onExpand: { index in
                                viewModel.toggleExpand(index)
                                proxy.scrollTo(item.id, anchor: .center)
                            }, isChanged: {
                                checkViewModel()
                            })
                            .padding(.bottom, 12)
                            .id(item.id)
                            
                        }
                        .onChange(of: viewModel.quiz.title) { _ in
                            checkViewModel()
                        }
                                  
                        addAnswerView()
                            .padding(.horizontal, 20)
                        
                    }
                    .padding(.top, 30)
                }
                
                Spacer()
                
                WQButton(
                    style: .single(
                        .init(title: "시험지 완성하기",
                              isEnable: $isQuizEnabled,
                              action: {
                                  isPresentProgressView = true
                                  interactor?.requestMakeQuiz(request: .init(quiz: viewModel.quiz))
                              }))
                )
                .frame(height: 52)
            }
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            
        }
        .modal(.init(
            message: "문제를 삭제할까요?",
            doubleButtonStyleModel: .init(
                titles: ("아니요", "삭제"),
                leftAction: {
                    removedIndex.popupPresented = false
                },
                rightAction: {
                    removeListItem()
                }
            )
        ),
               isPresented: $removedIndex.popupPresented
        )
        .toast(model: $removeSuccessToastModal)
        .background(
            Color.designSystem(.g9)
        )
        .progressView(isPresented: $isPresentProgressView)
    }
    
    private func titleTextField() -> some View {
        TextField("", text: $viewModel.quiz.title, prompt: Text("제목없는 시험지").foregroundColor(Color.designSystem(.g4)))
            .frame(height: 34)
            .onReceive(Just(viewModel.quiz.title)) { _ in
                viewModel.limitQuizName()
            }
            .font(.pretendard(.medium, size: ._24))
            .foregroundColor(Color.designSystem(.g4))
            .padding(EdgeInsets(top: 24, leading: 20, bottom: 0, trailing: 20))
    }
    
    private func addAnswerView() -> some View {
        Button(action: {
            if self.viewModel.quiz.questions.count >= 10 { return }
            self.viewModel.quiz.questions.append(MakeQuestionModel())
        }) {
            HStack(alignment: .center, spacing: 7, content: {
                Image(Icon.Add.circle)
                    .frame(width: 16.5, height: 16.5)
                
                Text("질문 추가")
                    .font(.pretendard(.bold, size: ._16))
                    .foregroundColor(Color.designSystem(.g1))
                
            })
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.designSystem(.g8))
            .cornerRadius(16)
            .padding(.bottom, 20)
            
        }
        .background(
            Color.designSystem(.g9)
        )
    }
    
    private func moveListItem(from source: IndexSet, to destination: Int) {
        viewModel.quiz.questions.move(fromOffsets: source, toOffset: destination)
    }
    
    private func removeListItem() {
        viewModel.quiz.questions.removeAll { $0.id == self.removedIndex.index }
        removedIndex = (false, nil)
        removeSuccessToastModal = .init(status: .success, text: "문제를 삭제했어요")
        checkViewModel()
    }
                                  
    private func checkViewModel() {
        if viewModel.isQuizFilled() == true {
            isQuizEnabled = true
        } else {
            isQuizEnabled = false
        }
    }
}
extension MakeQuizView: MakeQuizDisplayLogic {
    func displayCompletionView(viewModel: MakeQuiz.RequestMakeQuiz.ViewModel) {
        navigator.path.append(.quizCompletion(quizId: viewModel.quizId))
        isPresentProgressView = false
    }
}

struct MakeQuizView_Previews: PreviewProvider {
    static var previews: some View {
        MakeQuizView(navigator: HomeNavigator.shared)
    }
}

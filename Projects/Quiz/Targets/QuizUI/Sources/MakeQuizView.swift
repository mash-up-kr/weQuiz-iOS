import SwiftUI
import Combine
import DesignSystemKit
import QuizKit

public struct MakeQuizView: View {
    public init() {}
    
    let quizNameLimit: Int = 38
    
    @State private var quizName: String = ""
    @State private var questionItem: [QuestionModel] = [QuestionModel(), QuestionModel()]
    @Environment(\.editMode) private var editMode
    @State private var removeItemPopupPresented = false
    @State private var removedIndex: (popupPresented: Bool, index: UUID?) = (false, nil)
    
    @State private var removeSuccessToastModal: WQToast.Model?
    @State private var routeToCompletionView = false
    

    public var body: some View {
        NavigationStack {
            VStack {
                WQTopBar(style: .navigationWithListEdit(
                    .init(
                        title: "문제 만들기",
                        editAction: {
                            self.editMode?.wrappedValue == .active ?
                            (self.editMode?.wrappedValue = .inactive) : (self.editMode?.wrappedValue = .active)
                        }, action: {
                            print("back")
                        })
                ))
                .background(
                    Color.designSystem(.g9)
                )
                
                GeometryReader {_ in
                    VStack {
                        VStack {
                            TextField("", text: $quizName, prompt: Text("제목없는 시험지").foregroundColor(Color.designSystem(.g4)))
                                .frame(height: 34)
                                .onReceive(Just(quizName)) { _ in
                                    limitQuizName(quizNameLimit)
                                }
                                .font(.pretendard(.medium, size: ._24))
                                .foregroundColor(Color.designSystem(.g4))
                                .padding(EdgeInsets(top: 24, leading: 20, bottom: 0, trailing: 20))
                            
                            List {
                                Section(content: {
                                    ForEach($questionItem, id: \.id) { item in
                                        QuestionView(model: item, onRemove: { index in
                                            removedIndex = (popupPresented: true, index: index)
                                        })
                                    }
                                    .onMove(perform: moveListItem)
                                    
                                }, footer: {
                                    
                                    Button(action: {
                                        if self.questionItem.count >= 10 { return }
                                        self.questionItem.append(QuestionModel())
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
                                        .padding(.top, 16)
                                        
                                    }
                                    .background(
                                        Color.designSystem(.g9)
                                    )
                                    .listRowInsets(EdgeInsets())
                                    
                                })
                            }
                            .listStyle(.plain)
                            .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))
                        }
                        
                        Spacer()

                        WQButton(
                          style: .single(
                              .init(title: "시험지 완성하기",
                                  action: {
                                      routeToCompletionView = true
                                  }))
                        )
                        .frame(height: 52)
                    }
                    
                    
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
            .navigationDestination(isPresented: $routeToCompletionView) {
                 QuizCompletionView()
             }
        }
        
        
    }
    
    private func moveListItem(from source: IndexSet, to destination: Int) {
        questionItem.move(fromOffsets: source, toOffset: destination)
    }
    
    private func removeListItem() {
        questionItem.removeAll { $0.id == self.removedIndex.index }
        removedIndex = (false, nil)
        removeSuccessToastModal = .init(status: .success, text: "문제를 삭제했어요")
    }
    
    private func limitQuizName(_ upper: Int) {
        if quizName.count > upper {
            quizName = String(quizName.prefix(upper))
        }
    }
}

struct MakeQuizView_Previews: PreviewProvider {
    static var previews: some View {
        MakeQuizView()
    }
}

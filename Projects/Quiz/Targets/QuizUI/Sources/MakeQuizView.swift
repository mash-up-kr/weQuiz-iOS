import SwiftUI
import Combine
import DesignSystemKit
import QuizKit

public struct MakeQuizView: View {
    public init() {}
    
    let quizNameLimit: Int = 38
    
    @State var quizName: String = ""
    @State var questionItem: [QuestionModel] = [QuestionModel(), QuestionModel()]
    
    
    @Environment(\.editMode) private var editMode

    public var body: some View {
        
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
            .padding(.horizontal, 20)
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
                                    QuestionView(model: item)
                                        .listRowSeparator(.hidden)
                                        .listRowInsets(EdgeInsets())
                                        .listRowBackground(Color.clear)
                                        .padding([.top, .bottom], 8)
                                }
                                .onMove(perform: moveListItem)
                            }, footer: {
                                
                                Button(action: {
                                    self.questionItem.append(QuestionModel())
                                }) {
                                    HStack(alignment: .center, spacing: 7, content: {
                                        // TODO: - Icon 수정
                                        Text(".")
                                            .frame(width: 16.5, height: 16.5)
                                            .background(Color.white)
                                        
                                        Text("질문 추가")
                                            .font(.pretendard(.bold, size: ._16))
                                            .foregroundColor(Color.designSystem(.g1))
                                            
                                    })
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 56)
                                    .background(Color.designSystem(.g8))
                                    .cornerRadius(16)
                                    .padding(.top, 8)
                                    
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
                                  // TODO: 시험지 완성하기 연결
                              }))
                    )
                    .frame(height: 52)
                }
            }
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .background(
            Color.designSystem(.g9)
        )
    }
    
    private func moveListItem(from source: IndexSet, to destination: Int) {
        questionItem.move(fromOffsets: source, toOffset: destination)
    }
    
    private func limitQuizName(_ upper: Int) {
        if quizName.count > upper {
            quizName = String(quizName.prefix(upper))
        }
    }
}

//struct MakeQuizView_Previews: PreviewProvider {
//    static var previews: some View {
//        MakeQuizView()
//    }
//}

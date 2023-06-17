import SwiftUI
import Combine
import DesignSystemKit

public struct MakeQuizView: View {
    public init() {}
    
    let quizNameLimit: Int = 38
    @State var quizName: String = ""
    @State var questionItem: [String] = ["문제 1","문제 2","문제 3","문제 4"]

    public var body: some View {
        
        NavigationView {
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
                                ForEach(questionItem, id: \.self) { item in
                                    QuizView(title: item)
                                        .frame(height: 68)
                                        .listRowSeparator(.hidden)
                                        .listRowInsets(EdgeInsets())
                                        .listRowBackground(Color.designSystem(.g9))
                                        .padding(.bottom, 16)
                                }
                                .onMove(perform: moveListItem)
                            }, footer: {
                                
                                Button(action: {
                                    self.questionItem.append("질!문!")
                                }) {
                                    HStack(alignment: .center, spacing: 7, content: {
                                        
                                        Text(".")
                                            .frame(width: 16.5, height: 16.5)
                                            .background(Color.white)
                                        
                                        Text("질문 추가")
                                            .font(.pretendard(.bold, size: ._16))
                                            .foregroundColor(Color.designSystem(.g1))
                                            
                                    })
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 56)
                                    .background(.red)
                                    .cornerRadius(16)
                                    
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
                          .init(
                              title: "시험지 완성하기",
                              action: {
                                  print("make quiz")
                              }
                          )
                      )
                    )
                    .frame(height: 52)
                    
                }
                
                
            }
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationBarTitle(Text("문제 만들기"),
                                    displayMode: .inline)
            .toolbar {
                EditButton()
            }
            .background(
                Color.designSystem(.g9)
            )
       }
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

struct MakeQuizView_Previews: PreviewProvider {
    static var previews: some View {
        MakeQuizView()
    }
}

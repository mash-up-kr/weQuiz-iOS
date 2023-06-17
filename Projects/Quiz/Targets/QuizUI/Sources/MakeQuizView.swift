import SwiftUI
import Combine
import DesignSystemKit

public struct MakeQuizView: View {
    public init() {}
    
    let quizNameLimit: Int = 38
    @State var quizName: String = ""
    @State var questionItem: [String] = ["1","2","3","4"]

    public var body: some View {
        
        NavigationView {
            GeometryReader {_ in
                VStack {
                    VStack {
                        TextField("", text: $quizName, prompt: Text("제목없는 시험지").foregroundColor(Color.designSystem(.g4)))
                            .onReceive(Just(quizName)) { _ in
                                limitQuizName(quizNameLimit)
                            }
                            .font(.pretendard(.medium, size: ._24))
                            .foregroundColor(Color.designSystem(.g4))
                        List {
                            Section(content: {
                                ForEach(questionItem, id: \.self) { item in
                                    QuizView(title: item)
                                        .frame(height: 68)
                                        .listRowSeparator(.hidden)
                                        .listRowInsets(EdgeInsets())
                                        .listRowBackground(Color.designSystem(.g9))
                                }
                                .onMove(perform: moveListItem)
                            }, footer: {
                                Button("질문 추가", action: {
                                    self.questionItem.append("질!문!")
                                })
                                .drawingGroup()
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(.red)
                            })
                        }
                        .listStyle(.plain)
                    }
                    
                    Spacer()
                    
                    Button("시험지 만들기", action: {
                        print("make quiz")
                    })
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
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

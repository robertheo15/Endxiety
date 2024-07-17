//
//  HomeView.swift
//  Endxiety
//
//  Created by Ali Haidar on 11/07/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State var isEmpty = true
    @State private var showReminderSheet = false
    @State private var isReminderEnabled: Bool = false

    
    let dates = (0..<8).map { index in
        let date = Date().addingTimeInterval(-Double(index) * 24 * 60 * 60)
        let formattedDate = date.formatted(date: .abbreviated, time: .omitted)
        let dayOfWeek = Calendar.current.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
        return (date, formattedDate, dayOfWeek)
    }
    
    var body: some View {
        ZStack {
            Color.backgroundPrimary.ignoresSafeArea()
            NavigationStack {
                VStack {
                    
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(dates, id: \.0) { (date, formattedDate, dayOfWeek) in
                                NoteCalendarView(isEmpty: $isEmpty, date: formattedDate, day: dayOfWeek)
                                    .containerRelativeFrame(.horizontal, count: 1, spacing: 16)
                                
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .defaultScrollAnchor(.trailing)
                    .contentMargins(.horizontal, 20, for: .scrollContent)
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text(LocalizedStringKey("My Notes"))
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                            Button(action: {
                                // Action for refresh button
                                showReminderSheet.toggle()
                                print("halo")
                            }) {
                                Image(systemName: "clock.badge")
                                    .foregroundColor(.primaryBlue)
                            }
                            .sheet(isPresented: $showReminderSheet) {
                                VStack {
                                    Sheet(showReminderSheet: $showReminderSheet, isReminderEnabled: $isReminderEnabled)
                                }
                            }
                        }
                    }
                }
                .background(
                    Color.backgroundPrimary.ignoresSafeArea())
            }
            .scenePadding(.top)
        }
    }
}

#Preview {
    HomeView()
}

struct NoteCalendarView: View {
    
    @Query(sort: \Note.editedAt) var swiftDateNotes: [Note]
    @State var selectedNote: Note = Note(content: "", fileURL: URL(filePath: ""), emotion: "")
    @Environment(\.modelContext) var context
    @State private var navigateToNewNote = false
    
    @ObservedObject var vm = VoiceViewModel()
    @Binding var isEmpty: Bool
    @State var showingSheet = false
    
    var date: String
    var day: String
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading){
                HStack {
                    VStack (alignment: .leading){
                        Text(day)
                            .font(.title)
                            .bold()
                        Text(date)
                    }
                    .foregroundColor(.backgroundPrimary)
                    .padding()
                    
                    Spacer()
                }
                .background(.primaryBlue)
                .padding(-15)
                
                
                
                ScrollView(showsIndicators: false){
//                    ForEach(vm.recordingsList, id: \.id) { recording in
//                        
//                        RecordingItemView(vm: vm, recording: recording)
//                        
//                    }
//                    
//                }.padding(.top, 10)
                
//                List {
                    ForEach(swiftDateNotes.filter{ $0.editedAt.formatted(date: .abbreviated, time: .omitted) == date }) { note in
                        NoteRow(note: note)
                            .onTapGesture {
                                selectedNote = note
                                navigateToNewNote = true
                            }
                            .contextMenu {
                                Button(role: .destructive) {
                                    context.delete(note)
                                } label: {
                                    Image(systemName: "trash")
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .listRowInsets(EdgeInsets())
                    }
                }
                .padding(.top, 10)
                .listStyle(PlainListStyle())
                .overlay {
                    if swiftDateNotes.isEmpty {
                        ContentUnavailableView(label: {
                            Label("No Entry", systemImage: "tray.fill")
                        })
                    }
                }
                
                
                Spacer()
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        selectedNote = Note(content: "", fileURL: URL(filePath: ""), emotion: "")
                        showingSheet.toggle()
                            
                    } label: {
                        HStack {
                            Image(systemName: "square.and.pencil")
                            Text("New Entry")
                            
                        }
                        .foregroundStyle(.black)
                        .padding()
                        .background(Capsule().foregroundStyle(.primaryBlue))
                        
                    }.buttonStyle(.plain)
                    
                }
            }
        }
        .sheet(isPresented: $showingSheet){
            TextOrVoiceView(showingSheet: $showingSheet, note: $selectedNote)
                .presentationDragIndicator(.visible)
        }
        .navigationDestination(isPresented: $navigateToNewNote){
            NoteView(note: $selectedNote)
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .background(RoundedRectangle(cornerRadius: 20)
                    //            .stroke(lineWidth: 5)
            .foregroundStyle(.notesBackground)
        )
        .shadow(radius: 0.5)
        .frame(width: UIScreen.main.bounds.width - 50)
        .padding(.vertical)
    }
}

struct NoteRow: View {
    let note : Note
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy HH:mm"
        return formatter.string(from: note.editedAt)
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(note.emotion)
                    .resizable()
                    .frame(width: 65, height: 65)
                    .padding()
                VStack (alignment: .leading) {
                    Text(note.content)
                        .font(.body)
                        .lineLimit(2)
                        .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                        .padding(.bottom)
                        .padding(.trailing)
                    
                    Text("Last Edited " + formattedDate)
                        .font(.system(size: 10))
                }
                Spacer()
            }
            
            Divider()
                .overlay(Color(.primaryBlue))
        }
        .frame(maxWidth: .infinity)
//            .background(
////                RoundedRectangle(cornerRadius: 12)
////                    .fill(.notesBackground)
////                    .stroke(.black)
//            )
    }
}


struct RecordingItemView: View {
    @ObservedObject var vm: VoiceViewModel
    var recording: Recording
    
    var body: some View {
        VStack {
            HStack{
                Image("Annoyed")
                    .resizable()
                    .frame(width: 80, height: 80)
                
                VStack (alignment: .leading){
                    
                    Slider(value: Binding<Double>(
                        get: { vm.currentTime },
                        set: { newValue in
                            vm.seek(to: TimeInterval(newValue))
                        }
                    ), in: 0.0...(vm.audioPlayer?.duration ?? 1.0)) //
                    .padding(.horizontal)
                    
                    HStack(spacing: 50){
                        Spacer()
                        Button{
                            vm.deleteRecording(url:recording.fileURL)
                        }label: {
                            Image(systemName: "gobackward.10")
                        }
                        Button{
                            if recording.isPlaying == true {
                                vm.stopPlaying(url: recording.fileURL)
                            }else{
                                vm.startPlaying(url: recording.fileURL)
                            }
                        }label: {
                            //                                            Image(systemName: "play.fill")
                            Image(systemName: recording.isPlaying ? "stop.fill" : "play.fill")
                        }
                        Button{
                            
                        }label: {
                            Image(systemName: "goforward.10")
                        }
                        Spacer()
                    }
                    .font(.headline)
                    .buttonStyle(.plain)
                    
                    Text("Recorded "+"\(recording.createdAt)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .padding(.top)
                }
            }
            Divider()
                .overlay(Color(.primaryBlue))
        }
    }
}

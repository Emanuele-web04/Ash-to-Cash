////
////  TestCharts.swift
////  Ash To Cash
////
////  Created by Emanuele Di Pietro on 12/12/23.
////
//
//
//
//import SwiftUI
//import Charts
//import SwiftData
//
//struct SummaryView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query(sort: \Day.dayNum) private var days: [Day]
//    
//    @AppStorage("dayCounter") var dayCounter = 22
//    
//    var sectorView = SectorViewModel()
//    var taskViewModel = TaskViewModel()
//    @State var filter = "Daily"
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Picker("Filter", selection: $filter) {
//                    Text("Daily").tag("Daily")
//                    Text("Weekly").tag("Weekly")
//                    Text("Monthly").tag("Monthly")
//                }
//                .pickerStyle(.segmented)
//                .frame(width: 300)
//                Spacer().frame(height: 50)
//                if filter == "Daily" {
//                    ZStack {
//                        CircularProgressView(progress: Double(days[0].sport)/3, color: sectorView.sectors[0].color)
//                            .frame(width: 255, height: 255)
//                        CircularProgressView(progress: Double(days[0].health)/3, color: sectorView.sectors[1].color)
//                            .frame(width: 190, height: 190)
//                        CircularProgressView(progress: Double(days[0].freeTime)/3, color: sectorView.sectors[2].color)
//                            .frame(width: 125, height: 125)
//                        CircularProgressView(progress: Double(days[0].work)/3, color: sectorView.sectors[3].color)
//                            .frame(width: 60, height: 60)
//                    }
//                }
//                else if filter == "Weekly" {
//                    Chart {
//                        BarMark(
//                            x: .value("Sector", "Sports"),
//                            y: .value("Total Count", updateWeeklyProgress(daysSt: days, currentDays: 22,Sector: "Sport"))
//                        )
//                        .foregroundStyle(sectorView.sectors[0].color)
//                        BarMark(
//                            x: .value("Sector", "Health"),
//                            y: .value("Total Count", updateWeeklyProgress(daysSt: days, currentDays: 22,Sector: "Health"))
//                        )
//                        .foregroundStyle(sectorView.sectors[1].color)
//                        BarMark(
//                            x: .value("Sector", "FreeTime"),
//                            y: .value("Total Count", updateWeeklyProgress(daysSt: days, currentDays: 22,Sector: "FreeTime"))
//                        )
//                        .foregroundStyle(sectorView.sectors[2].color)
//                        BarMark(
//                            x: .value("Sector", "Work"),
//                            y: .value("Total Count", updateWeeklyProgress(daysSt: days, currentDays: 22,Sector: "Work"))
//                        )
//                        .foregroundStyle(sectorView.sectors[3].color)
//                    }
//                  
//                }
//                else if filter == "Monthly" {
//                    ZStack{
//                        Chart {
//                            ForEach (days) { day in
//                                LineMark(
//                                    x: .value("Day", day.dayNum),
//                                    y: .value("Total Count", day.sport)
//                                )
//                                .foregroundStyle(sectorView.sectors[0].color)
//                            }
//                        }
//                        .chartYAxis(.hidden)
//                        Chart {
//                            ForEach (days) { day in
//                                LineMark(
//                                    x: .value("Day", day.dayNum),
//                                    y: .value("Total Count", day.health)
//                                )
//                                .foregroundStyle(sectorView.sectors[1].color)
//                            }
//                        }
//                        .chartYAxis(.hidden)
//                        Chart {
//                            ForEach (days) { day in
//                                LineMark(
//                                    x: .value("Day", day.dayNum),
//                                    y: .value("Total Count", day.freeTime)
//                                )
//                                .foregroundStyle(sectorView.sectors[2].color)
//                            }
//                        }
//                        .chartYAxis(.hidden)
//                        Chart {
//                            ForEach (days) { day in
//                                LineMark(
//                                    x: .value("Day", day.dayNum),
//                                    y: .value("Total Count", day.work)
//                                )
//                                .foregroundStyle(sectorView.sectors[3].color)
//                            }
//                        }
//                        .chartYAxis(.hidden)
//                    }
//                }
//                Spacer().frame(height: 50)
//                List {
//                    ForEach (sectorView.sectors) { sector in
//                        VStack {
//                            HStack {
//                                VStack {
//                                    Spacer().frame(height: 10)
//                                    Text(sector.name)
//                                        .font(.system(size: 20))
//                                        .foregroundColor(sector.color)
//                                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
//                                    Text(sector.desc)
//                                        .font(.system(size: 11))
//                                        .foregroundColor(.gray)
//                                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
//                                }
//                                NavigationLink {
//                                    SectorView(sectorName: sector.name)
//                                } label: {
//                                    Text("See more")
//                                        .foregroundColor(.gray)
//                                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
//                                }
//                            }
//                        }
//                    }
//                }
//                
//            }
//        }
//        .onAppear(perform: addCalendar)
//    }
//    
//    private func addCalendar() -> Void {
//        if (days.isEmpty) {
//            for j in 1...30 {
//                let day = Day(dayNum: j, sport: Int.random(in: 0...3), health: Int.random(in: 0...3), freeTime: Int.random(in: 0...3), work: Int.random(in: 0...3))
//                modelContext.insert(day)
//            }
//        }
//        /*
//         do {
//         try modelContext.delete(model: Day.self)
//         } catch {
//         print("Error")
//         }
//         */
//    }
//}
//
//
//#Preview {
//    SummaryView()
//        .modelContainer(for: Day.self, inMemory: true)
//}
//
//func updateWeeklyProgress(daysSt: [Day],currentDays: Int,Sector: String) -> Double {
//    var counterSum = 0
//    let currentDay = currentDays-1
//    /*
//    if Sector == "Sport" {
//        if currentDay < 7 {
//            for i in 0...currentDay{
//                counterSum = counterSum + daysSt[i].sport
//            }
//        } else {
//            for i in currentDay - 6...currentDay{
//                counterSum = counterSum + daysSt[i].sport
//            }
//        }
//    } else if Sector == "Health" {
//        if currentDay < 7 {
//            for i in 0...currentDay{
//                counterSum = counterSum + daysSt[i].health
//            }
//        } else {
//            for i in currentDay - 6...currentDay{
//                counterSum = counterSum + daysSt[i].health
//            }
//        }
//    } else if Sector == "Work" {
//        if currentDay < 7 {
//            for i in 0...currentDay{
//                counterSum = counterSum + daysSt[i].work
//            }
//        } else {
//            for i in currentDay - 6...currentDay{
//                counterSum = counterSum + daysSt[i].work
//            }
//        }
//    } else if Sector == "FreeTime" {
//        if currentDay < 7 {
//            for i in 0...currentDay{
//                counterSum = counterSum + daysSt[i].work
//            }
//        } else {
//            for i in currentDay - 6...currentDay{
//                counterSum = counterSum + daysSt[i].work
//            }
//        }
//    }
//    */
//    return Double(counterSum)
//}

//
//  ContentView.swift
//  timekeep_app
//
//  Created by Spencer Lamoreaux on 10/13/22.
//

import SwiftUI




struct ContentView: View {
    var body: some View {
        VStack(alignment: .center){
            
//          Main title.
            Text("TIME KEEPER")
            
            Spacer(minLength: 300)
            
//          Main button and End time button.
            TimeButtons()
        }
        
        .padding(
        )
    }
}
    
    
    
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct TimeButtons: View {
    
//    Switching this value controls the label for main button.
    @State private var time_started = true
    
//    Keeps track of times when main button is clicked.
    @State var time_list = []

    func totalTime() -> String{
//        Returns the total time between pressing button, and resets time_list.
        var sum = 0.00
        
//        Computes total time in seconds, and resets the list.
        while (time_list.count >= 2){
            let time = ((time_list[1] as AnyObject).timeIntervalSinceReferenceDate - (time_list[0] as AnyObject).timeIntervalSinceReferenceDate)
            print("time: ", time)
            sum += time
            time_list.removeFirst()
            time_list.removeFirst()
        }
        
        sum = sum.rounded()
        
//        Converts the total number of seconds into hours and minutes.
        let totalMin = sum / 60
        let timeHrs = String(format: "%.0f",totalMin / 60)
        let timeMin = String(format: "%.0f", totalMin .truncatingRemainder(dividingBy: 60))
        let timeSec = String(format: "%.0f",sum .truncatingRemainder(dividingBy: 60))
        let formTime = (timeHrs + ":" + timeMin + "." + timeSec)
        
        return formTime
    }
    
//    Set the total to empty string.
    @State var total = ""
    
    var buttonImage: String {
//        Image titles for main button.
        time_started ? "play" : "stop"
    }
    var buttonLabel: String {
        // Text for the main button.
        time_started ? "TIME IN" : "TIME OUT"
    }
    var body: some View {
        VStack (alignment: .center){
            
            Button  {
//              Changes text and image for button.
                time_started.toggle()
                
//                Adds current time to list when clicked.
                time_list.append(Date())
            } label: {
                
//              This is what displays on the screen.
                Label(buttonLabel, systemImage: buttonImage)
                    .padding()
                    .background(
                        Circle()
                            .stroke(lineWidth: 4)
                            .padding(-35)
                    )
            }
            
            Spacer()
            
//            Resets list, and sets total variable to total time from list.
            Button("End Time \n Period")  {
                self.total = totalTime()
            }
            
            Spacer()
            
//            Displays total time on the screen
            Text("Total: " + self.total)
                .frame(width: 180)
                .padding()
        }
    }
    
    
}

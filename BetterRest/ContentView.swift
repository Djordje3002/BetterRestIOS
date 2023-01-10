import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = SleepPreferences.defaultSleepHours
    @State private var coffeeAmount = SleepPreferences.defaultCoffeeCups
    @State private var wakeUp = BedtimeSchedule.defaultWakeTime()
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                VStack {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }

                VStack{
                    Text("Desired amount of sleep")
                        .font(.headline)

                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: SleepPreferences.sleepHoursRange, step: SleepPreferences.sleepStep)
                }
                
                VStack{
                    Text("Daily coffee intake")
                        .font(.headline)

                    Stepper(coffeeAmount == 1 ? "\(coffeeAmount) cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: SleepPreferences.coffeeCupsRange)
                }

            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {}
            }message: {
                Text(alertMessage)
            .padding()
        }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let wakeSeconds = BedtimeSchedule.wakeSeconds(for: wakeUp)
            
            let prediction = try model.prediction(wake: wakeSeconds, estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = try BedtimeSchedule.bedtime(wakeUp: wakeUp, sleepDuration: prediction.actualSleep)
            
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }
}

#Preview {
    ContentView()
}

import SwiftUI

struct ContentView: View {
    @State private var calculator = BedtimeCalculator()
    @State private var sleepAmount = SleepPreferences.defaultSleepHours
    @State private var coffeeAmount = SleepPreferences.defaultCoffeeCups
    @State private var wakeUp = BedtimeSchedule.defaultWakeTime()
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker("Wake-up time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .accessibilityLabel("Wake-up time")
                }

                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: SleepPreferences.sleepHoursRange, step: SleepPreferences.sleepStep)
                }
                
                Section("Daily coffee intake") {
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
            let sleepTime = try calculator.bedtime(
                wakeUp: wakeUp,
                sleepHours: sleepAmount,
                coffeeCups: coffeeAmount
            )

            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch BedtimeSchedule.CalculationError.invalidPrediction {
            alertTitle = "Unable to estimate bedtime"
            alertMessage = "The model returned an unsupported sleep duration. Please adjust your inputs and try again."
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

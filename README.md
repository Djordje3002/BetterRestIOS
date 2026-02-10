# Smart Wake-Up Predictor ☕🌙

An **iOS app built with SwiftUI and CoreML** that predicts the optimal wake-up time based on **caffeine intake and consumption timing**.  
By analyzing when and how much coffee the user drinks, the app helps optimize sleep quality and improve morning alertness.

This project demonstrates practical usage of **machine learning on-device** combined with modern SwiftUI architecture.

---

## ✨ Features

### ☕ Caffeine Tracking
- Log number of coffees consumed per day
- Specify time of each coffee intake
- Supports different caffeine levels per drink

---

### 🧠 Machine Learning Prediction
- CoreML model predicts optimal wake-up time
- Uses:
  - Number of coffees
  - Timing of caffeine intake
  - Desired sleep duration
- Runs fully **on-device** (no server dependency)

---

### ⏰ Smart Wake-Up Planning
- Calculates recommended bedtime and wake-up time
- Adjusts predictions dynamically as input changes
- Helps avoid waking up during deep sleep phases

---

### 📊 Clear & Intuitive UI
- SwiftUI-based modern interface
- Real-time prediction updates
- Minimal input, maximum insight

---

## 🛠 Tech Stack

- **Swift**
- **SwiftUI**
- **CoreML**
- **Create ML** (for model training)
- **MVVM Architecture**

---

## 🧱 Architecture

The app follows **MVVM** for separation of concerns:

- **Models**
  - CaffeineEntry
  - SleepPrediction
- **Views**
  - InputView
  - ResultView
- **ViewModels**
  - PredictionViewModel
- **ML Layer**
  - CoreML model integration

This structure ensures clarity, scalability, and testability.

---

## 🤖 Machine Learning Details

- Model type: Regression
- Training tool: **Create ML**
- Inputs:
  - Caffeine amount (mg)
  - Time of consumption
  - Desired sleep duration
- Output:
  - Recommended wake-up time

The model is bundled with the app and evaluated in real time.

---

## 📸 Screenshots

| Input | Prediction | Result |
|------|-----------|--------|
| ![](Screenshots/input.png) | ![](Screenshots/prediction.png) | ![](Screenshots/result.png) |

*(Replace with real screenshots or GIFs)*

---

## 🚀 Getting Started

### Requirements
- iOS 16+
- Xcode 15+

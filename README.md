# FluxKart 🛒🚀
FluxKart is a **modern online delivery application** designed to provide **food and medicine delivery** through a single, seamless platform. The app focuses on speed, reliability, and user convenience while ensuring secure transactions and real-time order tracking.

## 🎥 App Demo

<div align="center">
  <table>
    <tr>
      <td>
        <video src="https://github.com/user-attachments/assets/12930a8f-c8c3-4e62-abee-835c09e73cb7"
               width="300"
               controls
        ></video>
      </td>
      <td>
        <video src="https://github.com/user-attachments/assets/43dc71f5-e3de-473e-8781-6775bfca8f57"
               width="300"
               controls
        ></video>
      </td>
    </tr>
  </table>
</div>



This repository contains the complete source code and documentation for FluxKart, built with scalability and clean architecture in mind.

---

## 📌 Problem Statement

Users often need to switch between multiple apps for:

* Ordering food 🍔
* Purchasing medicines 💊
* Tracking deliveries 🚚

FluxKart solves this by **combining food & medicine delivery in one app**, saving time and improving user experience.

---

## 🌟 Key Features

### 👤 User Authentication

* Phone / Email login
* Secure OTP-based verification
* Persistent user sessions

---

### 🏠 Home Dashboard

* Personalized greeting
* Category-wise browsing (Food / Medicine)
* Featured stores and popular items
* Search with instant suggestions

---

### 🍕 Food Ordering Module

* Browse restaurants and food outlets
* View menus with images and prices
* Add to cart with quantity control
* Custom instructions for food orders

---

### 💊 Medicine Ordering Module

* Browse nearby pharmacies
* Search medicines by name
* Upload doctor prescriptions (if required)
* Safety warnings and dosage information

---

### 🛒 Smart Cart System

* Unified cart for food and medicines
* Real-time price updates
* Automatic tax and delivery fee calculation
* Remove / update items instantly

---

### 📦 Order Placement

* Address selection using GPS
* Multiple payment options
* Order summary before checkout
* Estimated delivery time

---

### 📦 Order Status (Basic)

* Order placed confirmation
* Order accepted by seller
* Order delivered status

---

### 💳 Payment Integration

* Cash on Delivery (COD)
* Online payments (UPI / Cards – configurable)
* Secure transaction handling

---

### 🔔 Notifications

* Order status updates
* Promotional offers
* Delivery alerts

---

### ⭐ Feedback (Planned)

* Ratings and reviews are **not yet implemented**
* Feature planned for future versions

---

### 🧑‍💼 Admin / Seller Panel (Planned)

* Manage products and inventory
* Order management dashboard
* Sales analytics
* User management

---

## 🏗️ Architecture Overview

* Clean Architecture
* MVVM / Bloc-based state management
* Repository pattern
* Scalable and modular codebase

---

## 🧰 Tech Stack

### 📱 Frontend

* Flutter (Cross-platform)
* Dart
* Bloc / Provider (State Management)

### 🖥️ Backend (Pluggable)

* REST APIs
* Firebase / Node.js (configurable)

### 🗄️ Database

* Firebase Firestore / SQL-based backend

### 📍 Services

* Google Maps API
* Geolocation Services
* Push Notifications

---

## 🔐 Security

* Secure authentication
* Encrypted API communication
* Role-based access control

---

## 📂 Project Structure

```
lib/
 ├── core/        # Common utilities & constants
 ├── auth/        # Login & authentication
 ├── home/        # Dashboard & categories
 ├── food/        # Food ordering module
 ├── medicine/    # Medicine ordering module
 ├── cart/        # Cart & checkout
 ├── orders/      # Order tracking
 └── main.dart
```

---

## 🚀 Future Enhancements

* Live order tracking with map integration
* Ratings & reviews for products and delivery
* AI-based product recommendations
* Subscription-based medicine delivery
* Voice search
* Dark mode
* Multi-language support

---

## 🛠️ Installation & Setup

1. Clone the repository

   ```bash
   git clone https://github.com/your-username/fluxkart.git
   ```
2. Install dependencies

   ```bash
   flutter pub get
   ```
3. Run the app

   ```bash
   flutter run
   ```

---

## 🤝 Contribution Guidelines

Contributions are welcome! 🎉

* Fork the repository
* Create a feature branch
* Commit your changes
* Open a pull request

---

## 📄 License

This project is licensed under the **MIT License**.

---

## 👨‍💻 Author

**Avinash Rawat**
Android & Flutter Developer
Building scalable apps with clean architecture 🚀

---

⭐ If you like this project, don’t forget to star the repository!

# 🍽️ Recipe Finder

**Recipe Finder** is a beautifully crafted Flutter application that allows users to discover, view, and manage delicious recipes from the [Spoonacular API](https://spoonacular.com/food-api). Built with **Clean Architecture** and **modular structure**, it ensures scalability, testability, and long-term maintainability.

---

## 🚀 Features

- 🔍 Search for recipes by ingredients or name
- 🍽️ View detailed recipe instructions and ingredients
- ❤️ Save favorite recipes locally
- 🌐 Fully integrated with the Spoonacular API
- 💡 Smooth animations with Lottie & Shimmer effects
- 🧱 Built using Clean Architecture & Bloc pattern

---

## 📦 Tech Stack

| Layer         | Tech                            |
|---------------|----------------------------------|
| UI            | Flutter Widgets + ScreenUtil     |
| State Mgmt    | Flutter BLoC + Provider (where needed) |
| DI            | GetIt                            |
| API           | Dio                              |
| Persistence   | SharedPreferences                |
| Styling       | Google Fonts, Shimmer, Lottie    |
| Secrets Mgmt  | `flutter_dotenv`                 |

---

## 🛠️ Getting Started

### 1. 📥 Clone the project

```bash
git clone https://github.com/your_username/recipe_finder.git
cd recipe_finder


---

## 🔐 Environment Variables (.env)

This project uses environment variables to securely manage sensitive data like the Spoonacular API key using the flutter_dotenv package.
### 📄 Step-by-step setup

1. Copy the example file:

```bash
cp .env.example .env
Open .env and replace the placeholder with your actual API key:
API_KEY=your_real_spoonacular_api_key


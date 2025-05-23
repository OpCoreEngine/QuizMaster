# QuizMaster

QuizMaster is a comprehensive quiz application that allows users to create, take, and manage quizzes. The project is built using Node.js, Express, MongoDB for the backend, and React for the frontend. It provides features such as user authentication, quiz management, progress tracking, and viewing detailed quiz statistics.

## Table of Contents

- [Features](#features)
- [Quick Start with Docker](#quick-start-with-docker)
- [Manual Installation](#manual-installation)
  - [Folder Structure](#folder-structure)
  - [Backend](#backend)
  - [Frontend](#frontend)
- [Contribution](#contribution)
- [License](#license)
- [Contact](#contact)

## Features

- **User Authentication:** Sign In, Sign Up
- **Dashboard Navigation:** My Tests, My Results, Create Test, Take Test, Profile, Logout
- **Quiz Management:** Create, Edit, Delete quizzes
- **Progress Tracking:** Save progress, auto-submit quizzes after time limit is reached
- **Detailed Statistics:** View quiz results, detailed statistics, and ranking of users
- **Responsive Design:** Ensures compatibility across various devices

## Quick Start with Docker

🚀 **Recommended for easy setup!** Run the entire application with a single command:

### Prerequisites
- Docker (with Docker Compose plugin)

### Installation & Running

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd QuizMaster
   ```

2. **Run with our automated script:**
   ```bash
   ./start.sh
   ```

3. **Or manually run:**
   ```bash
   docker compose up --build
   ```

4. **Access the application:**
   Open your browser and navigate to: **http://localhost:5000**

### Docker Commands

- **Start:** `docker compose up -d`
- **Stop:** `docker compose down`
- **View logs:** `docker compose logs -f`
- **Rebuild:** `docker compose build --no-cache`

For detailed Docker setup instructions, see [DOCKER_README.md](DOCKER_README.md)

---

## Manual Installation

## Folder Structure

```
QuizMaster
├── backend
│   ├── middleware
│   ├── models
│   ├── node_modules
│   ├── routes
│   ├── .env
│   ├── env_sample.txt
│   ├── index.js
│   ├── package-lock.json
│   ├── package.json
├── quiz-maker
│   ├── node_modules
│   ├── public
│   ├── src
│   │   ├── components
│   │   │   ├── Authorisation.css
│   │   │   ├── Authorisation.js
│   │   │   ├── CreateTest.css
│   │   │   ├── CreateTest.js
│   │   │   ├── DashBoard.css
│   │   │   ├── DashBoard.js
│   │   │   ├── EditQuiz.css
│   │   │   ├── EditQuiz.js
│   │   │   ├── ForGotPassword.js
│   │   │   ├── Home.css
│   │   │   ├── Home.js
│   │   │   ├── Loader.css
│   │   │   ├── Loader.js
│   │   │   ├── MyResults.css
│   │   │   ├── MyResults.js
│   │   │   ├── MyTests.css
│   │   │   ├── MyTests.js
│   │   │   ├── PageLoader.css
│   │   │   ├── PageLoader.js
│   │   │   ├── Profile.css
│   │   │   ├── Profile.js
│   │   │   ├── QuizCard.jsx
│   │   │   ├── QuizDetails.css
│   │   │   ├── QuizDetails.js
│   │   │   ├── ResetPassword.js
│   │   │   ├── ResultPage.css
│   │   │   ├── Resultpage.js
│   │   │   ├── Resultstats.css
│   │   │   ├── ResultStats.js
│   │   │   ├── TakeTest.css
│   │   │   ├── TakeTest.js
│   │   │   ├── TestPage.css
│   │   │   ├── TestPage.js
│   │   │   ├── UserScorestable.css
│   │   │   ├── UserScorestable.js
│   │   │   ├── .env
│   │   │   ├── .gitignore
│   │   │   ├── package-lock.json
│   │   │   ├── package.json
```

## Backend

### Description

The backend of QuizMaster is built using Node.js and Express, and it interacts with a MongoDB database. It handles user authentication, quiz management, and progress tracking.

### Routes

- **User Routes:**
  - `/api/users/signup` - User registration
  - `/api/users/signin` - User login
  - `/api/users/profile` - Get user profile
  - `/api/users/update` - Update user profile

- **Quiz Routes:**
  - `/api/quizzes/create` - Create a new quiz
  - `/api/quizzes/:id` - Get quiz details
  - `/api/quizzes/:id/edit` - Edit a quiz
  - `/api/quizzes/:id/delete` - Delete a quiz
  - `/api/quizzes/:id/stats` - Get quiz statistics
  - `/api/quizzes/progress` - Track quiz progress
  - `/api/quizzes/submit` - Submit quiz results

### Environment Variables

- `PORT`: Port number for the server
- `MONGO_URI`: MongoDB connection string
- `JWT_SECRET`: Secret key for JWT
- `EMAIL_USER`: Email address for notifications
- `EMAIL_PASSWORD`: Password for the email account
- `FRONTEND_URL`: URL for the frontend

### Backend Setup

1. Clone the repository.
2. Navigate to the `backend` directory.
3. Install dependencies using `npm install`.
4. Create a `.env` file and add the necessary environment variables.
5. Start the server using `npm start`.

## Frontend

### Description

The frontend of QuizMaster is built using React. It provides a user-friendly interface for managing and taking quizzes.

### Pages and Components

- **Home Page:** 
  - Contains buttons for Sign In, Sign Up, and Go to Dashboard (if logged in).
  
- **Dashboard Page:**
  - Navigation options: My Tests, My Results, Create Test, Take Test, Profile, Logout.
  
- **My Tests Page:**
  - Lists all tests created by the user.
  - Options to view details, edit, delete, or share quizzes.
  
- **Quiz Details Page:**
  - View quiz details with options to see stats, edit, or delete the quiz.
  
- **Edit Quiz Page:**
  - Edit quiz questions and options.
  
- **Result Page:**
  - View detailed quiz statistics (min, max, median, upper quartile, lower quartile) in a bar graph.
  - User ranking with pagination.
  
- **My Results Page:**
  - Lists all tests taken by the user along with their scores.
  - Option to view detailed stats for each test.
  
- **Create Test Page:**
  - Form to create new quizzes.
  
- **Profile Page:**
  - Update username and password.
  
- **Take Test Page:**
  - Search for quizzes by ID.
  - View quiz details and attempt the quiz.
  
- **Test Page:**
  - Display quiz instructions and questions.
  - Access quiz if status is not taken or in progress.

### Environment Variables

- `REACT_APP_BACKEND_URL`: URL for the backend API
- `REACT_APP_FRONTEND_URL`: URL for the frontend

### Frontend Setup

1. Clone the repository.
2. Navigate to the `quiz-maker` directory.
3. Install dependencies using `npm install`.
4. Create a `.env` file and add the necessary environment variables.
5. Start the development server using `npm start`.

## Contribution

Contributions are welcome! Please fork the repository and submit pull requests. For major changes, please open an issue first to discuss what you would like to change. For detailed Info refer to [Contribution.md](/Contribution.md).

## License

This project is licensed under the MIT License.

## Contact

For any questions or inquiries, please contact [vishalverma9572@gamail.com].
or Generate Issues.

---

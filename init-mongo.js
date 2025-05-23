// MongoDB initialization script
// This script creates a database user for the QuizMaster application

db = db.getSiblingDB('quizmaster');

// Create a user for the quizmaster database
db.createUser({
  user: 'quizuser',
  pwd: 'quizpass',
  roles: [
    {
      role: 'readWrite',
      db: 'quizmaster'
    }
  ]
});

// Create some initial collections (optional)
db.createCollection('users');
db.createCollection('quizzes');
db.createCollection('quizresults');
db.createCollection('quizprogresses');

print('QuizMaster database and user created successfully!'); 
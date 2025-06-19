# 📱 Math Quiz App

A mobile quiz app built with Flutter to help users improve their math skills in a fun and interactive way.

---

## 🚀 Features

- Units & Skills Navigation:  
  The app starts by showing a list of Units fetched from a local SQLite database. Each Unit contains several Skills.

- Progress Tracking:  
  For each Skill, users can see their progress categorized by difficulty levels: Easy, Medium, and Hard.

- Practice Quizzes:
  - Users can select the difficulty level and number of questions before starting a quiz.
  - Questions can be of type:
    - Multiple Choice Questions (MCQ)
    - Fill-in-the-blank numeric input
  - After answering each question, feedback is shown immediately (Correct or Wrong).
  - If the answer is wrong, an explanation is provided.

- End of Quiz Summary:
  - A summary screen shows the progress per level.
  - Option to view all wrong answers for review.

- Local Data Storage:
  - All questions, answers, stats, and wrong attempts are stored using SQLite.
  - Users’ progress and stats are persisted locally.

---

## 🛠 Tech Stack & Tools

- Flutter – Cross-platform mobile framework
- SQLite (`sqflite`) – Local database for persistent storage
- State Management – flutter_bloc
- Dependency Injection – get_it
- Responsive UI – flutter_screenutil
- Local Database File Access – path & path_provider
- Code Generation – json_serializable, build_runner
- Launcher Icon Configuration – flutter_launcher_icons

---

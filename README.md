# Flash-cards
Improve your skills with flash cards!

# Requirements (Make sure to add it to your path)
1. Server: Install Java OpenJDK17 & Maven 3.5+. 
2. Client: Instal Flutter SDK 3.10.1 & Dart 3.0.1 (Latest Version).
3. Add Flutter, Maven, and Java pathing to your system. (If not done yet).

# Running project (Mac Users)
1. Go to the main project.
2. Use the command 'make run-dev' in terminal to run both front-end and back-end.

# Running project (Windows Users)
1. Windows user needs to have two cmds open.
2. First cmd, cd into server folder and run './mvnw spring-boot:run'.
3. Second cmd, cd into client folder and run 'flutter run -d chrome'.

# Setup MySQL
1. Install mysql.
2. Open terminal / cmd.
3. Run 'service mysql start' or 'brew services mysql start'(if installed mysql using homebrew).
4. Run 'mysql -u root' to connect to the mysql.
5. Run "create database flash_cards_db;" in mysql.
6. Run "create user 'admin'@'%' identified by 'admin';".
7. Run "grant all on flash_cards_db.* to 'admin'@'%';".

# MySQL Migration (If the structure of db is changed)
1. Connect to the mysql as root.
2. Drop the database flash_cards_db.
3. Create the database flash_cards_db.
4. Run your server again.

# IDE
Use your favorite IDE as long as it supports Flutter.

## Subject Line Standard Terminology

First Word | Meaning
--- | --
Add | Create a capability e.g. feature, test, dependency.
Cut | Remove a capability e.g. feature, test, dependency.
Fix | Fix an issue e.g. bug, typo, accident, misstatement.
Bump | Increase the version of something e.g. dependency.
Refactor | A code change that MUST be just a refactoring.
Reformat | Refactor of formatting, e.g. omit whitespace.
Optimize | Refactor of performance, e.g. speed up code.
Document | Refactor of documentation, e.g. help files.

# Developers
1. Gangzhaorige Li
2. Ziming Wang
3. Tao Jin

# 📚 eShelf – Premium Library Management System

Welcome to **eShelf**! 🎉 We’ve built this application from the ground up to redefine how libraries, schools, and independent bookstores manage their digital catalogs. 

What started as a simple desktop app is now a **fully modernized, web-based platform** packed with beautiful glassmorphism designs, robust backend Java processing, and actual e-commerce tracking. 

Whether you're an Admin managing global stock, or a Student looking to borrow your next read, eShelf makes it a beautifully seamless experience.

---

## ✨ What's Inside?

We completely ditched the boring default grey/white layouts! The entire system has been meticulously designed using modern UI principles, deep gradients, and interactive components. 

Beyond looks, we've implemented a full suite of features:

### 🔐 Secure Access
- **Instant Registration:** Patrons can instantly sign up for an account via the beautifully designed portal.
- **Smart Authentication:** Secure login system using Email and Password tracking. 
- **Role-Based Routing:** Admins get a completely different dashboard experience with elevated permissions compared to standard Users.

### 💼 For the Administrators
- **Inventory Management:** Insert new books into the catalog directly from the dashboard. Adjust pricing, physical stock quantities, and borrowing availability limits.
- **Library Auditing:** A dedicated Admin-only Orders page tracks global historical purchases, mapping users to what they bought, and tracking total revenue generated across the platform.
- **Catalog Trimming:** Easily remove outdated or damaged literature from the library servers via one-click interactions.

### 🎒 For the Patrons (Users)
- **Extensive Global Search:** Can't find a book? Use the catalog search engine to filter literature by its title or author!
- **Library Circulations (Borrowing):** Check out a book on a 14-day loan. The global inventory drops automatically to prevent double-booking.
- **The "Digital Backpack":** A custom *My Literature* panel tracks all your active borrowing and historical purchases. 
- **Automagic Returns:** Done reading? Hit the Return button, and the system instantly restocks the digital shelf for the next person in line. 
- **E-Commerce Purchasing:** Love the book? Standard users can permanently purchase books which are tracked by an internal orders ledger!

---

## 🛠️ The Tech Stack Keeping the Lights On

Under the hood, eShelf runs on tried-and-true, unyielding Java infrastructure perfectly bridged with modern frontend execution:

- **Backend Logic:** Java Servlets & JavaServer Pages (JSP)
- **Database Engine:** MySQL 8.0+ via JDBC Driver Routing
- **Frontend Layer:** Handcrafted HTML5/CSS3 (No bulky CSS frameworks required!)
- **Web App Server:** Apache Tomcat 9
- **IDE:** Built seamlessly via IntelliJ IDEA

---

## 🚀 Getting Your Own Library Running Locally

Want to mess around with the codebase or test out the features? Follow these quick steps to get eShelf running on your machine:

### 1. Prerequisites
You’ll need a few standard tools installed:
- **Java Development Kit (JDK) 11** or higher.
- **Apache Tomcat 9** (Extracted locally).
- **MySQL Server** (and ideally MySQL Workbench makes things easier!).
- **IntelliJ IDEA** (Optional, but highly recommended for spinning up the server quickly).

### 2. Setting Up The Database
The very first thing you need is a place to store data. Spin up MySQL Workbench and run this schema to generate your perfect library database:

```sql
CREATE DATABASE library_management;
USE library_management;

-- Create the robust users tracking table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(255),
    phonenumber VARCHAR(20),
    password VARCHAR(100),
    role VARCHAR(50)
);

-- Note: You should manually insert a dummy Administrator so you have an initial login!
INSERT INTO users (name, email, phonenumber, password, role) 
VALUES ('Super Admin', 'admin@example.com', '123456789', 'abcdefgh', 'Admin');

-- Create the general books ledger
CREATE TABLE books (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  author VARCHAR(255) DEFAULT NULL,
  publisher VARCHAR(255) DEFAULT NULL,
  address VARCHAR(255) DEFAULT NULL,
  qty INT DEFAULT NULL,
  price DOUBLE DEFAULT NULL,
  brwcopies INT DEFAULT NULL
);

-- Build relational link tables for borrowings and permanent purchases
CREATE TABLE borrowings (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  book_id INT,
  user_id INT,
  start_date DATE,
  finish_date DATE,
  FOREIGN KEY (book_id) REFERENCES books(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE orders (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  book_id INT,
  user_id INT,
  price DOUBLE,
  qty INT,
  FOREIGN KEY (book_id) REFERENCES books(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### 3. Firing It Up
Finally, grab your MySQL Connector `mysql-connector-j.jar` file, drop it into your project's `WEB-INF/lib` folder, compile your Java files to the `classes/` output directory, and start Tomcat! 

Navigate to `http://localhost:8080/eShelf/login.html` to begin your journey. Enjoy the library! ☕📖

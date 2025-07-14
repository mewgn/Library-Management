CREATE DATABASE LibrarySystem;
USE LibrarySystem;

CREATE DATABASE IF NOT EXISTS LibrarySystem;
USE LibrarySystem;

CREATE TABLE User (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fullname VARCHAR(100) NOT NULL,
    password VARCHAR(50) NOT NULL,
    role VARCHAR(20) NOT NULL
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    StudentNumber VARCHAR(11) UNIQUE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES User(id)
);

CREATE TABLE Librarian (
    LibrarianID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    EmployeeNumber VARCHAR(11) UNIQUE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES User(id)
);

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100) NOT NULL
);

CREATE TABLE LibraryMaterial (
    ISBN VARCHAR(20) PRIMARY KEY,
    BookName VARCHAR(255) NOT NULL,
    Authors VARCHAR(255),
    PublishedDate DATE,
    CategoryName VARCHAR(100), -- replaced CategoryID
    Publisher VARCHAR(255),
    Status VARCHAR(20) DEFAULT 'Available',
    Overview TEXT
);

CREATE TABLE BorrowingList (
    BorrowID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    ISBN VARCHAR(20),
    BorrowedDate DATE,
    ExpectedReturnDate DATE,
    ActualReturnDate DATE,
    ReturnStatus VARCHAR(20) DEFAULT 'Returned',
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (ISBN) REFERENCES LibraryMaterial(ISBN)
);

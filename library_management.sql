USE library_management;

CREATE TABLE User (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Address TEXT,
    TelNo VARCHAR(20),
    Email VARCHAR(100) UNIQUE NOT NULL,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    UserType ENUM('Student', 'Librarian', 'Admin') NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Category (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL UNIQUE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Student (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    StudentNumber VARCHAR(20) UNIQUE NOT NULL,
    Course VARCHAR(100) NOT NULL,
    YearLevel INT NOT NULL CHECK (YearLevel BETWEEN 1 AND 6),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE
);

CREATE TABLE Librarian (
    LibrarianID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    EmployeeNumber VARCHAR(20) UNIQUE NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE
);

CREATE TABLE LibraryMaterial (
    BookCode VARCHAR(20) PRIMARY KEY,
    BookName VARCHAR(200) NOT NULL,
    Authors VARCHAR(300) NOT NULL,
    PublishedDate DATE,
    CategoryID INT NOT NULL,
    Publisher VARCHAR(100),
    ISBN VARCHAR(20) UNIQUE,
    Status ENUM('Available', 'Borrowed', 'Reserved', 'Maintenance', 'Lost') DEFAULT 'Available',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID) ON DELETE RESTRICT
);

CREATE TABLE BorrowingList (
    BorrowID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT NOT NULL,
    BookCode VARCHAR(20) NOT NULL,
    BorrowedDate DATE NOT NULL DEFAULT (CURRENT_DATE),
    ExpectedReturnDate DATE NOT NULL,
    ActualReturnDate DATE NULL,
    ReturnStatus ENUM('Borrowed', 'Returned', 'Overdue', 'Lost') DEFAULT 'Borrowed',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (BookCode) REFERENCES LibraryMaterial(BookCode) ON DELETE CASCADE
);

CREATE INDEX idx_user_username ON User(Username);
CREATE INDEX idx_user_email ON User(Email);
CREATE INDEX idx_user_type ON User(UserType);
CREATE INDEX idx_student_number ON Student(StudentNumber);
CREATE INDEX idx_librarian_employee ON Librarian(EmployeeNumber);
CREATE INDEX idx_library_material_category ON LibraryMaterial(CategoryID);
CREATE INDEX idx_library_material_status ON LibraryMaterial(Status);
CREATE INDEX idx_borrowing_student ON BorrowingList(StudentID);
CREATE INDEX idx_borrowing_book ON BorrowingList(BookCode);
CREATE INDEX idx_borrowing_status ON BorrowingList(ReturnStatus);
CREATE INDEX idx_borrowing_dates ON BorrowingList(BorrowedDate, ExpectedReturnDate);

COMMIT;


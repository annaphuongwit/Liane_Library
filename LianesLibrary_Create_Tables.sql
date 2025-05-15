use LianesLibrary;

-- 1) Postcodes
CREATE TABLE Postcodes (
    PostcodeID INT PRIMARY KEY AUTO_INCREMENT,
    Postcode INT NOT NULL,
    City VARCHAR(255) NOT NULL,
    Country VARCHAR(255) NOT NULL
    
);



-- 2) Borrower
CREATE TABLE Borrower (
    BorrowerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Streetname VARCHAR(255) NOT NULL,
    House_number INT NOT NULL,
    PostcodeID INT,
    Telephone VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    FOREIGN KEY (PostcodeID) REFERENCES Postcodes(PostcodeID)

);



-- 3) Books
CREATE TABLE Books (
  BookID INT PRIMARY KEY AUTO_INCREMENT,
  Genre VARCHAR(255) NOT NULL,
  Author VARCHAR(255) NOT NULL,
  Title 	VARCHAR(255) NOT NULL,
  Quantity  INT  NOT NULL CHECK (Quantity >= 0),
    InStock TINYINT(1) NOT NULL DEFAULT 1,
    Language VARCHAR(45),
    IsFavourite BOOLEAN DEFAULT FALSE
  
  
);


-- 4) LoanStatus (Lookup-Tabelle für Statuswerte)

CREATE TABLE LoanStatus (
    LoanStatusID INT PRIMARY KEY AUTO_INCREMENT,
    StatusName VARCHAR(50) NOT NULL
);


-- 5) Loans
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY AUTO_INCREMENT,
    BorrowerID INT NOT NULL,
    BookID INT NOT NULL,
    LoanDate DATETIME NOT NULL,
    ReturnDate DATETIME,
    LoanStatusID INT DEFAULT 1,
    FOREIGN KEY (BorrowerID) REFERENCES Borrower(BorrowerID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (LoanStatusID) REFERENCES LoanStatus(LoanStatusID)
);

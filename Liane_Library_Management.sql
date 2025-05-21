USE Liane_Library_Management;
-- DATABASE SELECTION
-- TABLE: Postcodes
CREATE TABLE Postcodes (
    PostcodeID INT PRIMARY KEY AUTO_INCREMENT,
    Postcode INT NOT NULL,
    City VARCHAR(255) NOT NULL,
    Country VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

-- TABLE: Borrower
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
) ENGINE=InnoDB;

-- TABLE: Books
CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Genre VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    Title VARCHAR(255) NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    InStock TINYINT(1) NOT NULL DEFAULT 1,
    Language VARCHAR(45),
    IsFavourite BOOLEAN DEFAULT FALSE
) ENGINE=InnoDB;

-- TABLE: LoanStatus
CREATE TABLE LoanStatus (
    LoanStatusID INT PRIMARY KEY AUTO_INCREMENT,
    StatusName VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- TABLE: Loans
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY AUTO_INCREMENT,
    BorrowerID INT NOT NULL,
    BookID INT NOT NULL,
    LoanDate DATETIME NOT NULL,
    DueDate DATETIME,
    ReturnDate DATETIME,
    LoanStatusID INT DEFAULT 1,
    FOREIGN KEY (BorrowerID) REFERENCES Borrower(BorrowerID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (LoanStatusID) REFERENCES LoanStatus(LoanStatusID)
) ENGINE=InnoDB;

-- TABLE: Reviews
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    BorrowerID INT,
    ReviewText TEXT,
    Rating TINYINT CHECK (Rating BETWEEN 1 AND 5),
    ReviewDate DATETIME DEFAULT NOW(),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (BorrowerID) REFERENCES Borrower(BorrowerID)
);

-- SAMPLE DATA
-- Postcodes
INSERT INTO Postcodes (Postcode, City, Country) VALUES
(10115, 'Berlin', 'Germany'),
(80331, 'Munich', 'Germany'),
(50667, 'Cologne', 'Germany'),
(20095, 'Hamburg', 'Germany'),
(70173, 'Stuttgart', 'Germany');

-- Borrower
INSERT INTO Borrower (FirstName, LastName, Streetname, House_number, PostcodeID, Telephone, Email) VALUES
('Alice', 'Müller', 'Kurfürstenstrasse', 12, 1, '0301234567', 'alice@example.com'),
('Bob', 'Schmidt', 'Leopoldstrasse', 45, 2, '0899876543', 'bob@example.com'),
('Charlie', 'Weber', 'Domstrasse', 8, 3, '0221123456', 'charlie@example.com'),
('Dana', 'Berger', 'Mönckebergstrasse', 5, 4, '0401237890', 'dana@example.com'),
('Eric', 'Hoffmann', 'Königstrasse', 27, 5, '0711123456', 'eric@example.com'),
('Franz', 'Keller', 'Marktstrasse', 10, 1, '0307654321', 'franz@example.com'),
('Greta', 'Neumann', 'Sendlingerstrasse', 30, 2, '0893214567', 'greta@example.com');

-- Books
INSERT INTO Books (Genre, Author, Title, Quantity, InStock, Language, IsFavourite) VALUES
('Fantasy', 'J.K. Rowling', 'Harry Potter and the Sorcerer''s Stone', 5, 1, 'English', TRUE),
('Science Fiction', 'Isaac Asimov', 'Foundation', 3, 1, 'English', FALSE),
('Mystery', 'Agatha Christie', 'Murder on the Orient Express', 2, 1, 'English', TRUE),
('Fantasy', 'J.R.R. Tolkien', 'The Hobbit', 4, 1, 'English', TRUE),
('Science Fiction', 'Frank Herbert', 'Dune', 6, 1, 'English', TRUE),
('Mystery', 'Arthur Conan Doyle', 'The Hound of the Baskervilles', 2, 1, 'English', FALSE),
('Historical Fiction', 'Ken Follett', 'Pillars of the Earth', 3, 1, 'English', FALSE),
('Romance', 'Jane Austen', 'Pride and Prejudice', 2, 1, 'English', FALSE),
('Non-Fiction', 'Yuval Noah Harari', 'Sapiens', 4, 1, 'English', TRUE),
('Biography', 'Walter Isaacson', 'Steve Jobs', 3, 1, 'English', FALSE);

-- LoanStatus
INSERT INTO LoanStatus (StatusName) VALUES
('borrowed'), ('returned'), ('lost');

-- Loans
INSERT INTO Loans (BorrowerID, BookID, LoanDate, DueDate, ReturnDate, LoanStatusID) VALUES
(1, 1, '2025-05-01 10:00:00', '2025-05-31 10:00:00', NULL, 1),
(2, 2, '2025-04-10 14:00:00', '2025-05-10 14:00:00', '2025-05-01 16:00:00', 2),
(3, 3, '2025-04-01 12:30:00', '2025-05-01 12:30:00', NULL, 3),
(4, 4, '2025-05-03 09:00:00', '2025-06-02 09:00:00', NULL, 1),
(5, 5, '2025-04-12 11:00:00', '2025-05-12 11:00:00', '2025-04-25 15:30:00', 2),
(6, 6, '2025-03-20 08:45:00', '2025-04-19 08:45:00', NULL, 3),
(7, 7, '2025-04-18 17:20:00', '2025-05-18 17:20:00', NULL, 1),
(1, 8, '2025-05-04 13:00:00', '2025-06-03 13:00:00', NULL, 1),
(2, 9, '2025-03-15 10:30:00', '2025-04-14 10:30:00', '2025-03-30 14:00:00', 2),
(3, 10, '2025-02-20 16:00:00', '2025-03-22 16:00:00', NULL, 3),
(4, 1, '2025-04-10 12:00:00', '2025-05-10 12:00:00', NULL, 1),
(5, 3, '2025-03-11 15:45:00', '2025-04-10 15:45:00', '2025-03-20 12:00:00', 2),
(6, 5, '2025-01-15 10:00:00', '2025-02-14 10:00:00', NULL, 3),
(7, 2, '2025-04-01 09:30:00', '2025-05-01 09:30:00', NULL, 1),
(1, 6, '2025-05-05 14:10:00', '2025-06-04 14:10:00', NULL, 1);

-- Reviews
INSERT INTO Reviews (BookID, BorrowerID, ReviewText, Rating) VALUES
(1, 1, 'Absolutely loved the magical world!', 5),
(2, 2, 'Fascinating ideas and a classic of sci-fi.', 4),
(3, 3, 'Great mystery, kept me guessing until the end.', 5),
(4, 4, 'A bit slow at the beginning but overall good.', 3),
(5, 5, 'Epic and detailed universe. A must-read.', 5);


-- VIEW: BorrowedBooks
CREATE VIEW BorrowedBooks AS
SELECT 
    b.Title,
    b.Author,
    br.FirstName,
    br.LastName,
    l.LoanDate,
    l.DueDate,
    ls.StatusName
FROM Loans l
JOIN Books b ON l.BookID = b.BookID
JOIN Borrower br ON l.BorrowerID = br.BorrowerID
JOIN LoanStatus ls ON l.LoanStatusID = ls.LoanStatusID
WHERE ls.StatusName = 'borrowed';

-- QUERY: Overdue Books (Assuming 30-day borrow period)
SELECT 
    b.Title, br.FirstName, br.LastName, l.LoanDate, l.DueDate
FROM Loans l
JOIN Books b ON l.BookID = b.BookID
JOIN Borrower br ON l.BorrowerID = br.BorrowerID
WHERE l.LoanStatusID = 1
AND l.DueDate < NOW();

-- STORED PROCEDURE: Lend a Book
DELIMITER //
CREATE PROCEDURE sp_LendBook (
    IN in_BookID INT,
    IN in_BorrowerID INT
)
BEGIN
    DECLARE due DATETIME;
    SET due = NOW() + INTERVAL 30 DAY;

    INSERT INTO Loans (BorrowerID, BookID, LoanDate, DueDate, LoanStatusID)
    VALUES (in_BorrowerID, in_BookID, NOW(), due, 1);

    UPDATE Books
    SET Quantity = Quantity - 1,
        InStock = IF(Quantity - 1 > 0, 1, 0)
    WHERE BookID = in_BookID;
END;//
DELIMITER ;

-- STORED PROCEDURE: Return a Book
DELIMITER //
CREATE PROCEDURE sp_ReturnBook (
    IN in_LoanID INT
)
BEGIN
    UPDATE Loans
    SET ReturnDate = NOW(), LoanStatusID = 2
    WHERE LoanID = in_LoanID;

    UPDATE Books
    SET Quantity = Quantity + 1,
        InStock = 1
    WHERE BookID = (SELECT BookID FROM Loans WHERE LoanID = in_LoanID);
END;//
DELIMITER ;

-- FUNCTION: Count of Books Borrowed by a User
DELIMITER //
CREATE FUNCTION fn_BooksBorrowedByUser(in_BorrowerID INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE bookCount INT;
    SELECT COUNT(*) INTO bookCount
    FROM Loans
    WHERE BorrowerID = in_BorrowerID AND LoanStatusID = 1;
    RETURN bookCount;
END;//
DELIMITER ;

SELECT
    l.LoanID,
    CONCAT(b.Title, ' - borrowed by ', br.FirstName, ' ', br.LastName, ' on ', DATE(l.LoanDate)) AS display_text
FROM Loans l
JOIN Books b ON l.BookID = b.BookID
JOIN Borrower br ON l.BorrowerID = br.BorrowerID
WHERE l.LoanStatusID = 1;




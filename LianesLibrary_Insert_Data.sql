-- 1. Postcodes
INSERT INTO Postcodes (Postcode, City, Country) VALUES
(10115, 'Berlin', 'Germany'),
(80331, 'Munich', 'Germany'),
(50667, 'Cologne', 'Germany');

-- 2. Borrower
INSERT INTO Borrower (FirstName, LastName, Streetname, House_number, PostcodeID, Telephone, Email) VALUES
('Alice', 'Müller', 'Kurfürstenstrasse', 12, '1', '0301234567', 'alice@example.com'),
('Bob', 'Schmidt', 'Leopoldstrasse', 45, '2', '0899876543', 'bob@example.com'),
('Charlie', 'Weber', 'Domstrasse', 8, '3', '0221123456', 'charlie@example.com');

-- 3. Books
INSERT INTO Books (Genre, Author, Title, Quantity, InStock, Language, IsFavourite) VALUES
('Fantasy', 'J.K. Rowling', 'Harry Potter and the Sorcerer\'s Stone', 5, 1, 'English', TRUE),
('Science Fiction', 'Isaac Asimov', 'Foundation', 3, 1, 'English', FALSE),
('Mystery', 'Agatha Christie', 'Murder on the Orient Express', 2, 1, 'English', TRUE);

-- 4. LoanStatus
INSERT INTO LoanStatus (StatusName) VALUES
('borrowed'), ('returned'), ('lost');

-- 5. Loans
INSERT INTO Loans (BorrowerID, BookID, LoanDate, ReturnDate, LoanStatusID) VALUES
(1, 1, '2025-05-01 10:00:00', NULL, 1),        -- Alice borrowed Harry Potter
(2, 2, '2025-04-10 14:00:00', '2025-05-01 16:00:00', 2),  -- Bob borrowed and returned Foundation
(3, 3, '2025-04-01 12:30:00', NULL, 3);        -- Charlie lost Murder on the Orient Express

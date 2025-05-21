from sqlalchemy import text
import pandas as pd

def fetch_all_books(engine):
    query = "SELECT * FROM Books"
    return pd.read_sql(query, con=engine)

def get_borrowers(engine):
    return pd.read_sql("SELECT * FROM Borrower", con=engine)

def lend_book(engine, book_id, borrower_id):
    with engine.connect() as connection:
        with connection.begin():
            connection.execute(text("CALL sp_LendBook(:book_id, :borrower_id)"),
                               {"book_id": book_id, "borrower_id": borrower_id})

def return_book(engine, loan_id):
    with engine.connect() as connection:
        with connection.begin():
            connection.execute(text("CALL sp_ReturnBook(:loan_id)"),
                               {"loan_id": loan_id})

def fetch_borrowed_books(engine):
    return pd.read_sql("SELECT * FROM BorrowedBooks", con=engine)

def fetch_overdue_books(engine):
    query = """
        SELECT b.Title, br.FirstName, br.LastName, l.LoanDate, l.DueDate
        FROM Loans l
        JOIN Books b ON l.BookID = b.BookID
        JOIN Borrower br ON l.BorrowerID = br.BorrowerID
        WHERE l.LoanStatusID = 1 AND l.DueDate < NOW();
    """
    return pd.read_sql(query, con=engine)

def fetch_reviews(engine):
    return pd.read_sql("SELECT * FROM Reviews", con=engine)

def submit_review(engine, book_id, borrower_id, review_text, rating):
    query = text("""
        INSERT INTO Reviews (BookID, BorrowerID, ReviewText, Rating) 
        VALUES (:book_id, :borrower_id, :review_text, :rating)
    """)
    params = {
        "book_id": book_id,
        "borrower_id": borrower_id,
        "review_text": review_text,
        "rating": rating
    }

    with engine.connect() as connection:
        with connection.begin():
            connection.execute(query, params)




def fetch_active_loans(engine):
    query = text("""
        SELECT
            l.LoanID,
            CONCAT(b.Title, ' - borrowed by ', br.FirstName, ' ', br.LastName, ' on ', DATE(l.LoanDate)) AS display_text
        FROM Loans l
        JOIN Books b ON l.BookID = b.BookID
        JOIN Borrower br ON l.BorrowerID = br.BorrowerID
        WHERE l.LoanStatusID = 1;
    """)
    with engine.connect() as conn:
        result = conn.execute(query)
        rows = result.fetchall()
        columns = result.keys()  # Get column names
        return [dict(zip(columns, row)) for row in rows]



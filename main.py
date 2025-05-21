import streamlit as st
import pandas as pd
from sqlalchemy import create_engine

# Load connection string from Config.py
from Config import connection_string

# Set page configuration (must be first Streamlit command)
st.set_page_config(page_title="Liane's Library", layout="centered")

# Create and cache the engine once
@st.cache_resource
def get_engine():
    return create_engine(connection_string)

engine = get_engine()

# Import DB utility functions
from db_utils import (
    fetch_all_books, lend_book, fetch_active_loans, return_book, 
    fetch_borrowed_books, fetch_overdue_books, 
    fetch_reviews, submit_review, get_borrowers
)

st.title("\U0001F4DA Liane's Personal Library")

# Define tabs
tab1, tab2, tab3, tab4, tab5, tab6, tab7 = st.tabs([
    "\U0001F4D8 All Books", "\U0001F4E4 Lend Book", "\U0001F4E5 Return Book",
    "\U0001F501 Borrowed", "\u23F0 Overdue", "\u2B50 Reviews", "\U0001F464 Borrowers"
])

# --- All Books Tab ---
with tab1:
    st.subheader("All Books in Library")
    st.dataframe(fetch_all_books(engine))

# --- Lend Book Tab ---
with tab2:
    st.subheader("Lend a Book")
    book_id = st.number_input("Enter Book ID", min_value=1)
    borrower_id = st.number_input("Enter Borrower ID", min_value=1)
    if st.button("Lend Book"):
        lend_book(engine, book_id, borrower_id)
        st.success("Book has been lent!")

# --- Return Book Tab ---
with tab3:
    st.subheader("Return a Book")

    active_loans = fetch_active_loans(engine)

    if active_loans:
        # Create a dictionary mapping display text to LoanID
        options = {row["display_text"]: row["LoanID"] for row in active_loans}
        selected_text = st.selectbox("Select a borrowed book to return", list(options.keys()))

        if st.button("Return Book"):
            loan_id = options[selected_text]
            return_book(engine, loan_id)
            st.success("Book has been returned!")
    else:
        st.info("No books currently borrowed.")




# --- Borrowed Books Tab ---
with tab4:
    st.subheader("Currently Borrowed Books")
    st.dataframe(fetch_borrowed_books(engine))

# --- Overdue Books Tab ---
with tab5:
    st.subheader("Overdue Books")
    st.dataframe(fetch_overdue_books(engine))

# --- Reviews Tab ---
with tab6:
    st.subheader("Book Reviews")
    st.write("\U0001F4C4 All Reviews")
    st.dataframe(fetch_reviews(engine))

    st.markdown("---")
    st.write("\u270D\uFE0F Submit a Review")
    review_book_id = st.number_input("Book ID", min_value=1, key="review_book_id")
    review_borrower_id = st.number_input("Your Borrower ID", min_value=1, key="review_borrower_id")
    rating = st.slider("Rating (1-5)", min_value=1, max_value=5, value=5)
    review_text = st.text_area("Your Review")
    if st.button("Submit Review"):
        submit_review(engine, review_book_id, review_borrower_id, review_text, rating)
        st.success("Thanks for your review!")

# --- Borrowers Tab ---
with tab7:
    st.subheader("Borrower List")
    borrowers_df = get_borrowers(engine)
    st.dataframe(borrowers_df)

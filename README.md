readme_content = """
# Liane_Library

Liane_Library is a database project designed to manage a digital library system. It includes the database schema, SQL scripts, and documentation for setting up and using the system.

---

## 📝 Description of Key Files

- `main.py`: The main entry point of the application, containing all Streamlit UI logic and user interaction workflows.
- `db_utils.py`: A utility module that includes reusable database functions, such as executing SQL queries and calling stored procedures.
- `requirements.txt`: Specifies all Python dependencies required to run the project.
- `README.md`: Contains project documentation, including setup instructions, reflections, and usage guidelines.
- `schema.sql`: (Optional) You can include this to initialize your MySQL schema.
- `sql_views_and_procedures/`: (Optional) Directory for storing raw SQL scripts used to create views (e.g., viewBorrowedBooks, viewReturnedBooks) and stored procedures.


# 📚 Library Management System

![Python](https://img.shields.io/badge/Python-3.10+-blue.svg)
![Streamlit](https://img.shields.io/badge/Streamlit-%E2%9C%94-red)
![MySQL](https://img.shields.io/badge/Database-MySQL-blue)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

A web-based application built with Streamlit and MySQL to simulate a library management system. This app allows users to view books, borrow and return books, track loan statuses, and submit reviews.

---

## ⚙️ Installation & Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/library-management-system.git
   cd library-management-system
2. **Create a Virtual Environment**
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
3. **Install Dependencies**
   ```bash
   pip install streamlit pandas sqlalchemy pymysql
   pip install -r requirements.txt
4. **Start the App**
   ```bash
   streamlit run app.py
5. **Ensure MySQL is running and the correct database schema is loaded with the required tables and views.**


---

## Getting Started

### Prerequisites

- MySQL Server installed (version 8.0 or higher recommended)
- MySQL Workbench (optional, for opening the .mwb schema file)
- Any SQL client such as DBeaver or HeidiSQL (for managing the database)
- Visual Studio Code or Google Colab (for writing and running Python code)


### Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/annaphuongwit/Liane_Library.git
2. Open the .mwb file using MySQL Workbench (optional – for visualizing the schema).
3. Run the queries in Liane_Library_Management.sql to create the database structure.
4. Execute the remaining queries in the same SQL file to populate the database with sample data and to create the necessary stored procedures and functions.


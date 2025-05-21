from dotenv import load_dotenv
import os

# Load .env file
load_dotenv(dotenv_path="Credential.env")

# Now fetch credentials from environment
user = os.getenv("DB_USER")
password = os.getenv("DB_PASSWORD")
host = os.getenv("DB_HOST")
port = os.getenv("DB_PORT")
schema = os.getenv("DB_NAME")

# Create connection string using environment variables
connection_string = f"mysql+pymysql://{user}:{password}@{host}:{port}/{schema}"
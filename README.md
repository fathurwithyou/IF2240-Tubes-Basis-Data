# Milestone 2: StonksBit Data Generation and Seeding

## Project Overview

This project, "StonksBit," is designed to generate comprehensive datasets and seed them into a MySQL database. It simulates data for a financial platform, likely focused on stock trading and social interactions related to market activities. The project includes scripts for generating various data entities such as users, stocks, stock market data (daily prices, live changes, IPOs), orders, transactions, user portfolios, posts, comments, likes, and moderation activities.

The core functionality involves:
1.  Generating synthetic data using Python scripts and Jupyter notebooks, leveraging libraries like Faker for realistic data creation and yfinance for stock market data.
2.  Storing the generated data in JSON format within the `data/raw/` directory.
3.  Utilizing configuration files in `data/config/` to define database table structures.
4.  Generating an SQL seeder script (`data/seeder/seeder.sql`) that creates the database schema and populates tables with the generated JSON data.
5.  Providing a test script (`test.py`) to execute the SQL seeder against a MySQL database.

## Features

* **Data Generation**: Creates diverse datasets including user profiles, stock information, historical and live stock prices, IPO details, user orders and transactions, portfolios, and social interaction data (posts, comments, likes).
* **Database Seeding**: Generates an SQL script to create and populate a MySQL database named `StonksBit`.
* **Configurable Schema**: Uses JSON configuration files to define table structures, allowing for flexibility in schema design.
* **Modular Design**: Separates data generation (`generator.ipynb`) from SQL seeding (`seeder.py`), promoting clarity and maintainability.

## Directory Structure

```
├── data/
│   ├── config/                 # JSON files defining table schemas
│   │   ├── Comments.json
│   │   ├── Stocks.json
│   │   └── ... (other config files)
│   ├── raw/                    # Generated raw data in JSON format
│   │   ├── Comments.json
│   │   ├── Stocks.json
│   │   └── ... (other raw data files)
│   └── seeder/
│       └── seeder.sql          # Generated SQL seeder script
├── generator.ipynb             # Jupyter notebook for data generation
├── seeder.ipynb                # Jupyter notebook for SQL seeder generation (alternative to seeder.py)
├── seeder.py                   # Python script for SQL seeder generation
├── test.py                     # Python script for testing database seeding
└── README.md                   # This
```

## Prerequisites

* Python 3 (Recommended: Python 3.9 or higher)
* Jupyter Notebook or JupyterLab (for running `.ipynb` files)
* MySQL Server
* Python Libraries:
    * `faker`
    * `yfinance`
    * `pandas`
    * `numpy`
    * `mysql-connector-python` (or a similar MySQL connector for Python, if modifying `test.py` or for direct database interaction)

## Setup and Installation

1.  **Clone the Repository (if applicable)**
    ```bash
    git clone <repository-url>
    cd Milestone 2
    ```

2.  **Install Python Dependencies**
    Create a virtual environment (recommended):
    ```bash
    python -m venv venv
    source venv/bin/activate  # On Windows, use `venv\Scripts\activate`
    ```
    Install the required libraries:
    ```bash
    pip install faker yfinance pandas numpy mysql-connector-python jupyterlab
    ```

3.  **MySQL Database Setup**
    Ensure you have a MySQL server running. The project will create a database named `StonksBit`. You might need to provide credentials (username, password) if your MySQL setup requires them (e.g., in `test.py`).

## Usage

1.  **Generate Raw Data:**
    Open and run the `generator.ipynb` notebook using JupyterLab or Jupyter Notebook.
    ```bash
    jupyter lab generator.ipynb
    ```
    This will populate the `data/raw/` directory with JSON files.

2.  **Generate SQL Seeder Script:**
    Run the `seeder.py` script from the command line:
    ```bash
    python seeder.py
    ```
    This will use the JSON files in `data/raw/` and configurations in `data/config/` to generate/update `data/seeder/seeder.sql`.
    Alternatively, you can run the `seeder.ipynb` notebook.

3.  **Seed the Database:**
    Execute the generated SQL script against your MySQL server. You can use a MySQL client or the provided `test.py` script.
    Using `mysql` command-line tool (replace `username` with your MySQL username):
    ```bash
    mysql -u username -p < data/seeder/seeder.sql
    ```
    You will be prompted for your MySQL password.

## Running Tests

The `test.py` script provides a basic way to execute the SQL seeder file.
Before running, you may need to configure MySQL credentials within the script if your setup requires it.
```bash
python test.py <username> <password> "data/seeder/seeder.sql"
```
Replace `<username>` and `<password>` with your MySQL credentials, and ensure the path to `seeder.sql` is correct.

## Data Schema

The database schema includes tables for users, stocks, stock IPOs, daily stock prices, live stock price changes, transactions, orders, moderators, posts (and their associated likes, comments, tags), portfolios, predictions, and IPO orders. Detailed table structures and attributes are defined in the `data/config/` JSON files and listed in `archive.md`.

Key tables include:
* `users`
* `stocks`
* `stock_ipo`
* `stock_daily_price`
* `live_stock_price_change`
* `transactions`
* `orders`
* `portfolios`
* `posts`
* `comments`
* And various linking tables for relationships like likes, tags, etc.

## Contributing

Contributions to this project are welcome. Please follow standard coding practices and ensure any changes are well-documented.
1.  Fork the repository.
2.  Create a new branch (`git checkout -b feature/YourFeature`).
3.  Commit your changes (`git commit -m 'Add some feature'`).
4.  Push to the branch (`git push origin feature/YourFeature`).
5.  Open a Pull Request.

## License

[MIT](LICENSE)
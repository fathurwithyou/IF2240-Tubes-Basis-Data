import subprocess

def run_cmd(command):
    try:
        subprocess.run(command, shell=True, check=True)
        print("Command executed successfully.")
    except subprocess.CalledProcessError as e:
        print("Error executing command:", e)

def run_sql_file(username, password, sql_file_path):
    # 1. Run the seed file
    command = f'mysql -u {username} -p{password} < "{sql_file_path}"'
    run_cmd(command)

    # 2. Run follow-up SQL commands (in a single session)
    follow_up_commands = 'USE StonksBit; SHOW TABLES;'
    command = f'mysql -u {username} -p{password} -e "{follow_up_commands}"'
    run_cmd(command)

run_sql_file("root", " ", "data/seeder/seeder.sql")

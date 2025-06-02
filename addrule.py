import os


def add_rule():
    """
    Loads the content of 'seeder.sql' from the 'seeder' directory,
    then concatenates it with the content of all other '.sql' files
    found in the 'rules' directory.
    The combined content is then written to a new file named 'seeder_ruled.sql'
    in the 'rules' directory.
    """
    rules_dir_path = "./rules"
    seeder_dir_path = "./data/seeder"
    seeder_file_name = "seeder.sql"
    output_file_name = "seeder_ruled.sql"

    seeder_file_path = os.path.join(seeder_dir_path, seeder_file_name)
    output_file_path = os.path.join(seeder_dir_path, output_file_name)

    if not os.path.exists(rules_dir_path):
        print(f"Directory '{rules_dir_path}' does not exist. Creating it.")
        os.makedirs(rules_dir_path)

    if not os.path.exists(seeder_dir_path):
        print(
            f"Directory '{seeder_dir_path}' does not exist. Please create it and place '{seeder_file_name}' inside.")
        return

    if not os.path.exists(seeder_file_path):
        print(
            f"Error: '{seeder_file_name}' not found in '{seeder_dir_path}'. This file is required to start.")
        return

    combined_content = []

    try:
        with open(seeder_file_path, 'r', encoding='utf-8') as f:
            combined_content.append(f.read())
        print(
            f"Successfully loaded '{seeder_file_name}' from '{seeder_dir_path}'.")
    except IOError as e:
        print(
            f"Error reading '{seeder_file_name}' from '{seeder_dir_path}': {e}")
        return

    all_files = os.listdir(rules_dir_path)
    rules_loaded_count = 0

    for file_name in all_files:

        if file_name.endswith(".sql") and file_name != seeder_file_name:
            rule_file_path = os.path.join(rules_dir_path, file_name)
            try:
                with open(rule_file_path, 'r', encoding='utf-8') as f:
                    combined_content.append(
                        "\n-- --- Start of " + file_name + " ---\n")
                    combined_content.append(f.read())
                    combined_content.append(
                        "\n-- --- End of " + file_name + " ---\n")
                print(f"Successfully loaded rule file: '{file_name}'.")
                rules_loaded_count += 1
            except IOError as e:
                print(
                    f"Error reading rule file '{file_name}': {e}. Skipping this file.")
            except Exception as e:
                print(
                    f"An unexpected error occurred with rule file '{file_name}': {e}. Skipping.")

    if rules_loaded_count == 0:
        print(f"No additional .sql rule files found in '{rules_dir_path}'.")

    try:
        with open(output_file_path, 'w', encoding='utf-8') as output_file:
            output_file.write("".join(combined_content))
        print(
            f"\nSuccessfully created and wrote to '{output_file_name}' in '{rules_dir_path}'.")
    except IOError as e:
        print(f"Error writing to '{output_file_name}': {e}")
    except Exception as e:
        print(
            f"An unexpected error occurred while writing '{output_file_name}': {e}")


if __name__ == "__main__":
    add_rule()

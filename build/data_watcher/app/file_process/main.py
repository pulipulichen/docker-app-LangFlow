DATA_FORLDER = "/data/"
INEXT_FOLDER = "/data_index/"

# List of supported extensions
MARKITDOWN_SUPPORTED_EXTEIONSIONS = {
    '.pdf', '.pptx', '.docx', '.xlsx',
    '.csv', '.json', '.xml', '.html',
    '.zip', '.jpg', '.jpeg', '.png',
    '.gif', '.bmp', '.mp3', '.wav'
}

PLAIN_TEXT_EXTEIONSIONS = {
    '.txt', '.md'
}

# Attempt to import numpy module
import numpy

# Use a function from the numpy module
array = numpy.array([1, 2, 3, 4, 5])

# =================================================================

# from markitdown import MarkItDown
import sys
import os
import shutil
import subprocess

# md = MarkItDown()


def convert_to_index_file_path(file_path):
    output_path = file_path.replace(DATA_FORLDER, INEXT_FOLDER, 1) + ".md"

    dir_path = os.path.dirname(output_path)
    # Create directories if they don't exist
    os.makedirs(dir_path, exist_ok=True)

    return output_path

def display_file_content(file_path, is_init):
    """
    Display the file path and its content.
    
    Args:
        file_path (str): The path to the file.
        is_init (bool): Flag indicating whether this is the initial conversion process.
    """
    # print(f"display_file_content: {file_path} {is_init}")

    if not os.path.isfile(file_path):
        print(f"Error: The provided path '{file_path}' is not a valid file.")
        return

    # ======================

    output_file = convert_to_index_file_path(file_path)
    if is_init and os.path.isfile(output_file):
        return

    _, ext = os.path.splitext(file_path)

    if ext.lower() not in MARKITDOWN_SUPPORTED_EXTEIONSIONS:
        print(f"{file_path} is not supported by MarkItDown.")

        if ext.lower() in PLAIN_TEXT_EXTEIONSIONS:
            try:
                shutil.copyfile(file_path, output_file)
                print(f"File copied from {file_path} to {output_file}")
            except FileNotFoundError:
                print(f"Error: The file {file_path} does not exist.")
            except Exception as e:
                print(f"An error occurred: {e}")
            return 
        return 
    
    # ======================

    print(f"File Path: {file_path}\n")
    try:
        # with open(file_path, 'r', encoding='utf-8') as file:
        #     content = file.read()
        #     print("File Content:\n")
        #     print(content)
        # result = md.convert(file_path)
        
        # # Save the Markdown content to the specified output file
        # with open(output_file, 'w', encoding='utf-8') as output:
        #     output.write(result.text_content)
        #     print(f"{file_path} is supported by MarkItDown.")

        # Define the shell command
        command = f"markitdown {file_path} > {output_file}"

        subprocess.run(command, shell=True, capture_output=True, text=True)


    except Exception as e:
        print(f"Error reading file: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python file_process.py <file_path> <is_init>")
    else:
        file_path = sys.argv[1]
        is_init = (sys.argv[2] == "true")
        display_file_content(file_path, is_init)

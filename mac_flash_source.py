
import tkinter as tk
from tkinter import filedialog
import subprocess
import sys
import os

root = tk.Tk()
root.title("Flash .bin to FPGA")

# Set the background color
root.configure(bg="#f4f4f4")

#  change text to white 
root.option_add("*Label.Foreground", "black")
root.option_add("*Button.Foreground", "black")


# Set the margins and paddings
root.geometry("600x600")
root.minsize(400, 300)
root.columnconfigure(0, weight=1, minsize=100)
root.columnconfigure(1, weight=1, minsize=100)
root.rowconfigure(0, weight=1, minsize=50)
root.rowconfigure(1, weight=1, minsize=50)
root.rowconfigure(2, weight=1, minsize=100)
root.rowconfigure(3, weight=1, minsize=50)

# Create a variable to store the selected file path
file_path = ""

# Create a label for the file selector button
label_file = tk.Label(root, text="Select a file using the Browse button below:", bg="#f4f4f4", font=("Arial", 20))
label_file.grid(row=0, column=0, columnspan=2, pady=(20,10))

# Create a label to display the selected file name
label_file_name = tk.Label(root, text="No file selected", bg="#f4f4f4", fg="#000000", font=("Arial", 20))
label_file_name.grid(row=3, column=0, columnspan=2, pady=(0, 20))
def resource_path(relative_path):
    """ Get absolute path to resource, works for dev and for PyInstaller """
    try:
        # PyInstaller creates a temp folder and stores path in _MEIPASS
        base_path = sys._MEIPASS
    except Exception:
        base_path = os.path.abspath(".")

    return os.path.join(base_path, relative_path)

# Create a file selector button widget
def select_file():
    global file_path
    file_path = filedialog.askopenfilename()
    if file_path:
        file_name = os.path.basename(file_path)
        message = "Selected file: " + file_name
        label_file_name.config(text=message)
    else:
        label_file_name.config(text="No file selected")
    print("Selected file:", file_path)

button_file = tk.Button(root, text="Select .bin File", bg="#00FF00", fg="#000000", font=("Arial", 20), command=select_file)
button_file.grid(row=1, column=0, padx=(50,10), pady=10, sticky="e")

# Create a "Run" button widget
def run_command():
    text_output.config(state="normal")
    text_output.insert(tk.END, "Beginning flash... please wait for about 20 seconds\n")
    text_output.config(state="disabled")
    text_output.see(tk.END)
    root.update()
    global file_path

    # Clear the text widget before running the command
    text_output.config(state="normal")
    text_output.delete("1.0", tk.END)
    text_output.config(state="disabled")
    print(file_path)
    # Run the command and update the text widget in real-time
    iceprog_path = resource_path('./iceprog.exe')
    process = subprocess.Popen([iceprog_path, file_path], stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    stdout, _ = process.communicate()
    text_output.config(state="normal")
    text_output.insert(tk.END, stdout)
    text_output.config(state="disabled")
    text_output.see(tk.END)
    root.update()

button_run = tk.Button(root, text="Flash", bg="#00ff00", fg="#333333", font=("Arial", 20), command=run_command)
root.update()
button_run.grid(row=1, column=1, padx=(10,50), pady=10, sticky="w")
root.update()

# Create a text widget for the output
text_output = tk.Text(root, bg="#dddddd", fg="#000000", font=("Arial", 15), wrap="word", state="disabled")
text_output.grid(row=2, column=0, columnspan=2, padx=10, pady=10, sticky="nsew")
root.update()
root.mainloop()
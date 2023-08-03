import threading
import PySimpleGUI as sg
from main.classes.line_of_sight import LineOfSight
import csv

sg.theme('darkgreen3')
layout = [
    [sg.Image(filename='C:\CY_ENNA_Tool\ENNA_LOGO.png', expand_x=True, expand_y=True)],
    [sg.Text('Aircraft:'), sg.InputText('C:\CY_ENNA_Tool\DATA\Aircraft_DATA.csv', size=(60, 1), key='first_file_location'), sg.FileBrowse()],
    [sg.Text('VHF:    '), sg.Combo(['VHF_DATA'], key='VHF', default_value='')],
    [sg.Button('Create File')]        
]

# window = sg.Window('CY_ENNA_Tool', layout, background_color='white')
window = sg.Window('CY_ENNA_Tool').Layout(layout)

def run_application():
    first_file = "C:\\CY_ENNA_Tool\\DATA\\" + values['VHF'] +".csv"
    second_file = "C:\CY_ENNA_Tool\DATA\Aircraft_DATA.csv"
    height_units = "FEET"
    distance_units = "NAUTICAL_MILES"
    output_folder = "C:\CY_ENNA_Tool\OUTPUT"
    api = "AIzaSyAoL085gV__1K3kIrX3KOT_6MbCbRB0-W8"
    amount_samples = 500

    coordinate_data = []
    with open(first_file, "r") as file:
        reader = csv.reader(file)
        for row in reader:
            coordinate_data.append(row)

    csv_file_path = "C:\CY_ENNA_Tool\DATA\VHF_DATA.csv"
    with open(csv_file_path, "w", newline="") as file:
        writer = csv.writer(file)
        writer.writerows(coordinate_data)

    los = LineOfSight(first_file, second_file, samples=amount_samples, key=api, height_units=height_units, distance_units=distance_units, output=output_folder)
    los.get_los()

while True:
    event, values = window.Read()
    if event is None or event == 'Exit':
        break
    if event == 'Create File':
        x = threading.Thread(target=run_application, daemon=True).start()
window.Close()
import pandas as pd
import numpy as np

# LINE OF SIGHT APPLICATION
pythonCmd = 'C:\\Users\\Git\\AppData\\Local\\Programs\\Python\\Python311\\python.exe'  # COMMANDE
pythonFile = 'C:\\CY_ENNA_Tool\\gui.py'  # fichier python executable

import os
os.system(f'{pythonCmd} {pythonFile}')

# coordonées de VHF choisi
VhfCoor = 'C:\\CY_ENNA_Tool\\DATA\\VHF_DATA.csv'

# fichier CSV
data1 = pd.read_csv(VhfCoor, header=None, skiprows=1, encoding='ISO-8859-1')
lat1 = float(data1.iloc[0, 0])
lon1 = float(data1.iloc[0, 1])
h1 = float(data1.iloc[0, 2])

# coordonnées de l'aéronef
AircraftCoor = 'C:\\CY_ENNA_Tool\\DATA\\Aircraft_DATA.csv'

# fichier CSV
data2 = pd.read_csv(AircraftCoor, header=None, skiprows=1, encoding='ISO-8859-1')
lat2 = float(data2.iloc[0, 0])
lon2 = float(data2.iloc[0, 1])
h2 = float(data2.iloc[0, 2])

# données de l'application LOS
LosData = 'C:\\CY_ENNA_Tool\\OUTPUT\\DataForMatlab.csv'

# fichier CSV
data3 = pd.read_csv(LosData, header=None, encoding='ISO-8859-1')
LOS = data3.iloc[0, 0]  # Access the first column
ELV1 = data3.iloc[1, 0]  # Access the second column
ELV2 = data3.iloc[2, 0]

# fréquence de travail
f = 125  # valeur moyenne de la fréquence de 125 Mhz

if LOS == 0:
    print('Presence of terrain obstruction\nLack of direct visibility\n')
else:
    # CONVERSION DES COORDONNEES DE DEGREE EN RADIAN
    lat1 = np.deg2rad(lat1)
    lon1 = np.deg2rad(lon1)
    lat2 = np.deg2rad(lat2)
    lon2 = np.deg2rad(lon2)

    # rayon de la terre en kilometers
    R = 6371

    # FORMULE DE HAVERSINE
    deltaLat = lat2 - lat1
    deltaLon = lon2 - lon1
    a = np.sin(deltaLat / 2) ** 2 + np.cos(lat1) * np.cos(lat2) * np.sin(deltaLon / 2) ** 2
    c = 2 * np.arctan2(np.sqrt(a), np.sqrt(1 - a))
    r = R * c

    # distance entre l'aéronef et l'antenne VHF
    AltV = ELV2 / 3280.84
    AltA = ELV1 / 3280.84

    # DISTANCE AIR-SOL
    distance = np.sqrt((AltV - AltA) ** 2 + 4 * (R - AltA) * (R - AltV) * (np.sin(c / 2) ** 2))
    distance2 = distance / 1.852

    if distance2 > 200:
        print(f'The communication link distance is beyond the range of the VHF antenna.\nThe distance between the VHF and the aircraft is {distance2:.2f} NM.\n')
    else:
        # CHOIX DE CONDITION DE VENT DE SABLE
        print('Choose a case :')
        print('No sandstorm')
        print('Weak sandstorm or Light sandstorm')
        print('Moderate sandstorm')
        print('High sandstorm or Strong sandstorm')

        choice = int(input('Enter the number of your choice\n '))

        print(f'The distance between the VHF and the aircraft is {distance2:.2f} NM.\n')

        LU = np.zeros(round(distance2))

        for i in range(1, round(distance2) + 1):
            LU[i - 1] = 20 * np.log10(f) + 20 * np.log10(i) + 37.8

        if choice == 1:
            LUtot = np.max(LU)
        elif choice == 2:
            LUtot = np.max(LU) + 4.1825
        elif choice == 3:
            LUtot = np.max(LU) + 5.438
        elif choice == 4:
            LUtot = np.max(LU) + 7.23
        else:
            print('Invalid choice! Please select from the options provided.')

        pe = 47
        pr = pe - LUtot

        if pr > -93:
            print(f'The received power by the aircraft is {pr:.2f} dBm.\n')
        else:
            print('The received power did not reach the receiver''s sensitivity threshold.\n')

        # LES FIGURES DE PATHLOSS EN FONCTION DE LA DISTANCE
        import matplotlib.pyplot as plt

        x = np.arange(1, round(distance2) + 1)
        xx = np.linspace(x[0], x[-1], 10 * len(x))  # 10 fois plus de points que x
        yy = np.interp(xx, x, LU)

        plt.figure()
        plt.plot(xx, yy, 'g', linewidth=2)
        plt.legend(['Open Path Loss'])
        plt.grid(True)
        plt.xlabel('Propagation Distance (NM)')
        plt.ylabel('Path Loss (dB)')
        plt.title('Path Loss Curve as a Function of Propagation Distance')
        plt.show()

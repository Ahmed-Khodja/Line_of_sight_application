Overview
This application allows the user to batch process multiple line of sight queries and output them in graphical form, 
using data from the Google Elevation API. A .kml file is also produced for viewing in Google Earth.


First of all, you need to change a few things before executing the application.

Open the Python file "propagation_model" and change the line:

pythonCmd = 'C:\Users\Git\AppData\Local\Programs\Python\Python311\python.exe'

to your Python installation folder.

Put CY_ENNA_Tool in the (C:)

Run Propagation_Model.py and follow the on-screen instructions.

To run the application, in it's current form, you will require -

A valid 'Google Elevation API' key which is already provided
2x Valid .csv files one for the VHF Antenna and one for the aircraft you can find these in CY_ENNA_Tool\DATA

Valid CRS (Coordinate reference systems)
Decimal latitude/longitude

.csv files must use valid headers of -

latitude
longitude
height in feet
name

Current limitations
Currently the application has the following limitations -

This application requires internet access for Google Earth data.
Earth curvature is calculated, assuming that the Earth is a perfect sphere
Only Google Elevation API is currently supported
Only natural terrain is accounted for. This application does not take foliage or man-made objects/buildings into account

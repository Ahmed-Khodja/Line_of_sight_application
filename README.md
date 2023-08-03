# Propagation-Model
This application is a combination of line of sight and propagation model calculation 

read the readme.txt for more informations 

After running Propagation_Model.py :

![02](https://github.com/Ahmed-Khodja/Propagation-Model/assets/100228452/f125611f-af6a-4fc0-ac33-22bc1e7be718)

This is the interface of the presented application. In the "Aircraft" box, the Excel file path of the aircraft is automatically inserted. Additionally, we have a "VHF" box where we can manually select the antenna from the dropdown list. Furthermore, there is a "Create File" button allowing the generation of files based on the provided information.

Based on the user's choice of coordinates to test with the ground antennas, the files are created to provide information on the line of sight visibility between the ground antenna and the aircraft.

The name of the generated image differs for the two cases. In the case of line of sight visibility, it displays the line in green, and the name contains the term "positive." For the case where the lack of line of sight visibility is present, the line is red, and the name contains the term "negative," as shown in the figure for the two possible scenarios :

![image](https://github.com/Ahmed-Khodja/Propagation-Model/assets/100228452/c6fb7fa5-5560-49d9-95a0-a6ed46c5a8dc)

Let's consider the case of an altitude of 15,000 feet, which is approximately 4.5 km. This altitude is considered low for en-route control and poses certain problems for optimal radio coverage. 
We choose all VHF antennas with a height of 65 feet, which is approximately 20 meters. This height is typically the elevation at which the antenna is positioned above the ground.
The terrain is represented by a blue line, while the line of sight visibility is depicted in red in this case due to an intersection with the terrain. In this representation, the curvature of the Earth is taken into account, and it is shown by the orange line to provide a more realistic view of the position, although this figure assumes that the Earth is a perfect sphere.

It is essential to note that the scale of the graph considers the height above sea level rather than above the ground. 

![image](https://github.com/Ahmed-Khodja/Propagation-Model/assets/100228452/6a435514-5f7e-4cba-8d99-1751b6577241)

For a better visualization, representing the two points on Google Earth is required to obtain the actual positions and observe the intersection with the terrain. The resulting figure from the KML file is as follows:

![image](https://github.com/Ahmed-Khodja/Propagation-Model/assets/100228452/ad71e742-6f4a-4a4d-870d-1ee90d16de32)

For the successful line of sight visibility test, we keep the same geographical coordinates as in the previous case, but we change the flight level. Instead of 15,000 feet, we have chosen a flight level of 35,000 feet, which is equivalent to 10 km of altitude. The resulting figure is as follows: 

![image](https://github.com/Ahmed-Khodja/Propagation-Model/assets/100228452/b6428398-50dd-4ad5-8f3a-5b3f299d653e)

![image](https://github.com/Ahmed-Khodja/Propagation-Model/assets/100228452/83a905d5-df64-4203-84a3-68b37b259178)


If an intersection occurred and there is no direct visibility, then:

![image](https://github.com/Ahmed-Khodja/Propagation-Model/assets/100228452/36901356-2902-4f65-9d5b-8004767a04e9)

f we take the previous example in Part 2 of Chapter 4, where there is direct visibility between the Alger antenna and the aircraft at 35,000 feet, we will obtain the following results:

![image](https://github.com/Ahmed-Khodja/Propagation-Model/assets/100228452/f175c148-f466-45fe-b74a-730179bb878c)

Then, we will have the choice between 4 cases of sandstorm with corresponding percentage of losses:

Case of no sandstorm (absence of sandstorm) - 0% loss.
Case of low sandstorm - with a certain percentage of losses.
Case of moderate sandstorm - with a higher percentage of losses.
Case of high sandstorm - with the highest percentage of losses.

For example, if we select the case of no sandstorm because we are at the Alger antenna, we will obtain: 

![image](https://github.com/Ahmed-Khodja/Propagation-Model/assets/100228452/e0c9c81a-e214-4b23-b8f8-68b8e73c0629)

This result takes into account an input power of 47 dBm and uses the Friis propagation model (open environment) with sandstorm losses. Please note that the sandstorm losses are not present (Case of no sandstorm) in this example. The worst-case scenario for the sensitivity of the aircraft is -93 dBm.

![image](https://github.com/Ahmed-Khodja/Propagation-Model/assets/100228452/1055b6bb-0888-4773-a55c-e22c365e9a40)

This figure represents path losses in decibels (dB) as a function of distance in nautical miles (NM). As the distance increases, the path losses become more significant.

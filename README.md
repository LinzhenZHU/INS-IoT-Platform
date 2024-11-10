# INS-IoT-Platform
Inertial Navigation Systems based IoT Platform

The harware used in this project:

MCU:ESP32C3
MPU:MPU9250

Based on React Framwork, can be used cross-platform. The visulization of the trajectory is in real-time.

## How to use:
### Sensor Node:
1. If you want to connet more than one node, modify the Arduino code accordingly

### Server:
1. Used to collect the data from the Sensor nodes via TCP/IP through Server.py
2. If you have more nodes, build each node a setting.m and a coordinate.m accordingly. For example, if you have three nodes, you need settingA.m settingB.m settingC.m and the same for the coordinate.m to run the next step successfully
3. Run the main.m matlab code to calculate the coordinates of each person's localization, and it will be stored in the CSV (one file/person)

### MyWebSocket Server:
1. Used to update the coordinates from the CSV to the visulization application in realtime.
2. Start the searver before the visulization.

### Visulization:
1. Decompress the Visulizatin.zip via the link "https://drive.google.com/file/d/1CqjSF1jYeTXApAK5Lq8zBaCim0ZKdytK/view?usp=share_link"
2. Run the React application by "npm start HOST= " in the terminal
3. The visulization application has a cross-platform compality.

## Fot this Open Source Version, All of the localization part is based on the OpenShoeV1.0.0 which is an Open source embedded foot-mounted INS.
## We have some related works about to the improvement of the Dual-Foot Ins
R. Wu, B. G. Lee, M. Pike, L. Zhu, X. Chai and Y. Wang, "Enhancing DF-INS for Accurate Zero-Velocity Detection in ILBS: A Dual Foot Synergistic Method," 2023 IEEE SENSORS, Vienna, Austria, 2023, pp. 1-4, doi: 10.1109/SENSORS56945.2023.10325168. keywords: {Legged locomotion;Dynamics;Inertial navigation;Sensor systems;Trajectory;Sensors;Foot;dual foot inertial navigation system;dual foot synergistic method;general likelihood ratio test;moving average filter;zero-velocity detection},

Wu, R.; Lee, B.G.; Pike, M.; Zhu, L.; Chai, X.; Huang, L.; Wu, X. IOAM: A Novel Sensor Fusion-Based Wearable for Localization and Mapping. Remote Sens. 2022, 14, 6081. https://doi.org/10.3390/rs14236081

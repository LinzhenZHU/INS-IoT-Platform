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
1. Decompress the Visulizatin.zip
2. Run the React application by "npm start HOST= " in the terminal
3. The visulization application has a cross-platform compality.

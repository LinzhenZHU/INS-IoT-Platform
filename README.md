# INS-IoT-Platform
Inertial Navigation Systems based IoT Platform


MCU:ESP32C3
MPU:MPU9250

Based on React Framwork, can be used cross-platform. The visulization of the trajectory is in real-time.

## How to use:
### Sensor Node:
1. If you want to connet more than one node, modify the Arduino code accordingly

### Server:
1. Used to collect the data from the Sensor nodes via TCP/IP through Server.py
2. Run the matlab code to calculate the coordinates of the localization, 

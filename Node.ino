#include "Arduino.h"
#include "MPU9250.h"
#include <WiFi.h>
 
char *n = "C";
char otpt[40];
const char *ssid = ""; 
const char *password = "";
const IPAddress serverIP(,,,); 
uint16_t serverPort = ;
unsigned long currentMillis;
unsigned long previousMillis;

WiFiClient client; 
MPU9250 mpu;

void setup() {
    Serial.begin(500000);
    Wire.begin();
    delay(2000);
    WiFi.mode(WIFI_STA);
    WiFi.setSleep(false); 
    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED)
    {
        delay(500);
        Serial.print(".");
    }
    Serial.println("Connected");
    Serial.print("IP Address:");
    Serial.println(WiFi.localIP());
    Serial.println("Try to connect Server");
    if (client.connect(serverIP, serverPort))
    {
        Serial.println("Connected");
    }
    
  delay(5000);

    if (!mpu.setup(0x68)) {  // change to the actual MPU address
        while (1) {
            Serial.println("MPU connection failed.");
            delay(5000);
        }
    }

    mpu.verbose(true);
    delay(5000);
    mpu.calibrateAccelGyro();
    delay(1000);
    mpu.calibrateMag();
    mpu.verbose(false);
}

void loop() {

  currentMillis = millis(); // store the current time

  if (currentMillis - previousMillis >= 5) {    // 200hz



    if (mpu.update()) {
        sprintf(otpt, "%s%.4f %.4f %.4f %.4f %.4f %.4f\n",n,mpu.getAccX(), mpu.getAccY(), mpu.getAccZ(), mpu.getGyroX(), mpu.getGyroY(), mpu.getGyroZ());
  
    }
    previousMillis = currentMillis;  
    client.write(otpt);
    Serial.print(otpt);
  
    
  }
}



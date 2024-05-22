#include <SPI.h>
#include <MFRC522.h>
#include <WiFi.h>
#include <HTTPClient.h>
#include <NTPClient.h>
#include <WiFiUdp.h>
#include <TimeLib.h>  // Include the Time library

const int RST_PIN = 22;
const int SS_PIN = 21;

MFRC522 mfrc522(SS_PIN, RST_PIN);

String URL = "http://192.168.43.183:8080/myfyp/attendances.jsp";
const char* ssid = "HUAWEI nova 2i";
const char* password = "1234ramli";

// Define NTP Client to get time with offset for your timezone (UTC+8)
const long utcOffsetInSeconds = 8 * 3600; // 8 hours in seconds
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org", utcOffsetInSeconds, 60000); // Update time every minute

// Define the pins for the RGB LED and buzzer
const int redPin = 12;
const int greenPin = 13;
const int bluePin = 14;
const int buzzerPin = 5;

void setup() {
  Serial.begin(115200);

  SPI.begin();
  mfrc522.PCD_Init();
  mfrc522.PCD_DumpVersionToSerial();
  Serial.println(F("Scan PICC to see UID, SAK, type, and data blocks..."));

  connectWiFi();

  // Initialize the NTPClient to get time
  timeClient.begin();
  timeClient.update();

  // Initialize the RGB LED pins as outputs
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);
  // Initialize the buzzer pin as an output
  pinMode(buzzerPin, OUTPUT);

  // Set the initial state of the RGB LED to yellow and buzzer off
  setYellowLED();
  digitalWrite(buzzerPin, LOW);
}

void loop() {
  // Check for new RFID card
  if (!mfrc522.PICC_IsNewCardPresent() || !mfrc522.PICC_ReadCardSerial()) {
    return;
  }

  // Update the NTP client time
  timeClient.update();

  // Show UID on serial monitor
  Serial.print("UID tag :");
  String content = "";
  for (byte i = 0; i < mfrc522.uid.size; i++) {
    Serial.print(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " ");
    Serial.print(mfrc522.uid.uidByte[i], HEX);
    content.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " "));
    content.concat(String(mfrc522.uid.uidByte[i], HEX));
  }
  Serial.println();
  Serial.print("Message : ");
  content.toUpperCase();

  if (content.substring(1) == "E3 6A 4F 11") { // change here the UID of the card/cards that you want to give access
    Serial.println("Authorized access");
    sendUIDToServer(content.substring(1));
    setGreenLED();
    digitalWrite(buzzerPin, HIGH);
    delay(3000);
    setYellowLED();
    digitalWrite(buzzerPin, LOW);
  } else {
    Serial.println("Access denied");
    delay(3000);
  }

  // Halt PICC
  mfrc522.PICC_HaltA();
}

void connectWiFi() {
  WiFi.mode(WIFI_OFF);
  delay(1000);
  WiFi.mode(WIFI_STA);

  WiFi.begin(ssid, password);
  Serial.println("Connecting to WiFi");

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.print("Connected to: ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
}

void sendUIDToServer(String UID) {
  if (WiFi.status() != WL_CONNECTED) {
    connectWiFi();
  }

  // Update NTP time again to ensure the latest time is sent
  timeClient.update();

  // Get current time
  String formattedTime = timeClient.getFormattedTime();

  // Get current date
  time_t rawTime = timeClient.getEpochTime();
  struct tm *timeInfo = localtime(&rawTime);

  char dateBuffer[11];
  snprintf(dateBuffer, sizeof(dateBuffer), "%04d-%02d-%02d", 
           timeInfo->tm_year + 1900, 
           timeInfo->tm_mon + 1, 
           timeInfo->tm_mday);
  String formattedDate = String(dateBuffer);

  // Prepare the data to send
  String post = "UID=" + UID + "&time=" + formattedTime + "&date=" + formattedDate;

  HTTPClient http;
  http.begin(URL);
  http.addHeader("Content-Type", "application/x-www-form-urlencoded");

  int httpCode = http.POST(post);
  String payload = http.getString();

  Serial.println("URL : " + URL);
  Serial.println("Data : " + post);
  Serial.println("httpCode : " + String(httpCode));
  Serial.println("payload : " + payload);

  if (httpCode > 0) {
    // Success
    Serial.println("Request successful");
  } else {
    // Error
    Serial.print("Error on HTTP request: ");
    Serial.println(http.errorToString(httpCode).c_str());
  }

  http.end();
}

void setYellowLED() {
  digitalWrite(redPin, HIGH);
  digitalWrite(greenPin, HIGH);
  digitalWrite(bluePin, LOW);
}

void setGreenLED() {
  digitalWrite(redPin, LOW);
  digitalWrite(greenPin, HIGH);
  digitalWrite(bluePin, LOW);
}

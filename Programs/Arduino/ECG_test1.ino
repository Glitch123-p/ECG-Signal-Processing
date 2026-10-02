const int ECG_PIN = A0;
const int LO_PLUS = 10;
const int LO_MINUS = 11;

void setup() {
  Serial.begin(115200);

  pinMode(LO_PLUS, INPUT);
  pinMode(LO_MINUS, INPUT);
}

void loop() {

  if (digitalRead(LO_PLUS) == 1 || digitalRead(LO_MINUS) == 1) {
    Serial.println(0);
  }
  else {
    int ecgValue = analogRead(ECG_PIN);
    Serial.println(ecgValue);
  }

  delay(2);   // approximately 500 samples/second
}

int ledPinos[] = {32, 33, 27, 14, 12};
int buzzerPino = 19; //Pino do buzzer
int botaoPino = 21; // Pino do botão
int numLEDs = 5;
const char *ssid = "Wilson";
const char *pw = "123456789";


#define FREQ_LOW 1000  // Frequência baixa do alarme
#define FREQ_HIGH 2000  // Frequência alta do alarme
#include <WiFi.h>

WiFiServer server(80);

void setup() {
  for (int i = 0; i < numLEDs; i++) {
    pinMode(ledPinos[i], OUTPUT);
  }
  pinMode(buzzerPino, OUTPUT);
  pinMode(botaoPino, INPUT_PULLUP); // Configura o pino do botão como entrada com pull-up

  WiFi.begin(ssid, pw);

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
  }
  Serial.println("Conectado");
  Serial.println(WiFi.localIP());
  server.begin();
  Serial.begin(115200);
}

void loop() {
   WiFiClient client = server.available();
  if (client) {
    while (client.connected()) {
      client.print("conectado");
    }
  }
  if (Serial.available() > 0) {
    String input = Serial.readStringUntil('\n');
    if (input.length() > 0) {
      bool numeroAceito = true;
      for (int i = 0; i < input.length(); i++) {
        int led = input.charAt(i) - '0';
        if (led >= 1 && led <= numLEDs) {
          digitalWrite(ledPinos[led - 1], HIGH);
        } else {
          numeroAceito = false;
        }
      }

      if (numeroAceito) {
        tocarAlarme(10000);  // Toca o alarme por 10 segundos
        delay(10000);        // Mantém os LEDs acesos por 10 segundos
      }

      desligarTodos();
    }
  }
}

void tocarAlarme(int duracao) {
  unsigned long startTime = millis();
  while (millis() - startTime < duracao) {
    if (digitalRead(botaoPino) == LOW) { // Verifica se o botão foi pressionado
      noTone(buzzerPino); // Desliga o buzzer
      break; // Sai do loop
    }
    tone(buzzerPino, FREQ_LOW);
    delay(100);
    tone(buzzerPino, FREQ_HIGH);
    delay(100);
  }
  noTone(buzzerPino); // Garante que o buzzer esteja desligado ao final do loop
}

void desligarTodos() {
  for (int i = 0; i < numLEDs; i++) {
    digitalWrite(ledPinos[i], LOW);
  }
  digitalWrite(buzzerPino, LOW);
}

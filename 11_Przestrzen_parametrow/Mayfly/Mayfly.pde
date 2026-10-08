// @file
// @brief Program do modelowania mapy logistycznej z dwoma zamienianymi parametrami R
// Tłumaczenie z Delphi na Processing

final float Xo = 0.5;      // Jak 0 lub mniej to będzie losowo
final int N = 300;         // Ile iteracji
final int DZIEL = 100;
final int START = round(0 * DZIEL);       // Początek zakresu r
final int FINAL = round(4 * DZIEL);       // Koniec zakresu r
final int SWidth = 2 * (FINAL - START) + 170;
final int SHeight = 2 * (FINAL - START) + 20;

float[] szereg = new float[N + 1];  // Tablica na szereg czasowy

float srednia() {
  // Średnia arytmetyczna tablicy "szereg"
  float s = 0;
  for (int i = 0; i <= N; i++) {
    s += szereg[i];
  }
  return s / (N + 1);
}

float lapunow(float r1, float r2) {
  // Liczy wykładnik Lapunowa dla danego r1 i r2
  float s = 0;
  for (int i = 0; i <= N; i++) {
    float x = szereg[i];
    float a;

    if (i % 2 == 0) {
      a = abs(r1 - 2 * r1 * x);
    } else {
      a = abs(r2 - 2 * r2 * x);
    }

    if (a > 0) {
      s += log(a) / log(2);
    }
  }

  return s / (N + 1);
}

float autokorelacja(int krok) {
  // Liczy autokorelacje o zadanym przesunięciu
  float Xs = 0;
  float Ys = 0;
  float summ1 = 0;
  float summ2 = 0;
  float summ3 = 0;

  // Liczenie średnich
  for (int i = 0; i <= N - krok; i++) {
    Xs += szereg[i];
  }
  for (int i = krok; i <= N; i++) {
    Ys += szereg[i];
  }

  Xs /= (N - krok);
  Ys /= (N - krok);

  // Właściwe liczenie korelacji
  for (int i = 0; i <= N - krok; i++) {
    summ1 += (Xs - szereg[i]) * (Ys - szereg[i + krok]);
    summ2 += pow(Xs - szereg[i], 2);
    summ3 += pow(Ys - szereg[i + krok], 2);
  }

  if (summ2 > 0 && summ3 > 0) {
    return summ1 / (sqrt(summ2) * sqrt(summ3));
  } else {
    return 0;
  }
}

void ustawKolorL(float v) {
  // Mapowanie v na kolor dla wykładnika Lapunowa
  if (v > 0) {
    stroke(round(v * 255), round(v * 50), 0);
  } else {
    stroke(0, round(-v * 25), round(-v * 255));
  }
}

void ustawKolor1(float v) {
  // Mapowanie v na kolor (dla średniej i autokorelacji)
  if (v > 0) {
    stroke(round(v * 255), round(v * 255), 0);
  } else {
    stroke(0, round(-v * 255), round(-v * 255));
  }
}

void settings() {
  size(SWidth, SHeight);
  noSmooth();
}

void setup() {
  background(255);
  noLoop();

  float minL = 0;
  float maxL = 1;

  // Główna pętla obliczeniowa
  for (int k = START; k <= FINAL; k++) {
    for (int j = START; j <= FINAL; j++) {
      float x;
      if (Xo <= 0) {
        x = random(1);
      } else {
        x = Xo;
      }

      szereg[0] = x;
      float r1 = (float)k / DZIEL;
      float r2 = (float)j / DZIEL;

      // Iteracje mapy logistycznej
      for (int i = 1; i <= N; i++) {
        if (i % 2 == 0) {
          x = r1 * x * (1 - x);
        } else {
          x = r2 * x * (1 - x);
        }
        szereg[i] = x;
      }

      // Rysowanie wykładnika Lapunowa
      float L = lapunow(r1, r2);
      if (L > maxL) maxL = L;
      if (L < minL) minL = L;
      ustawKolorL(L);
      point((FINAL - START) + 10 + k - START, j - START);

      // Rysowanie średnich
      float S = srednia();
      ustawKolor1(S);
      point(k - START, (FINAL - START) + 10 + j - START);

      // Rysowanie autokorelacji
      float C = autokorelacja(5);
      ustawKolor1(C);
      point((FINAL - START) + 10 + k - START, (FINAL - START) + 10 + j - START);

      // Rysowanie ostatniego stanu
      ustawKolorL(x);
      point(k - START, j - START);
    }
  }

  // LEGENDA
  int j = (FINAL - START);
  for (int k = 0; k <= j; k++) {
    float xx = minL + k / (float)j * (maxL - minL);

    // Rysowanie skali L
    ustawKolorL(xx);
    line(2 * j + 50, k + 1, 2 * j + 80, k + 1);

    // Rysowanie skali od -1 do 1
    xx = -1.0f + k / (float)j * 2;
    ustawKolor1(xx);
    line(2 * j + 50, j + k + 10, 2 * j + 80, j + k + 10);
  }

  // Etykiety skali
  fill(0);
  textSize(10);
  text(String.format("%.2f", minL), 2 * j + 82, 15);
  text(String.format("%.2f", maxL), 2 * j + 82, j - 5);
  text(String.format("%.2f", -1.0), 2 * j + 82, j + 20);
  text(String.format("%.2f", 1.0), 2 * j + 82, 2 * j - 5);
}

void draw() {
  // Rysowanie już wykonane w setup()
}

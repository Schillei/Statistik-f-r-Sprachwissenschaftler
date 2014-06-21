% Hausaufgabe 07
% Isabel Schiller <schillei@students.uni-marburg.de>
% 2014-05-09

Falls die Umlaute in dieser und anderen Dateien nicht korrekt dargestellt werden, sollten Sie File > Reopen with Encoding > UTF-8 sofort machen (und auf jeden Fall ohne davor zu speichern), damit die Enkodierung korrekt erkannt wird! 




# Das sollte langsam automatisch sein...
1. Kopieren Sie diese Datei in Ihren Ordner (das können Sie innerhalb RStudio machen oder mit Explorer/Finder/usw.) und öffnen Sie die Kopie. Ab diesem Punkt arbeiten Sie mit der Kopie. Die Kopie bitte `hausaufgabe07.Rmd` nennen und nicht `Kopie...`
3. Sie sehen jetzt im Git-Tab, dass der neue Ordner als unbekannt (mit gelbem Fragezeichnen) da steht. Geben Sie Git Bescheid, dass Sie die Änderungen im Ordner verfolgen möchten (auf Stage klicken). Die neue Datei steht automatisch da.
4. Machen Sie ein Commit mit den bisherigen Änderungen (schreiben Sie eine sinnvolle Message dazu -- sinnvoll bedeutet nicht unbedingt lang) und danach einen Push.
5. Ersetzen Sie meinen Namen oben mit Ihrem. Klicken auf Stage, um die Änderung zu merken.
6. Ändern Sie das Datum auf heute. (Seien Sie ehrlich! Ich kann das sowieso am Commit sehen.)
7. Sie sehen jetzt, dass es zwei Symbol in der Status-Spalte gibt, eins für den Zustand im *Staging Area* (auch als *Index* bekannt), eins für den Zustand im Vergleich zum Staging Area. Sie haben die Datei modifiziert, eine Änderung in das Staging Area aufgenommen, und danach weitere Änderungen gemacht. Nur Änderungen im Staging Area werden in den Commit aufgenommen.
8. Stellen Sie die letzten Änderungen auch ins Staging Area und machen Sie einen Commit (immer mit sinnvoller Message!).
9. Vergessen Sie nicht am Ende, die Lizenz ggf. zu ändern!


# Verteilung von Noten
An der Uni Marburg nutzen wir eine 15 Punkte als Benotungskala (*Notenpunkte*). Wir nehmen an, dass der Mittelwert 8 NP (=3 im üblichen 1-5 System, was eigentlich einem durschnittlichen Verständnis des Stoffes entsprechen soll) ist. Wie sieht dann die Verteilung der Noten aus? Wir müssen uns noch überlegen, was eine sinnvolle Standardabweichung für die Noten wäre. Vielleicht ist am leichtesten, wenn wir einfach ein paar ausprobieren und plotten. Wir fangen mit $\sigma = 3,4,5$ an. Das entspricht 1, 1.5, 2 Noten auf der 1-5 Skala.


```r
noten <- 1:15
mu <- 8
drei <- dnorm(noten, mean = mu, sd = 3)
vier <- dnorm(noten, mean = mu, sd = 4)
fuenf <- dnorm(noten, mean = mu, sd = 5)

noten.dist <- data.frame(Notenpunkte = noten, drei, vier, fuenf)
noten.dist
```

```
##    Notenpunkte     drei    vier   fuenf
## 1            1 0.008741 0.02157 0.02995
## 2            2 0.017997 0.03238 0.03884
## 3            3 0.033159 0.04566 0.04839
## 4            4 0.054670 0.06049 0.05794
## 5            5 0.080657 0.07528 0.06664
## 6            6 0.106483 0.08802 0.07365
## 7            7 0.125794 0.09667 0.07821
## 8            8 0.132981 0.09974 0.07979
## 9            9 0.125794 0.09667 0.07821
## 10          10 0.106483 0.08802 0.07365
## 11          11 0.080657 0.07528 0.06664
## 12          12 0.054670 0.06049 0.05794
## 13          13 0.033159 0.04566 0.04839
## 14          14 0.017997 0.03238 0.03884
## 15          15 0.008741 0.02157 0.02995
```


Die Daten sind im sog. **wide format** (*breiten Format*), weil die Verschiedenenstufen einer Variable (hier: simulierte Standabweichung) "breit", d.h. über mehrere Spalten hinweg, dargestellt werden. Obwohl viele es als "natürlich" betrachten, ist dieses Format in R nicht bevorzugt. Unter anderem haben wir hier mehr Beobachtungen pro Zeile, was aus der Perspektive der Statistik ein bisschen durcheinander ist. R (und die Mathematik, die R Ihnen abnimmt) bevorzugt sog. **long format** (*langes Format*), wo es eine Beobachtung pro Zeile gibt. In diesem Format gibt es dann bei unsrem Beispiel eine weitere Spalte "Standardabweichung" und die drei verschiedenen beobachteten Messwerte werden zusammen in einer Spalte gepackt. Das Paket `reshape2` bietet ein paar Hilfsfunktionen an, die das Umformatieren viel leichter machen. (Sie müssen jetzt das Paket installieren, sonst funktioniert der nächste Block nicht!) (Es gibt auch das Paket `reshape` vom selben Autor, das auch ähnliches macht. `reshape2` hat ein paar Verbesserungen eingeführt, die nicht ganz rückwärtskompatibel sind.)

Die Funktion heißt `melt()` (*schmelzen*) aus der Analogie zu Schmieden, wo die Daten (der Rohstoff) in eine schmiedbare bzw. flüßige Form gebracht werden. Aus dem Long-Format kann man danach die Daten in andere Formate mit `cast()` (*gießen*) konvertieren. 


```r
library(reshape2)
# value.name is the name of the new column with the values that were
# previously spread out over several columns variable.name is the name of
# the new column with the old column names
melt(noten.dist, id.vars = "Notenpunkte", value.name = "P", variable.name = "Standardabweichung")
```

```
##    Notenpunkte Standardabweichung        P
## 1            1               drei 0.008741
## 2            2               drei 0.017997
## 3            3               drei 0.033159
## 4            4               drei 0.054670
## 5            5               drei 0.080657
## 6            6               drei 0.106483
## 7            7               drei 0.125794
## 8            8               drei 0.132981
## 9            9               drei 0.125794
## 10          10               drei 0.106483
## 11          11               drei 0.080657
## 12          12               drei 0.054670
## 13          13               drei 0.033159
## 14          14               drei 0.017997
## 15          15               drei 0.008741
## 16           1               vier 0.021569
## 17           2               vier 0.032379
## 18           3               vier 0.045662
## 19           4               vier 0.060493
## 20           5               vier 0.075284
## 21           6               vier 0.088016
## 22           7               vier 0.096667
## 23           8               vier 0.099736
## 24           9               vier 0.096667
## 25          10               vier 0.088016
## 26          11               vier 0.075284
## 27          12               vier 0.060493
## 28          13               vier 0.045662
## 29          14               vier 0.032379
## 30          15               vier 0.021569
## 31           1              fuenf 0.029945
## 32           2              fuenf 0.038837
## 33           3              fuenf 0.048394
## 34           4              fuenf 0.057938
## 35           5              fuenf 0.066645
## 36           6              fuenf 0.073654
## 37           7              fuenf 0.078209
## 38           8              fuenf 0.079788
## 39           9              fuenf 0.078209
## 40          10              fuenf 0.073654
## 41          11              fuenf 0.066645
## 42          12              fuenf 0.057938
## 43          13              fuenf 0.048394
## 44          14              fuenf 0.038837
## 45          15              fuenf 0.029945
```


Wir müssenden Output von `melt()` natürlich einer Variable zuweisen. Wir können die Ausgangsvaribel "überschreiben":


```r
noten.dist <- melt(noten.dist, id.vars = "Notenpunkte", value.name = "P", variable.name = "Standardabweichung")
```


Das funktioniert, weil alles rechts von `<-` zuerst gemacht wird. *Die Zuweisung finden erst nach der Evaluation der rechten Seite statt!* Jetzt können wir alle drei Verteilungen mit einem `ggplot`-Befehl plotten. 


```r
library(ggplot2)
# we use geom_line() because dnorm() already gave us the densities!  we onle
# use geom_density() when ggplot should calculate the density for u
ggplot(data = noten.dist, aes(x = Notenpunkte, y = P, color = Standardabweichung)) + 
    geom_line() + scale_x_continuous(limits = c(0, 16))
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 

Ich habe die Grenzen der Grafik ein bisschen breiter gestellt, sodass man die Endpunkte klar sieht und Sie auch einen weiteren `ggplot`-Befehl kennen lernen. Überlegung: Welche Verteilung sieht am fairsten aus? Warum?

Wir können das konkreter machen: wie viele Studenten bekommen bei den jeweiligen Verteilungen eine 1 (zumindest 13 NP)? Für die Verteilung mit $\sigma = 3$ sieht die Berechnung mit R so aus:

```r
pnorm(13, mean = mu, sd = 3, lower.tail = FALSE)
```

```
## [1] 0.04779
```

Oder vielleicht interessiert uns, wie viele Durchfallen (< 5NP):

```r
pnorm(5, mean = mu, sd = 3)
```

```
## [1] 0.1587
```


Wenn wir das für alle drei Gruppen wiederholen möchten, ist es ziemlich ärgerlich, wenn jede Gruppe einzel eingeben müssen. Dafür können wir eine **`for`-Schleife** nutzen:


```r
for (s in c(3, 4, 5)) {
    durchfall <- pnorm(5, mean = mu, sd = s)
    output <- paste("Bei einer Standabweichung von", s, "fallen", durchfall * 
        100, "% durch.")
    print(output)
}
```

```
## [1] "Bei einer Standabweichung von 3 fallen 15.8655253931457 % durch."
## [1] "Bei einer Standabweichung von 4 fallen 22.6627352376868 % durch."
## [1] "Bei einer Standabweichung von 5 fallen 27.4253117750074 % durch."
```


Aber wir hoffen alle, dass wir doch eine gute Note bekommen. Fügen Sie einen Code-Block hier ein, der das gleiche macht aber mit "ausgezeichneten" Noten (=1 bzw. >= 13) macht. (Bei evtl. Copy-Paste nicht vergessen, "fallen...durch" durch etwas Passendes zu ersetzen!)  


```r
for (s in c(3, 4, 5)) {
    ausgezeichnet <- pnorm(13, mean = mu, sd = s, lower.tail = FALSE)
    output <- paste("Bei einer Standabweichung von", s, "haben", ausgezeichnet * 
        100, "% eine ausgezeichnete Note")
    print(output)
}
```

```
## [1] "Bei einer Standabweichung von 3 haben 4.77903522728147 % eine ausgezeichnete Note"
## [1] "Bei einer Standabweichung von 4 haben 10.5649773666855 % eine ausgezeichnete Note"
## [1] "Bei einer Standabweichung von 5 haben 15.8655253931457 % eine ausgezeichnete Note"
```


Wie steht die Anzahl guter Noten in Beziehung zur Anzahl schlechter Noten? 

Die Anzahl schlechter Noten ist - unabhängig von der jeweiligen Standardabweichung - höher als die Anzahl ausgezeichneter Noten. 

Warum?

Es besteht ein ungleiches Verhältnis von 4:3. Die untersten vier Werten der Verteilung bedeuten, man fällt durch; die obersten drei Werte bedeuten, man hat eine ausgezeichnete Note.


## Kurtosis und Schiefe
Kurtosis (im Deutschen auch *Wölbung*) ist ein Maß dafür, wie spitzig eine Verteilung ist. Die Normalverteilung wird nie zu extrem spitzig -- der Gipfel bleibt immer schön rund, obwohl er manchmal eng wird. Andere Verteilungen (z.B. die Laplace-Verteilung ) haben Gipfel, die nicht rund sind.   

Schiefe (*skewness*) beschriebt die (A)Symmetrie einer Verteilung. Eine Verteilung ist *linksschief*, wenn die linke Seite "breiter" ist, d.h., wenn sich der "Gipfel" auf der rechten Seite befindet.  Eine Verteilung ist *rechtsschief*, wenn die rechte Seite "breiter" ist, d.h., wenn sich der "Gipfel" auf der linken Seite befindet 

Die Richtung der Schiefe ist insoweit die Richtung, wo der Schwanz dicker bzw. größer ist.

Die Verteilung von Noten ist oft schief mit mehr guten Noten. Ist die Verteilung rechts- oder linksschief?

linktsschief, da die linke Seite breiter ist.

Vielleicht hilft folgende Grafik mit der Visuelliserung:

```r
library(sn)
```

```
## Loading required package: mnormt
## Loading required package: numDeriv
## Loading required package: stats4
```

```r
qplot(x = 1:15, y = dsn(1:15, xi = c(12), omega = 1, alpha = -3, log = FALSE), 
    geom = "line", xlab = "Notenpunkte", ylab = "P")
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10.png) 


## Von Perzentilen auf Häufikgeiten
Wir können die Perzentile in Häufigkeiten übersezten. Nehmen wir an, dass es 50 Studenten in einem Kurs sind und dass die Noten wie oben normalverteilt sind. Dann können wir unsrem Data.Frame eine weitere Spalte hinzufügen:

```r
n <- 50
noten.dist$Anzahl <- noten.dist$P * n
noten.dist
```

```
##    Notenpunkte Standardabweichung        P Anzahl
## 1            1               drei 0.008741 0.4370
## 2            2               drei 0.017997 0.8998
## 3            3               drei 0.033159 1.6580
## 4            4               drei 0.054670 2.7335
## 5            5               drei 0.080657 4.0328
## 6            6               drei 0.106483 5.3241
## 7            7               drei 0.125794 6.2897
## 8            8               drei 0.132981 6.6490
## 9            9               drei 0.125794 6.2897
## 10          10               drei 0.106483 5.3241
## 11          11               drei 0.080657 4.0328
## 12          12               drei 0.054670 2.7335
## 13          13               drei 0.033159 1.6580
## 14          14               drei 0.017997 0.8998
## 15          15               drei 0.008741 0.4370
## 16           1               vier 0.021569 1.0785
## 17           2               vier 0.032379 1.6190
## 18           3               vier 0.045662 2.2831
## 19           4               vier 0.060493 3.0246
## 20           5               vier 0.075284 3.7642
## 21           6               vier 0.088016 4.4008
## 22           7               vier 0.096667 4.8334
## 23           8               vier 0.099736 4.9868
## 24           9               vier 0.096667 4.8334
## 25          10               vier 0.088016 4.4008
## 26          11               vier 0.075284 3.7642
## 27          12               vier 0.060493 3.0246
## 28          13               vier 0.045662 2.2831
## 29          14               vier 0.032379 1.6190
## 30          15               vier 0.021569 1.0785
## 31           1              fuenf 0.029945 1.4973
## 32           2              fuenf 0.038837 1.9419
## 33           3              fuenf 0.048394 2.4197
## 34           4              fuenf 0.057938 2.8969
## 35           5              fuenf 0.066645 3.3322
## 36           6              fuenf 0.073654 3.6827
## 37           7              fuenf 0.078209 3.9104
## 38           8              fuenf 0.079788 3.9894
## 39           9              fuenf 0.078209 3.9104
## 40          10              fuenf 0.073654 3.6827
## 41          11              fuenf 0.066645 3.3322
## 42          12              fuenf 0.057938 2.8969
## 43          13              fuenf 0.048394 2.4197
## 44          14              fuenf 0.038837 1.9419
## 45          15              fuenf 0.029945 1.4973
```


Jetzt können wir die absoluten Häufigkeiten auch plotten:


```r
ggplot(data = noten.dist, aes(x = Notenpunkte, y = Anzahl, color = Standardabweichung)) + 
    geom_line() + scale_x_continuous(limits = c(0, 16))
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12.png) 

Jetzt können Sie ein paar Fragen über die Verteilung konkret beantworten:

1. Wie viele Studenten bekommen zwischen 7 und 9 NP bei einer Standardabweichung von 3?

    13.0559 Studenten bekommen zwischen 7 und 9 Notenpunkten. 
    
    Wichtig: bei Wahrscheinlichkeits- und Häufigkeitsverteilung ist der linke Rand inklusiv aber der rechte Rand exklusiv! Das heißt, wir zählen hiermit die Leute, die bis auf 9 NP bekommen haben aber nicht die, die tatsächlich 9 NP bekommen haben!

2. Wie viele Studenten bekommen zumindest 10 NP?

    12.6246 Studenten bekommen mindestens 10 Notenpunkte.

3. Wie viele Studenten bekommen weniger als 10 NP?

    37.3754 Studenten bekommen weniger als 10 Notenpunkte.

4. Wie viele Studenten bekommen weniger als 8 NP?

    25 Studenten bekommen weniger als 8 Notenpunkten.


(Die Einrückung mit 4 Leerschlägen ist die Syntax für mehrere Absatz pro Punkt auf der Liste.)

## Von Noten zu Perzentilen -- ich möchte mich den anderen überlegen fühlen!
Manchmal will man in die andere Richtung gehen -- z.B. um die Frage beantworten zu können, welche Note man erreichen muss, um überdurschnittlich zu sein. Dafür haben wir `qnorm()`. Überdurchschnittlich heißt "besser als die Hälfte abscheiden" (duh!) und wir nehmen wieder an, dass die Standardabweichung gleich 3 ist. Dann haben wir die Aussage:

Um überdurchscnittlich zu sein, muss man mehr als 8 Notenpunkte bekommen. 

Nicht so überraschend, dass "überdurschnittlich" auch "besser als den Durchschnitt" bekommen! Wie sieht es aus, wenn man besser als 99% der anderen abschließen möchten?

Um in dem besten 1% abzuschließen, muss man zumindest 14.979 Notenpunkte bekommen.

## z-Transformation
Bei der Überprüfung der Lehrqualität scheint es der Verwaltung, dass ein gewisser Dozent andere Noten als andere Dozenten vergibt. Es wird entschieden, dass der Notenspiegel bei den Teilnehmern in einem von seinen Kursen getestet werden, um zu schauen, ob er von signifikant von der idealisierten Notenverteilung ($\mu=8,\sigma=3$) unterscheidet. Um zu zeigen, dass Gott $\alpha=0.06$ so viel liebt wie $\alpha=0.05$ (<a href="http://dx.doi.org/10.1037/0003-066X.44.10.1276">Rosnow & Rosenthal, 1989</a>), setzt die Verwaltung das Signikanzniveau auf 0.06. 

Der kritische Wert für einen einseitigen $z$-Test is 1.5548.

Die kritischen Werte für einen einseitigen $z$-Test sind $\pm$1.8808.

### Gibt es einen Unterschied?
Bei diesem Dozenten ist die Verwaltung wirklich unsicher, ob und was für einen Unterschied es geben könnte. (Welche Testart sollte man hier nutzen?)

In einem kleinen Seminar mit 7 Studenten beträgt der Durchnittswert 10. Unterscheidet sich der Notenspiegel von dem idealen? Berechnen Sie den $z$-Test:

```r
z7 <- sqrt(7) * ((10 - 8)/3)
print(z7)
```

```
## [1] 1.764
```


Das ist ein **insignifikanter** Unterschied, da 1.764 < 1.88. 

In einer Vorlesung vom selben Dozenten mit 50 Teilnehmern beträgt der Durchschnittswert wieder 10. (Es scheint, dass der Dozent 10 besonders toll findet.) Berechnen Sie den $z$-Test:

```r
z50 <- sqrt(50) * ((10 - 8)/3)
print(z7)
```

```
## [1] 1.764
```


Das ist ein **signifikanter** Unterschied. 

Ist die Benotung vom Dozenten weniger als ideal? 

### Ein anderer, böserer? Dozent
Die Verwaltung ist auch auf einen anderen Dozenten aufmerksam geworden, weil manche Studenten behaupten, er würde zu streng benoten. (Welche Testart sollte man hier nutzen?)

In einem mittelgroßen Seminar mit 20 Studenten beträgt der Durchschnittswert 7. Der Dozent sagt, dass das wunderbar nah am Erwartungswert (8) ist, und dass man ihn in Ruhe lassen sollte. Ist er zu streng?

Berechnen Sie den $z$-Test:

```r
z20 <- sqrt(20) * ((7 - 8)/3)
print(z20)
```

```
## [1] -1.491
```


Das ist ein **insignifikanter** Unterschied, da , 1,94 < 1,55 (kritischer Wert d. einseitigen Tests), 

Später ergibt sich, dass es eigentlich 25 Studenten im Kurs gab. (Der Dozent hat "einen Tippfehler" gemacht, als er seine Teilnehmerzahl per Mail an die Verwaltung geschickt hat.) Der Durschnittwert bleibt -- behauptet der Dozent -- immer noch bei 7. Er behauptet weiterhin, dass das wunderbar nah am Erwartungswert (8) ist, und dass man ihn in Ruhe lassen sollte. Ist er zu streng?

Berechnen Sie den $z$-Test:

```r
z25 <- sqrt(25) * ((7 - 8)/3)
print(z25)
```

```
## [1] -1.667
```


Das ist ein **signifikant** Unterschied. 

## Zum Überlegen
Gibt es einen Grund, weshalb die Noten normalverteilt sein sollten? Warum ist das die übliche Annahme?

# Andere Verteilungen
Die Normalverteilung ist nicht die einzige wichtige Verteilung. Manche Verteilungen entstehen ganz natürlich aus dem Vergleich anderer Verteilungen und werden zur Berechnung von Teststatistiken genutzt ($F$,$\chi^2$, $t$). Diese Verteilungen werden wir besprechen, wenn wir den entsprechenden Test lernen. 

## Binomialverteilung 

## Pareto Verteilung

## Poisson Verteilung

# Bibliografie

- Ralph L. Rosnow, Robert Rosenthal,   (1989) Statistical Procedures And The Justification of Knowledge in Psychological Science..  *American Psychologist*  **44**  1276-1284  [10.1037/0003-066X.44.10.1276](http://dx.doi.org/10.1037/0003-066X.44.10.1276)



# Lizenz
Diese Datei darf nur zu Prüfungszwecken verwendet werden.

# Hausaufgabe 05
# Isabel Schiller <Schillei@students.uni-marburg.de>
# 2014-05-02
# Diese Datei darf nur zu Prüfungszwecken verwendet werden.

# Sie sollten die Datei auch in Ihren Ordner kopieren und einen Commit machen, 
# bevor Sie die Kopie weiter anpassen! Vergessen Sie dabei nicht, Namen, Datum 
# und ggf. Lizenz zu ändern. Um einiges leichter zu machen, sollten Sie auch die
# Datei body_dim_long.tab aus dem Data-Ordner kopieren, stagen und commiten.

# (Im folgenden müssen Sie die Code-Zeilen wieder aktiv setzen -- ich habe sie
# vorläufig auskommentiert, damit der Output beim ersten Beispiel sehr
# überschaubar war.)

# Am Dienstag haben wir uns ein paar Plots mit den Daten aus dem Fragebogen
# gemacht. Hier werden wir weiter üben.

# Zuerst müssen wir ggplot laden
library(ggplot2)

# und danach die Daten:
dat <- read.table("body_dim_long.tab",header=TRUE) 

# Wir haben im Kurs die Verteilung der Variabel weight angeschaut. In Skripten
# werden Ergebnisse nicht automatich dargestellt, sondern nur dann, wenn ein
# print Befehl genutzt wird. Dann müssten wir eigentlich den ganzen "ggplot() +
# ..." Befehl in die Klammer von print() einpacken, was nicht besonders lesbar
# ist. Wie bei anderen Berechnungen können wir den Output von ggplot einer
# Variabel zuweisen. Danach müssen wir nur den Variabelnamen in die Klammer von
# print() einpacken.
weight.grafik <- ggplot(data=dat,aes(x=weight)) + geom_histogram(aes(y=..density..),fill="white",color="black") + geom_density()
print(weight.grafik)

# Wenn wir verschiedene Grafiken mit einem Datenzsatz machen möchten, ist es
# nervig, wenn wir den gemeinsamen Teil immer wieder eingeben müssen. Auch Teile
# von ggplot-Grafiken können einer Variabel zugewiesen werden:
weight.grafik.basis <- ggplot(data=dat,aes(x=weight))
print(weight.grafik.basis + geom_histogram())
print(weight.grafik.basis + geom_density())

# Wir haben auch mal die qplot()-Funktion gesehen. Sie ergibt eigentlich das
# Gleiche wie die "ggplot() + ..."-Befehle, hat nun eine andere Schnittstelle. 
weight.grafik.alt <- qplot(x=weight,data=dat,geom="density")
print(weight.grafik.alt)

# Weil das Gleiche ergeben wird, können wir auch den Ouput von qplot() mit
# weiteren geom_XXXX() Funktionen erweitern. 
weight.grafik.alt2 <- weight.grafik.alt + geom_histogram(aes(y=..density..),fill="white",color="black")
print(weight.grafik.alt2)

# Sie sehen an dieser Grafik auch, dass ggplot gestappelte Layers nutzt -- das 
# Histogramm wird auf das Layer mit Dichte gestappelt und daher wird die 
# Dichtekurve zum Teil versteckt. Wir können auch das Histogramm mit alpha
# transparenter machen.
weight.grafik.alt3 <- weight.grafik.alt + geom_histogram(aes(y=..density..),fill="white",color="black",alpha=0.65)
print(weight.grafik.alt3)

# ggplot hat auch eingebaute Untestützung für Box-Whisker-Plots, allerdings sind x und y jetzt anders:
weight.bw <- weight.grafik.basis + geom_boxplot(aes(x="weight",y=weight))
print(weight.bw)
# Sie sehen auch dabei, dass Layer-Asthetics Basis-Athetics brechen. 

# Aber viel interessanter ist eben, wenn wir Gruppen unterscheiden. Dann können etwas machen wie BW-Plot nach Geschlecht:
weight.bw.sex <- weight.grafik.basis + geom_boxplot(aes(x=sex,y=weight))
print(weight.bw.sex)

# Und als Erinnerung können wir auch ähnliches mit der Dichte machen:
print( weight.grafik.basis + geom_density(aes(color=sex,fill=sex),alpha=0.5) )

# Aber jetzt haben wir uns Gewicht mehrmals angeschaut. Es wird Zeit, dass uns
# auch Größe anschauen. Sind die Studenten mancher Studiengänge größer als die anderen?
# Weil wir deutlich weniger Männer haben und es einen bekannten Unterschied in der Größe 
# zwischen Männern und Frauen gibt, schließen wir erstmal die Männer aus:
frauen <- subset(dat, sex=="f")
print(frauen)

# (Sie sollten sich wirklich überlegen, ob der Schritt "gut" ist. Haben wir 
# dadurch unsre Ergebnisse verstellt? Sie müssen hier nichts schreiben, aber 
# überlegen Sie sich wirklich, ob der Schritt sinnvoll war und was für Probeme 
# er verursachen könnte. Sie könnten u.a. die folgenden Berechnungen und Plots
# zweimal machen und schauen, wie sich die Ergebnisse geändert haben.)

#Das erste, was wir machen, ist uns die Daten einfach als Box-Whisker-Diagramm 
#darzustellen. (Box-Whisker zuerst, weil Sie das auch per Hand machen könnten, 
#falls Sie unsicher sind, ob das Bild korrekt aussieht.) Hier und im Folgenden
#sollten Sie die Plots so machen, damit man einen Vergleich zwischen den Gruppen
#ziehen kann. Dafür gibt es verschiedene Möglichkeiten; die Wahl bleibt Ihnen
#überlassen. 

#Frauen
frauen.studiengang.bw <- ggplot(data=frauen,aes(x=major)) + geom_boxplot(aes(x=major,y=height))
print(frauen.studiengang.bw)

#Frauen und Männer
gesamt.studiengang.bw <- ggplot(data=dat,aes(x=major)) + geom_boxplot(aes(x=major, y=height))
print(gesamt.studiengang.bw)


# Sehen die Studiengänge anders aus? Wir müssen hier noch relativ vorrsichtig
# sein, weil die Gruppen *unbalanziert* sind, d.h. die Gruppen sind
# unterschiedlich groß. Aber wie sieht der Vergleich auf den ersten Blick aus?

# Auf den ersten Blick erkennt man nicht, dass die Gruppen unterschiedlich groß sind.
# Lediglich für den Studiengang Speech Science kann man sehen, dass es wohl nur eine
# Person gibt, die diesen Studiengang studiert. Es könnte natürlich auch sein, dass 
# mehrere Damen die gleiche Größe haben und deshalb keine Quartile angezeigt werden. 
# Dass dem nicht so ist, wissen wir nur, weil wir die Daten kennen.

# Wir können natürlich auch die Dichte anschauen:
frauen.studiengang.dichte <- ggplot(data=frauen,aes(x=major)) + geom_density(aes(x=height,color=major,fill=major),alpha=0.5)
print(frauen.studiengang.dichte)

# Haben Sie den gleichen Eindruck wie bei Box-Whisker bekommen? Unterscheiden
# sich die Gruppen?

# Die Gruppen unterscheiden sich in soweit, als dass bei der Darstellung der 
# Dichte nur die drei Studiengänge mit den meisten Studierenden dargestellt 
# werden. Da nur eine Person Germanistische Linguistik und zwei Personen etwas
# anderes studieren, werden diese nicht berücksichtigt. Somit kann im Unterschied
# zu bw auch keine falsche Interpretation der Daten entstehen.

# Welche Gruppe hat gefehlt? Wie viele Datenpunkte gab es für die Gruppe?
# Other (2 Datenpunkte) und Germanistische Linguistik (1 Datenpunkt) 
# haben gefehlt.

# Wir können auch die verschiedenen Maße der Streuung berechnen.
# In R gibt es oft verschiedene Möglichkeiten, etwas zu machen. Wir haben bisher
# Teile einer Datenmenge mit subset() rausgezogen, aber wir können das auch mit 
# einer weiteren Syntax machen:
klinisch <- frauen[frauen$major == "M.A..Klinische.Linguistik",]
print(klinisch)

# Das sieht erstmal sehr verwirrend aus, ist es aber nicht. Die eckigen
# Klammern bestimmen die Auswahl an Elementen. Wir haben das ja bei Indizen in
# Vektoren schon gesehen. Man kann eigentlich Indizen oder logische
# Einschränkungen nutzen, und das gleiche gilt für Data Frames. Bei Data Frames
# haben wir zwei Dimensionen, Zeilen (rows) und Spalten (columns), daher das
# Komma. Vor dem Komma werden die Zeilen spezifiziert, nach dem Komma die
# Spalten. Wir wollen alle Spalten mitnehmen, deshalb haben wir nach dem Komma
# nichts. (Das Komma ist hier *sehr* wichtig -- wenn Sie das Komma weglassen,
# selegieren Sie einzelne Elemente statt Zeilen und bekommen dann später
# verwirrende Fehlermeldungen.) 

# Jetzt brauchen wir die Teilmenge für die anderen beiden Studiengänge, 
# Linguistik Kognition und Kommunikation und Speech Science
# HINT: wie sehen die Namen aus bzw. wie werden sie im data frame buchstabiert?

linkk <- frauen[frauen$major == "M.A..Linguistik.Kognition.und.Kommunikation",]
print(linkk)

speech <- frauen[frauen$major == "M.A..Speech.Science",] 
print(speech)

# Berechnen Sie -- ohne Hilfe von sd() -- die Standardabweichung für die Größe der drei 
# Gruppen. Sie können auch weitere Zeilen hinzufügen, wenn es Ihnen so leichter
# ist. 
# HINT: Formel und Beispiel für die Berechnung auf den Folien!

# Berechnung der Standardabweichung für Klinische Linguistik
x <- (klinisch$height)
klinisch.mean <- mean(x)
klinisch.abweichung <- x - klinisch.mean
klinisch.quadr.abweichung <- klinisch.abweichung^2
varianz.x <- mean(klinisch.quadr.abweichung)
print(varianz.x)
klinisch.sd <- sqrt(varianz.x)
print(klinisch.sd)

# Berechnung der Standardabweichung für Speech Science
y <- (speech$height)
speech.mean <- mean(y)
speech.abweichung <- y - speech.mean
speech.quadr.abweichung <- speech.abweichung^2
varianz.y <- mean(speech.quadr.abweichung)
print(varianz.y)
speech.sd <- sqrt(varianz.y)
print(speech.sd)

# Berechnung der Standardabweichung für Linguistik, Kognition und Kommunikation
z <- (linkk$height)
linkk.mean <- mean(z)
linkk.abweichung <- z - linkk.mean
linkk.quadr.abweichung <- linkk.abweichung^2
varianz.z <- mean(linkk.quadr.abweichung)
print(varianz.z)
linkk.sd <- sqrt(varianz.z)
print(linkk.sd)

# Berichten Sie jetzt die Mittelwerte und Standardabweichungen für die drei Gruppen. Die erste Gruppe steht hier als Muster:
print( paste("Studiengang: Klinische Linguistik","Mean:",mean(klinisch$height),"SD:",klinisch.sd) )
print( paste("Studiengang: Linguistik Kognition und Kommunikation","Mean:",mean(linkk$height),"SD:",linkk.sd) )
print( paste("Studiengang: Speech Science","Mean:",mean(speech$height),"SD:",speech.sd) )


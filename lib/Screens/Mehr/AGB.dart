import 'package:flutter/material.dart';

class AGB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Allgemeine Geschäftsbedingungen",
        style: TextStyle(fontSize: 16),
      )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Text.rich(TextSpan(
              text:
                  'Allgemeine Geschäftsbedingungen (AGB) für die Nutzung von Barfbook\n\n',
              children: [
                TextSpan(text: "1. Nutzungsbedingungen"),
                TextSpan(
                    text:
                        "\n1.1. Diese AGB regeln das Verhältnis zwischen dem Nutzer und der Barfbook-App und legen die Bedingungen fest, unter denen die App genutzt werden darf."),
                TextSpan(
                    text:
                        "\n1.2. Die Barfbook-App dient ausschließlich zur Unterstützung von Hundebesitzern bei der Barf-Fütterung ihrer Hunde."),
                TextSpan(
                    text:
                        "\n1.3. Der Nutzer erklärt sich damit einverstanden, die App ausschließlich für private Zwecke und nicht für kommerzielle Zwecke zu nutzen."),
                TextSpan(text: "\n\n2. Haftungsbeschränkungen"),
                TextSpan(
                    text:
                        "\n2.1. Die Nutzung der Barfbook-App erfolgt auf eigenes Risiko des Nutzers."),
                TextSpan(
                    text:
                        "\n2.2. Der Betreiber der App übernimmt keine Haftung für Schäden, die durch die Nutzung der App entstehen können, insbesondere nicht für Schäden, die durch fehlerhafte oder unvollständige Informationen verursacht werden."),
                TextSpan(
                    text:
                        "\n2.3. Der Betreiber der App haftet nicht für Schäden, die durch höhere Gewalt oder andere unvorhersehbare Ereignisse verursacht werden."),
                TextSpan(text: "\n\n3. Datenschutz"),
                TextSpan(
                    text:
                        "\n3.1. Der Schutz personenbezogener Daten hat für den Betreiber der Barfbook-App höchste Priorität."),
                TextSpan(
                    text:
                        "\n3.2. Der Nutzer erklärt sich damit einverstanden, dass seine personenbezogenen Daten für die Nutzung der App gespeichert und verarbeitet werden."),
                TextSpan(
                    text:
                        "\n3.3. Der Nutzer kann seine Einwilligung jederzeit widerrufen und hat das Recht auf Auskunft, Berichtigung, Sperrung oder Löschung seiner personenbezogenen Daten."),
                TextSpan(text: "\n\n4. Geistiges Eigentum"),
                TextSpan(
                    text:
                        "\n4.1. Die Inhalte der Barfbook-App (insbesondere Texte, Bilder, Grafiken, Videos, Software) sind urheberrechtlich geschützt."),
                TextSpan(
                    text:
                        "\n4.2. Die Nutzung der Inhalte der Barfbook-App für kommerzielle Zwecke bedarf der ausdrücklichen schriftlichen Genehmigung des Betreibers der App."),
                TextSpan(
                    text:
                        "\n4.3. Der Nutzer ist nicht berechtigt, die Inhalte der Barfbook-App ohne ausdrückliche schriftliche Genehmigung des Betreibers der App zu verändern, zu kopieren oder weiterzugeben."),
                TextSpan(text: "\n\n5. Zahlungsbedingungen"),
                TextSpan(text: "\n5.1. Die Barfbook-App ist kostenlos."),
                TextSpan(
                    text:
                        "\n5.2. Die Nutzung von Zusatzfunktionen kann kostenpflichtig sein."),
                TextSpan(
                    text:
                        "\n5.3. Die Zahlung erfolgt über den App Store oder den Google Play Store und richtet sich nach den jeweiligen Zahlungsbedingungen."),
                TextSpan(text: "\n\n6. Kündigung und Änderungen"),
                TextSpan(
                    text:
                        "\n6.1. Der Nutzer kann die Nutzung der Barfbook-App jederzeit ohne Angabe von Gründen beenden."),
                TextSpan(
                    text:
                        "\n6.2. Der Betreiber der App behält sich das Recht vor, die AGB jederzeit ohne Vorankündigung zu ändern."),
                TextSpan(
                    text:
                        "\n6.3. Der Betreiber der App behält sich das Recht vor, die Barfbook-App jederzeit ohne Vorankündigung zu ändern, beenden oder einzustellen."),
                TextSpan(text: "\n\n7. Schlussbestimmungen"),
                TextSpan(
                    text: "\n7.1. Diese AGB unterliegen dem deutschen Recht."),
                TextSpan(
                    text:
                        "\n7.2. Sollten einzelne Bestimmungen dieser AGB unwirksam sein oder werden, berührt dies nicht die Wirksamkeit der übrigen Bestimmungen."),
                TextSpan(
                    text:
                        "\n7.3. Gerichtsstand ist der Sitz des Betreibers der Barfbook-App."),
                TextSpan(text: "\n\nStand: 14.04.2023"),
                // TextSpan(text: ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

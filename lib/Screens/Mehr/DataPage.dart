import 'package:flutter/material.dart';

class DataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Datenschutzerklärung",
        style: TextStyle(fontSize: 18),
      )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Text.rich(TextSpan(
              text: 'Datenschutzerklärung für Barfbook\n\n',
              children: [
                TextSpan(text: "1. Verantwortlicher"),
                TextSpan(
                    text:
                        '\nVerantwortlicher im Sinne der DSGVO für die Verarbeitung personenbezogener Daten im Rahmen der Nutzung der "Barfbook"-App ist Tung Nguyen.'),
                TextSpan(text: "\n\n2. Datenverarbeitung"),
                TextSpan(
                    text:
                        '\n2.1. Art der verarbeiteten Daten: Bei der Nutzung der "Barfbook"-App werden folgende personenbezogene Daten verarbeitet:'),
                TextSpan(text: '\n   • Name und E-Mail-Adresse des Nutzers'),
                TextSpan(text: '\n   • Informationen über den Hund'),
                TextSpan(text: '\n   • Nutzungshistorie der App'),
                TextSpan(
                    text:
                        '\n2.2. Zweck der Datenverarbeitung: Die personenbezogenen Daten werden ausschließlich für die Zwecke der Nutzung der "Barfbook"-App verarbeitet, insbesondere um dem Nutzer die Funktionen der App zur Unterstützung bei der Barf-Fütterung zur Verfügung zu stellen.'),
                TextSpan(
                    text:
                        '\n2.3. Rechtsgrundlage für die Datenverarbeitung: Die Rechtsgrundlage für die Verarbeitung der personenbezogenen Daten des Nutzers ist Art. 6 Abs. 1 lit. b DSGVO, da die Verarbeitung für die Erfüllung des Vertrages, den der Nutzer mit dem Verantwortlichen abschließt, erforderlich ist.'),
                TextSpan(
                    text:
                        '\n2.4. Empfänger der Daten: Die personenbezogenen Daten werden ausschließlich für die Zwecke der Nutzung der "Barfbook"-App verwendet und nicht an Dritte weitergegeben, es sei denn, dies ist zur Erfüllung des Vertrages mit dem Nutzer oder zur Erfüllung gesetzlicher Verpflichtungen erforderlich.'),
                TextSpan(
                    text:
                        '\n2.5. Dauer der Datenspeicherung: Die personenbezogenen Daten des Nutzers werden für die Dauer der Vertragsbeziehung zwischen dem Nutzer und dem Verantwortlichen gespeichert. Nach Beendigung der Vertragsbeziehung werden die Daten gelöscht, es sei denn, es bestehen gesetzliche Aufbewahrungspflichten oder der Nutzer hat in die weitere Verarbeitung seiner Daten eingewilligt.'),
                TextSpan(text: "\n\n3. Rechte der betroffenen Person"),
                TextSpan(
                    text:
                        "\n3.1. Der Nutzer hat das Recht auf Auskunft über die von ihm gespeicherten personenbezogenen Daten sowie auf Berichtigung, Löschung, Einschränkung der Verarbeitung und Übertragung seiner Daten gemäß den Artikeln 15-20 DSGVO."),
                TextSpan(
                    text:
                        "\n3.2. Der Nutzer hat das Recht, jederzeit seine Einwilligung zur Verarbeitung seiner personenbezogenen Daten zu widerrufen. Der Widerruf der Einwilligung berührt nicht die Rechtmäßigkeit der bis zum Widerruf erfolgten Verarbeitung."),
                TextSpan(
                    text:
                        "\n3.3. Der Nutzer hat das Recht, sich bei der zuständigen Aufsichtsbehörde zu beschweren, wenn er der Ansicht ist, dass die Verarbeitung seiner personenbezogenen Daten gegen die DSGVO verstößt."),
                TextSpan(text: "\n\n4. Datensicherheit"),
                TextSpan(
                    text:
                        '\nDer Verantwortliche hat angemessene technische und organisatorische Maßnahmen ergriffen, um einen angemessenen Schutz der personenbezogenen Daten des Nutzers sicherzustellen. Die "Barfbook"-App wird auf sicheren Servern betrieben und der Zugriff auf die Daten erfolgt nur durch autorisierte Personen, die zur Vertraulichkeit verpflichtet sind.'),
                TextSpan(text: "\n\n5. Cookies"),
                TextSpan(text: '\nDie "Barfbook"-App verwendet keine Cookies.'),
                TextSpan(text: "\n\n6. Änderungen der Datenschutzerklärung"),
                TextSpan(
                    text:
                        '\nDer Verantwortliche behält sich das Recht vor, diese Datenschutzerklärung jederzeit zu ändern oder zu aktualisieren. Die jeweils aktuelle Fassung ist auf der Webseite der "Barfbook"-App abrufbar. Der Nutzer wird über Änderungen der Datenschutzerklärung per E-Mail informiert.'),
                TextSpan(text: "\n\n7. Kontakt"),
                TextSpan(
                    text:
                        '\nBei Fragen zur Verarbeitung personenbezogener Daten im Rahmen der Nutzung der "Barfbook"-App oder zur Ausübung seiner Rechte gemäß den Artikeln 15-20 DSGVO kann sich der Nutzer an den Verantwortlichen wenden'),
                TextSpan(text: "\n\nStand: 17.04.2023"),
                // TextSpan(text: ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

# README für Exchange Berechtigungsmanagement-Skript

## Beschreibung
Dieses PowerShell-Skript wurde entwickelt, um Berechtigungen für geteilte Postfächer (Shared Mailboxes) in einer Exchange Online-Umgebung zu verwalten. Es listet alle geteilten Postfächer auf, entfernt SendAs-Berechtigungen und fügt SendOnBehalf-Berechtigungen hinzu, basierend auf den aktuellen Berechtigungseinstellungen der Postfächer.

## Voraussetzungen
- PowerShell 5.1 oder höher
- Exchange Online PowerShell Modul (EXO V2 Modul) muss installiert sein
- Administrative Berechtigungen in Ihrer Exchange Online Umgebung
- Log-Verzeichnis (`C:\ExchangeLogs`) muss zugänglich und beschreibbar sein

## Installation
1. Stellen Sie sicher, dass das Exchange Online PowerShell Modul auf Ihrem System installiert ist. Dies kann über den PowerShell-Befehl `Install-Module -Name ExchangeOnlineManagement` erfolgen.
2. Kopieren Sie das Skript in ein Verzeichnis auf Ihrem Computer.

## Nutzung
1. Öffnen Sie PowerShell als Administrator.
2. Navigieren Sie zum Verzeichnis, in dem das Skript gespeichert ist.
3. Führen Sie das Skript aus mit dem Befehl: `.\application-v3.ps1`
4. Das Skript wird automatisch eine Verbindung zu Exchange Online herstellen und nach Ihrer Zustimmung verlangen. Geben Sie Ihre Anmeldedaten ein, wenn Sie dazu aufgefordert werden.
5. Überwachen Sie die Ausführung und die Logausgaben auf der Konsole und in der Log-Datei `C:\ExchangeLogs\SharedMailboxPermissions.log`.

## Funktionen des Skripts
- **Verbindungsherstellung zu Exchange Online:** Das Skript stellt eine Verbindung zu Exchange Online her, um Berechtigungen für geteilte Postfächer zu verwalten.
- **Auflistung von Shared Mailboxes:** Das Skript listet alle Shared Mailboxes oder nur solche, deren Alias mit "test" beginnt, je nach auskommentierter Zeile.
- **Log-Datei:** Alle wichtigen Aktionen und Fehler werden in einer Log-Datei gespeichert.
- **Management von Berechtigungen:** Für jede Shared Mailbox werden SendAs-Berechtigungen entfernt und SendOnBehalf-Berechtigungen hinzugefügt.
- **Fehlerbehandlung:** Das Skript erfasst Fehler bei der Verwaltung der Berechtigungen und loggt diese.

## Logik des Skripts
Das Skript führt folgende Schritte aus:
1. Erstellung eines Log-Verzeichnisses und einer Log-Datei.
2. Verbindung zu Exchange Online.
3. Durchlaufen aller oder spezifisch gefilterter Shared Mailboxes.
4. Entfernen von SendAs-Berechtigungen und Hinzufügen von SendOnBehalf-Berechtigungen.
5. Protokollieren aller Aktionen und Fehler.
6. Trennen der Verbindung zu Exchange Online und Abschluss des Skripts.

Für weitere Unterstützung oder bei Problemen kontaktieren Sie bitte Ihren Systemadministrator oder die Person, die dieses Skript bereitgestellt hat.

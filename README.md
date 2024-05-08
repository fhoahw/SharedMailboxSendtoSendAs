README für Exchange Berechtigungsmanagement-Skript
Beschreibung
Dieses PowerShell-Skript wurde entwickelt, um Berechtigungen für geteilte Postfächer (Shared Mailboxes) in einer Exchange Online-Umgebung zu verwalten. Es listet alle geteilten Postfächer auf, entfernt SendAs-Berechtigungen und fügt SendOnBehalf-Berechtigungen hinzu, basierend auf den aktuellen Berechtigungseinstellungen der Postfächer.

Voraussetzungen
PowerShell 5.1 oder höher
Exchange Online PowerShell Modul (EXO V2 Modul) muss installiert sein
Administrative Berechtigungen in Ihrer Exchange Online Umgebung
Log-Verzeichnis (C:\ExchangeLogs) muss zugänglich und beschreibbar sein
Installation
Stellen Sie sicher, dass das Exchange Online PowerShell Modul auf Ihrem System installiert ist. Dies kann über den PowerShell-Befehl Install-Module -Name ExchangeOnlineManagement erfolgen.
Kopieren Sie das Skript in ein Verzeichnis auf Ihrem Computer.
Nutzung
Öffnen Sie PowerShell als Administrator.
Navigieren Sie zum Verzeichnis, in dem das Skript gespeichert ist.
Führen Sie das Skript aus mit dem Befehl: .\NameDesSkripts.ps1
Das Skript wird automatisch eine Verbindung zu Exchange Online herstellen und nach Ihrer Zustimmung verlangen. Geben Sie Ihre Anmeldedaten ein, wenn Sie dazu aufgefordert werden.
Überwachen Sie die Ausführung und die Logausgaben auf der Konsole und in der Log-Datei C:\ExchangeLogs\SharedMailboxPermissions.log.
Funktionen des Skripts
Verbindungsherstellung zu Exchange Online: Das Skript stellt eine Verbindung zu Exchange Online her, um Berechtigungen für geteilte Postfächer zu verwalten.
Auflistung von Shared Mailboxes: Das Skript listet alle Shared Mailboxes oder nur solche, deren Alias mit "test" beginnt, je nach auskommentierter Zeile.
Log-Datei: Alle wichtigen Aktionen und Fehler werden in einer Log-Datei gespeichert.
Management von Berechtigungen: Für jede Shared Mailbox werden SendAs-Berechtigungen entfernt und SendOnBehalf-Berechtigungen hinzugefügt.
Fehlerbehandlung: Das Skript erfasst Fehler bei der Verwaltung der Berechtigungen und loggt diese.
Logik des Skripts
Das Skript führt folgende Schritte aus:

Erstellung eines Log-Verzeichnisses und einer Log-Datei.
Verbindung zu Exchange Online.
Durchlaufen aller oder spezifisch gefilterter Shared Mailboxes.
Entfernen von SendAs-Berechtigungen und Hinzufügen von SendOnBehalf-Berechtigungen.
Protokollieren aller Aktionen und Fehler.
Trennen der Verbindung zu Exchange Online und Abschluss des Skripts.
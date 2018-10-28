# WNT Scripts
Miscellaneous scripts for Windows management/deployment.

## Script list:
#### SafeSVC
Script for secure Windows configuration and deployment. Disables unsafe services, features & tasks. Reduces telemetry, turns off *ContentDeliveryManager* and *ConsumerFeatures* and provides many miscellaneous tweaks. Can disable *Ease of Use* – user consent required.

#### Duster
Script providing a proper way of cleaning Windows. More info here: https://guide.mople71.cz/cs/wnt/duster.php

#### WMISalvage
Rebuilds WMI repository by purging it and recreating it again. **WARNING: don't use unless you know what you're doing!**

#### SFClog
Initiates a System File Checkes scan and creates a log of found errors for review. Usually used when remotely helping someone with system corruption.

#### DISMResetBase
Cleans WinSxS folder and resets OS base by executing a simple command.

#### LogsDel
Purges all system logs.

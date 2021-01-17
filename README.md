# tmamc
Tell me about my cPanel Server

Author: ANDRIAMILAMINA Monge (overwatch@confluenti.com)

Is a script to run on your cPanel enabled server to get all the statistics about all accounts, domain name, email, databases.
it was written for French user, but could quickly re-written to output results in english or other languages.

Usages:

1/ /bin/bash tmamc EN   # get result in english  
2/ /bin/bash tmamc en   # get result in english  
3/ /bin/bash tmamc FR   # get result in french  
4/ /bin/bash tmamc fr   # get result in french  


Sample output:

############ Serveur ########## 
Nom: my.server.com
Disque: 356G
RAM: 4.8G
IP: XX.YY.XXX.X
###############################
1/ Compte Cpanel: mikejagger
2/ Domaine: mikejagger.eu
3/ Nombre de boîte mail: 06
4/ Tailles des boîtes emails:
   - monge@mikejagger.eu:  188K
   - mng@mikejagger.eu:  240K
   - m.ng@mikejagger.eu:  260K
   - me.mg@mikejagger.eu:  352K
   - contact@mikejagger.eu:  452K
   - fakenews@mikejagger.eu:  660K

5/ Taille globale du dossier de site: 752M
6/ Taille totale du dossier du compte Cpanel: 1,7G
7/ Nombre de bases de données: 1
8/ Tailles de la ou des bases:
   - mikejagger_WP:   12M
   
-------------------------------

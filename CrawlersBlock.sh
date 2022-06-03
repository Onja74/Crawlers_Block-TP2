# Bloquer les crawlers sur APACHE 2
#!/bin/bash

#Il faut mettre en backup les données d'access_log
cp --backup /var/log/apache2/access.log

#Il faut verifier chaque log qui utilise des crons
cd /var/log/apache2/
cat access.log
do crontab -l; 
#Recuperer tous les adresses clients renvoyant 404(qui ont rencontré des scrawlers)
do
#Il faut entrer le Script du bloquage de scrawlers suivant
 awk '($9 ~ /404/)' /var/log/apache2/access.log | awk '{print $9,$7}' | sort | sed -n '/404$/p'|\ awk '{print $1} |tail -f |iptables -A INPUT -s $1 -j DROP  ;
done'

#Il faut donner ensuite les droits sur les scripts
 chmod +x blocking.sh

#Puis de l'executer
./blocking.sh

#et c'est terminé
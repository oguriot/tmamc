#!/bin/bash
# get language via argument
LANG="$1"

# default strings variables to french
S_STRING_1="Nom"
S_STRING_2="Disque"
S_STRING_3="RAM"
S_STRING_4="IP"
S_STRING_5="Compte Cpanel"
S_STRING_6="Domaine"
S_STRING_7="Nombre de boîte mail"
S_STRING_8="Tailles des boîtes emails"
S_STRING_9="Taille globale du dossier de site"
S_STRING_10="Taille totale du dossier du compte Cpanel"
S_STRING_11="Nombre de bases de données"
S_STRING_12="Tailles de la ou des bases"

# if FR or fr is supplied, show result in french
if [[ $LANG = "FR" || $1 = "fr" ]]; then
	S_STRING_0="Serveur"
	S_STRING_1="Nom"
	S_STRING_2="Disque"
	S_STRING_3="RAM"
	S_STRING_4="IP"
	S_STRING_5="Compte Cpanel"
	S_STRING_6="Domaine"
	S_STRING_7="Nombre de boîte mail"
	S_STRING_8="Tailles des boîtes emails"
	S_STRING_9="Taille globale du dossier de site"
	S_STRING_10="Taille totale du dossier du compte Cpanel"
	S_STRING_11="Nombre de bases de données"
	S_STRING_12="Tailles de la ou des bases"

# if EN or en is supplied, show result in english
elif [[ $LANG = "EN" || $1 = "en" ]]; then
	S_STRING_0="Server"
	S_STRING_1="Name"
	S_STRING_2="Disc"
	S_STRING_3="RAM"
	S_STRING_4="IP"
	S_STRING_5="Cpanel account"
	S_STRING_6="Domain"
	S_STRING_7="Maibox(es)"
	S_STRING_8="Mailbox(es) size"
	S_STRING_9="Website folder size"
	S_STRING_10="cPanel account total size"
	S_STRING_11="Database(s)"
	S_STRING_12="Size of database(s)"

# if nothing is supplied, default to english
elif [ $# = 0 ]; then
	S_STRING_0="Server"
	S_STRING_1="Name"
	S_STRING_2="Disc"
	S_STRING_3="RAM"
	S_STRING_4="IP"
	S_STRING_5="Cpanel account"
	S_STRING_6="Domain"
	S_STRING_7="Maibox(es)"
	S_STRING_8="Mailbox(es) size"
	S_STRING_9="Website folder size"
	S_STRING_10="cPanel account total size"
	S_STRING_11="Database(s)"
	S_STRING_12="Size of database(s)"
fi

echo "############ $S_STRING_0 ##########"
echo "$S_STRING_1: $(hostname -f)"
echo "$S_STRING_2: $(df -h | egrep -w / | awk '{print $2}')"
echo "$S_STRING_3: $(free -h | egrep Mem | awk '{print $2}')"
echo "$S_STRING_4: $(ip addr ls | egrep "global" | tail -n1 | awk '{print $2}')"
echo "###############################"
cat /etc/userdomains | sed 's/://g'| column -t | while read VDOMAIN VUSER;
do
	if [[ ! -d /home/$VUSER/mail/$VDOMAIN ]]
	then
		echo "1/ $S_STRING_5: $VUSER"
		echo "2/ $S_STRING_6: $VDOMAIN"
		echo "3/ $S_STRING_7: 0"
		echo "4/ $S_STRING_8: 0Mo"		
		echo "5/ $S_STRING_9: $(du -sh /home/$VUSER/public_html | awk '{print $1}')"
		echo "6/ $S_STRING_10: $(du -sh /home/$VUSER | awk '{print $1}')"
		ls -1 /var/lib/mysql | egrep $VUSER > /dev/null
		if [ $? -eq 0 ]
		then
			echo "7/ $S_STRING_11: $(ls -1 /var/lib/mysql | egrep $VUSER | wc -l)"
			echo "8/ $S_STRING_12:"
			ls -1 /var/lib/mysql | egrep $VUSER | while read VBASE;
			do
				du -sh /var/lib/mysql/$VBASE | sort -h | awk '{print $2 "\t" $1}' | while read VPATHBDD VSIZEBDD;
				do
					VUSERDB=$(echo $VPATHBDD | awk -F/ '{print $NF}')
					echo "   - $VUSERDB:   $VSIZEBDD"
				done
			done
		else
			echo "7/ $S_STRING_11: 0"
		fi
		echo "-------------------------------"
	else
		if [ "$(ls -A /home/$VUSER/mail/$VDOMAIN)" ]
		then
			echo "1/ $S_STRING_5: $VUSER"
			echo "2/ $S_STRING_6: $VDOMAIN"
			echo "3/ $S_STRING_7: $(ls -1 /home/$VUSER/mail/$VDOMAIN/ | wc -l)"
			echo "4/ $S_STRING_8:"
			du -sh /home/$VUSER/mail/$VDOMAIN/* | sort -h |	awk '{print $2 "\t" $1}' | while read VPATH VSIZE;
			do
				VUSEREMAIL=$(echo $VPATH | awk -F/ '{print $NF}')
				echo "   - $VUSEREMAIL@$VDOMAIN:  $VSIZE"
			done
			
			echo ""
			
			echo "5/ $S_STRING_9: $(du -sh /home/$VUSER/public_html | awk '{print $1}')"
			echo "6/ $S_STRING_10: $(du -sh /home/$VUSER | awk '{print $1}')"
			ls -1 /var/lib/mysql | egrep $VUSER > /dev/null
			if [ $? -eq 0 ]
			then
				echo "7/ $S_STRING_11: $(ls -1 /var/lib/mysql | egrep $VUSER | wc -l)"
				echo "8/ $S_STRING_12:"
				ls -1 /var/lib/mysql | egrep $VUSER | while read VBASE;
				do
					du -sh /var/lib/mysql/$VBASE | sort -h | awk '{print $2 "\t" $1}' | while read VPATHBDD VSIZEBDD;
					do
						VUSERDB=$(echo $VPATHBDD | awk -F/ '{print $NF}')
						echo "   - $VUSERDB:   $VSIZEBDD"
					done
				done
			else
				echo "7/ $S_STRING_11: 0"
			fi
			echo "-------------------------------"
		fi
	fi
done

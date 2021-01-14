cat /etc/userdomains | sed 's/://g'| column -t | while read VDOMAIN VUSER;
do
	if [[ ! -d /home/$VUSER/mail/$VDOMAIN ]]
	then
		:
	else
		if [ "$(ls -A /home/$VUSER/mail/$VDOMAIN)" ]
		then
			echo "1/ Compte Cpanel: $VUSER"
			echo "2/ Domaine: $VDOMAIN"
			echo "3/ Nombre de boîte mail: $(ls -1 /home/$VUSER/mail/$VDOMAIN/ | wc -l)"
			echo "4/ Tailles des boîtes emails:"
			du -sh /home/$VUSER/mail/$VDOMAIN/* | sort -h |	awk '{print $2 "\t" $1}' | while read VPATH VSIZE;
			do
				VUSEREMAIL=$(echo $VPATH | awk -F/ '{print $NF}')
				echo "   - $VUSEREMAIL@$VDOMAIN:  $VSIZE"
			done
			
			echo ""
			
			echo "5/ Taille globale du dossier de site: $(du -sh /home/$VUSER/public_html | awk '{print $1}')"
			echo "6/ Taille totale du dossier du compte Cpanel: $(du -sh /home/$VUSER | awk '{print $1}')"
			ls -1 /var/lib/mysql | egrep $VUSER > /dev/null
			if [ $? -eq 0 ]
			then
				echo "7/ Nombre de bases de données: $(ls -1 /var/lib/mysql | egrep $VUSER | wc -l)"
				echo "8/ Tailles de la ou des bases:"
				ls -1 /var/lib/mysql | egrep $VUSER | while read VBASE;
				do
					du -sh /var/lib/mysql/$VBASE | sort -h | awk '{print $2 "\t" $1}' | while read VPATHBDD VSIZEBDD;
					do
						VUSERDB=$(echo $VPATHBDD | awk -F/ '{print $NF}')
						echo "   - $VUSERDB:   $VSIZEBDD"
					done
				done
			else
				echo "7/ Nombre de bases de données: 0"
			fi
			echo "-------------------------------"
		else
			:
		fi
	fi
done


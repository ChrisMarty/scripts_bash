#!/bin/bash

#################################################################################################
#												#
# type the commande : ./langstat.sh dico.txt -help  (for use help of this script)		#
# tappez la commande : ./langstat.sh dico.txt -help (pour utiliser l'aide de se script)		#
#												#
#################################################################################################

# Vide la console
clear

# Tableau contenant l'alphabet
alphabet=('A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z')

# Nom du fichier temporaire
temp="temp"

# Vérification de l'existance de dico.txt en premier paramètre
if [ -z $1 ] || [ $1 != "dico.txt" ]; then
	echo "Le premier paramètre doit être 'dico.txt'"
else
	# Vérification que le fichier dico.txt existe 
	if [ -f $1 ] && [ -e $1 ]
	then
		# Supprime le fichier temporaire si il existe
		if [ -f $temp ] && [ -e $temp ]
		then
			rm $temp
		fi
		# Boucle pour passer toutes les lettres de l'alphabet
		for lettre in ${alphabet[*]}
		do
			# Retourne le nombre de mot utilisant la lettre de l'alphabet dans un fichier temporaire
			val=`grep $lettre $1 | wc -l`
			echo "$val - $lettre" >> $temp
		done
		# Retourne le nombre de mots utilisant chaque lettre (de la lettre la plus utilisée à la moins utilisée si pas de paramètre)
		if [ -z $2 ]; then			 
			echo "Retourne le nombre de mots utilisant chaque lettre (de la plus utilisée à la moins utilisée) :"
			sort -nr $temp
		else
			case $2 in
				# Si le paramètre "-r" ou "-reverse" (de à la moins utilisée à la plus utilisée)
			  	"-r" | "-reverse")
					echo "Retourne le nombre de mots utilisant chaque lettre (de la moins utilisée à la plus utilisée) :"
					sort -n $temp
				;;
				# Retourne dans combien de mot la lettre passée en paramètre exite
				"-a" | "-letter_alpha")
					# vérifie que le 3eme paramètre existe
					if [ -z $3 ]; then
						clear
						echo "Pour l'option [$2] il manque en 3ème paramètre, une lettre !"
					else
						clear
						# Vérifie que le 3eme paramètre ne contient qu'une seule lettre
						cmd=`echo $3 | wc -c`
						let "test = $cmd - 1"
						if [ $test -gt 1 ]; then
							echo "Il faut saisir une seule lettre avec l'option [$2], actuellement : $test !"
						else
							# Retourne le résultat pour la lettre
							l=`echo $3 | tr '[:lower:]' '[:upper:]'`
							echo "Dans combien de mot la lettre [$l] existe :"
							grep -i $3 $temp
						fi
					fi
				;;
				# Retourne la liste de 'dico.txt'
				"-l" | "-list")
					clear
					echo "Liste des mots de 'dico.txt :"
					cat dico.txt
				;;
				# Retourne le nombre de mot de 'dico.txt'
				"-c" | "-count")
					clear
					echo "Nombre de mot de 'dico.txt' :"
					wc -w dico.txt
				;;
				# Si le paramètre "-h" ou "-help" (aide sur la commande)
				"-h" | "-help")
					while [ -z $sortie ] || [ $sortie != "q" ]
					do
						clear
						echo -e "NAME : \n\tlangstat.sh : Retourne le nombre de mots utilisant chaque lettre de l'alphabet\n"
						echo -e "SYNOPSIS : \n\t./langstat.sh dico.txt [OPTION]"
						echo -e "\t./langstat.sh dico.txt [-letter_alpha A-Z]\n"
						echo -e "DESCRIPTION : \n\tliste des options :\n"
						echo -e "\t\t-r, -reverse : \t\tinverse le résultat, de la lettre la moins utilisée à la plus utilisée"
						echo -e "\t\t\t\t\t(reverse result)\n"
						echo -e "\t\t-a, -letter_alpha : \tpermet de passer la lettre pour lequel on veut savoir le nombre de mot ou elle est utilisée"
						echo -e "\t\t\t\t\t(choose letter for result)\n"
						echo -e "\t\t-l, -list : \t\tpermet de voir la liste de mot"
						echo -e "\t\t\t\t\t(list word in 'dico.txt')\n"
						echo -e "\t\t-c, -count : \t\tnombre de mot de 'dico.txt'"
						echo -e "\t\t\t\t\t(word count in 'dico.txt')\n"
						echo -e "\t\t-h, -help : \t\taide de la commande"
						echo -e "\t\t\t\t\t(command help)\n"
						read -p 'Tapez [q] pour sortir : ' -n 1 sortie
					done
					clear
				;;
				# Si toutes autres options, message d'erreur
				*)
					echo "L'option [$2] n'existe pas !"
				;;
			esac
		fi
	else
		echo "le fichier dico.txt n'existe pas !"
	fi
fi
# Suppression des fichiers temporaires
if [ -f $temp ] && [ -e $temp ]; then
	rm $temp
fi

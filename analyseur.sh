#!/bin/bash
dico='/usr/share/wordlists/rockyou.txt'
output='resultanalyse.txt'
num_options=0
showHelp=false
mot=false
classement=false
#help
usage="./analyseur.sh [ -h|m|c ] [ lettre ou mot ]"
if [ $# -eq 0 ]
then	
  echo "ERROR : No Arguments"	
  echo $usage	
  exit
else	
  while getopts 'hmc' OPTION	
    do		
    ((num_options+=1))		
      case $OPTION in			
        h) showHelp=true;;			
        m) mot=true;;			
        c) classement=true;;			
        ?) showHelp=true;;		
      esac	
    done	
  shift $(($OPTIND - 1))
  fi
  if [ $mot = true ]
  then
    read -p "entrez un mot ou une lettre à tester " lettroumot	
    let nbresult=`grep -c "$lettroumot" $dico`	
    if [ $nbresult -lt 50 ]	
    then		
      echo "nb results : $nbresult "			
      echo `grep $lettroumot $dico`	
    else		
      echo "nb results : "`grep -c "$lettroumot" $dico `	
    fi
  elif [ $classement = true ]
  then	
    tabalpha=('a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z')	
    echo '' > classement.txt	
    for lettre in ${tabalpha[*]}	
    do		
      nombrelettre=`grep -c "$lettre" $dico`		 
      echo "$lettre:$nombrelettre" >> classement.txt                 
      echo -e '\n' >> classement.txt		
      #`echo "$lettre," >> classement.txt`		
      #`grep -c "$lettre" $dico >> classement.txt`			
    done	
    echo `sort -t: -k 2 -nr classement.txt`	
    #echo `cut -d , -f 2 classement.txt >> classementfinal | sort -n classementfinal`	
    #echo `cat classement.txt`
  else	
    echo $usage	
    exit
  fi

#!/bin/bash

	####################
	#   MADE BY GABY   #
	####################

export NCURSES_NO_UTF8_ACS=1

####### FONCTION TO ITERATE THE LINUX USERS #######

function searchUser () {
    /bin/grep -i $1 /etc/passwd
    if [ $? -ne "0" ];then
        echo -e "\e[1;31m You entered an invalid username : $1 doesn't exist \e[0m"
        return 1
    else
        return 0
    fi
}


####### FIRSTQUESTION #######

HEIGHT=15
WIDTH=40
FIRSTQUESTION_HEIGHT=4
BACKTITLE="EASYLIA"
TITLE="EASYLIA - Users Management"
#MENU="Choose one of the following options:"

OPTIONS=(1 "ADD A USER"
         2 "DELETE A USER"
         3 "MODIFY A USER"
 	 4 "EXIT")

FIRSTQUESTION=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $FIRSTQUESTION_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear

case $FIRSTQUESTION in

    1)
        echo -e "\e[1;36m You chose to add a new user \e[0m"

        read -p "Enter the group : " group
        while [ -z "$group" ];do
            read -p "Enter the group : " group
        done

        read -p "Enter the lastname : " lastname
        while [ -z "$lastname" ];do
            read -p "Enter the lastname : " lastname
        done

        read -p "Enter the firstname : " firstname
        while [ -z "$firstname" ];do
            read -p "Enter the firstname : " firstname
        done

        read -p "Enter his code : " code
        while [ -z "$code" ];do
            read -p "Enter the code : " code
        done

        #Username created by Easylia
        username=${firstname:0:1}$lastname

        printf "\n$group : $lastname : $firstname : $code\n" #debug line

        #group1="students"
        #group2="teachers"

        while [ "$group" != "students" ] && [ "$group" != "teachers" ]
        do
            #echo -e "\e[0;31m  \nChoose a good group like : 'students' 'teachers'\n \e[0m"
            read -p "Enter a valid group like indicated above : " group
        done

        /bin/grep -i $group /etc/group
        if [ $? -ne "0" ];then
            /usr/sbin/addgroup --force-badname $group >/dev/null
            #echo "Group well created"
        fi
        #echo "ALL seems to be ok, we gonna add the new user."

        /usr/sbin/useradd $username -s /bin/false -g $group -c "$last_name $first_name" >/dev/null
        /bin/echo $username:$code | /usr/sbin/chpasswd

        echo -e "\e[1;32m  \nL'utilisateur $username a bien été créé !\n  \e[0m"
        ;;
    2)
        echo -e "\e[1;34m  You chose to delete a user  \e[0m"
        read -p "Which user want you to delete ? : put his username " user_trash
        /usr/sbin/userdel $user_trash

        if [ $? -eq "6" ];then
            echo -e "\e[0;31m  \nEnter a valid username, of an existing user :\n  \e[0m "
            read -p "Enter a valid username please : " user_trash
            /usr/sbin/userdel $user_trash
            if [ $? -eq "6" ];then
                echo -e "\e[1;31m  \nYou chose an invalid username. Try again\n  \e[0m"
            fi
        else
            echo -e "\e[1;32m  \nThe deletion well worked ! $user_trash is now deleted.\n  \e[0m"
        fi
        ;;
    3)
        echo -e "\e[1;34m  You chose to modify a user \e[0m"
        read -p "Which user want you to modify ? : put his username " user_to_update
        usr="$user_to_update"
        searchUser "$user_to_update"
        while [ $? -ne "0" ];do
            read -p "Please enter a valid username : " user_to_update
            searchUser "$user_to_update"
        done
        echo "okokok"
        echo "$usr"
        /usr/sbin/userdel $usr

        echo -e "\e[1;36m You chose to modify a user \e[0m"

        read -p "Rappelez le groupe de l'utilisateur : " group
        while [ -z "$group" ];do
            read -p "Enter the group : " group
        done

        read -p "Enter the new lastname : " lastname
        while [ -z "$lastname" ];do
            read -p "Enter the lastname : " lastname
        done

        read -p "Enter the new firstname : " firstname
        while [ -z "$firstname" ];do
            read -p "Enter the firstname : " firstname
        done

        read -p "Enter his code : " code
        while [ -z "$code" ];do
            read -p "Enter the code : " code
        done

        #Username created by Easylia
        username=${firstname:0:1}$lastname
        echo "The identifiant:photocop will be : $username "

        while [ "$group" != "students" ] && [ "$group" != "teachers" ]
        do
            #echo -e "\e[0;31m  \nChoose a good group like : 'students' 'teachers'\n \e[0m"
            read -p "Enter a valid group like indicated above : " group
        done

        /bin/grep -i $group /etc/group
        if [ $? -ne "0" ];then
            /usr/sbin/addgroup --force-badname $group >/dev/null
            #echo "Group well created"
        fi
        #echo "ALL seems to be ok, we gonna add the new user."

        /usr/sbin/useradd $username -s /bin/false -g $group -c "$last_name $first_name" >/dev/null
        /bin/echo $username:$code | /usr/sbin/chpasswd

        echo -e "\e[1;32m  \nL'utilisateur $username a bien été modifiée avec les nouvelles informations !\n  \e[0m"

        ;;
    4)
        echo -e "\e[1;34m  You chose to exit and stop the script :(  \e[0m"
        ;;
esac

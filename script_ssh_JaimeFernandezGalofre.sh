#!/bin/bash
cd /etc/ssh
while :
do      
        echo "****************************************"
        echo "****************************************"
        echo "****************************************"
        echo "**********Que quieres realizar**********"
        echo "1) Cambiar el puerto"
        echo "2) Cambiar el rango de ip que lo puedan escuchar"
        echo "3) Hacer que no se pueda entrar por el root"
        echo "4) Cambiar la cantidad de segundos en que la pantalla de login estará disponible"
        echo "5) Cambiar la cantidad de veces que podemos equivocarnos en ingresar el usuario y/o contraseña"
        echo "6) Cambiar la cantidad de login simultaneos"
        echo "0) Salir"
        echo "**********Que quieres hacer?************"
        read opc

    case $opc in
        1)
            echo "Dime por que puerto lo quieres cambiar, o si escribes # podras volver al modo que estaba en predeterminado : "
            read numPort

            if [[ $numPort =~ ^-?[0-9]+([.][0-9]+)?$ ]]
            then
                sed -i '15 s/.*/Port '"$numPort"'/' sshd_config
                echo "Cambio al puerto $numPort realizado"
            elif [[ $numPort == "#" ]]
            then
                sed -i '15 s/.*/#Port 22/' sshd_config
                echo "Cambiado al modo predeterminado"
            else
                echo "No es ni un numero, ni #"
            fi
            ;;
        2)
            echo "Dime que rango de ip seria: , o se lo podemos desactivar solo escribiendo #"
            read IpPort
            if [[ $IpPort =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
            then
                #echo $IpPort
                sed -i '17 s/.*/ListenAddress '"$IpPort"'/' sshd_config
                echo "Protocolo cambiado"
            elif [[ $IpPort == "#" ]]
            then
                sed -i '17 s/.*/#ListenAddress 0.0.0.0 /' sshd_config
                echo "Volviendo al modo default el rango de ip"
            else
                echo "Tiene que ser una ip o #"
            
            fi
            
            ;;
            3)
                echo "Le vas a denegar el paso(si o no)"
                read result
                if [[ $result == "si" ]]
                then
                    sed -i '34 s/.*/PermitRootLogin no/' sshd_config
                    echo "denegado el paso del root"

                elif [[ $result == "no" ]]
                then
                    sed -i '34 s/.*/#PermitRootLogin prohibit-password/' sshd_config
                    echo "Permitiendo el paso al root"
                else
                echo "Debe de ser o si o no en minusculas"
                fi
            ;;
            4)
                echo "¿segundos o minuto (s o m) o lo quieres predeterminado (#)?"
                read tiempo
                if [[ $tiempo == "s" ]]
                then
                    echo "Cuanto tiempo"
                    read seg
                    sed -i '33 s/.*/LoginGraceTime '"$seg"' /' sshd_config
                    echo "Cambio a $seg segundos"
                elif [[ $tiempo == "m" ]]
                then
                    echo "Cuanto tiempo"
                    read min
                    sed -i '33 s/.*/LoginGraceTime '"$min"'m /' sshd_config
                    echo "Cambio a $min minutos"
                elif [[ $tiempo == "#" ]]
                then
                    sed -i '33 s/.*/#LoginGraceTime 2m /' sshd_config
                    echo "Cambiado al predeterminado"
                else
                echo "Debe de ser m,s o # "
                fi
            ;;
             5)
             echo "Elije cuantos errores son necesarios, o si lo quieres en predeterminado (#)"
              read cant
                if [[ $cant == "#" ]]
                then
                    sed -i '36 s/.*/#MaxAuthTries 6 /' sshd_config
                    echo "Volviendo al predeterminado"
                elif [[ $cant =~ ^-?[0-9]+([.][0-9]+)?$ ]]
                then
                    sed -i '36 s/.*/MaxAuthTries '"$cant"' /' sshd_config
                    echo "Cambio realizado a $cant intentos"
                else
                echo "Tiene que ser o un numero o el #"
                fi
            ;;
            6)
            echo "Dime cuantos pueden entrar o volver al modo predeterminado (#)"
            read numLogs
            if [[ $numLogs =~ ^-?[0-9]+([.][0-9]+)?$ ]]
            then
                sed -i '37 s/.*/MaxSessions '"$numLogs"' /' sshd_config
                echo "Cambiado a $numLogs que podran entrar simultaneamente"
            elif [[ $numLogs == "#" ]]
            then
                sed -i '37 s/.*/#MaxSessions 10 /' sshd_config
                echo "Volviendo al predeterminado"
            else
                echo " debes de escribir un numero o un #"
            fi
            ;;
        *)
            echo "Adios, vuelva pronto"
            break
        ;;
    esac
done




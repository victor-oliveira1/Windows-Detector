#!/usr/bin/env bash
#victor.oliveira@gmx.com

subnet=$1

scan_windows(){
    nmap -Pn -p 445 --open -n -sV -oG - $subnet 2>/dev/null| grep -v ^#| grep 445
}

echo Realizando o primeiro scan
scan1=$(scan_windows)
echo Realizando um segundo scan
scan2=$(scan_windows)

if [ "$scan1" != "$scan2" ]; then
    scan1+=$'\n'
    end=1
    while [ $end -eq 1 ]; do
        end=0
        echo Verificando inconsistências
        while IFS=$'\n' read linha; do
            if ! grep "$linha" <(echo "$scan1") &> /dev/null; then
                scan1+="$linha$'\n'"
                end=1
            fi
        done < <(echo "$scan2")
        if [ $end -eq 1 ]; then
            echo Realizando um novo scan
            scan2=$(scan_windows)
        fi
    done
fi

echo Gravando arquivo
echo "$scan1" > scan.txt
echo Scan concluído

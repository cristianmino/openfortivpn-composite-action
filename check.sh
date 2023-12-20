echo "Checking for openfortivpn..."
if ! command -v openfortivpn &> /dev/null
then
    echo "openfortivpn could not be found"
    exit
fi
# Realiza un bucle desde 1 hasta el cuarto argumento pasado al script
for i in $(seq 1 $4)
do
    # Intenta conectar al host (argumento 1) y puerto (argumento 2) con un tiempo de espera (argumento 3)
    nc -zv -w $3 $1 $2 &> /dev/null
    if [ $? -eq 0 ]
    then
        isConnected=true
        break
    else
        isConnected=false
        sleep $3
    fi
    if [ $isConnected = false ]
    then
        echo "Trying to connect to $5:$6..."
        sudo openfortivpn $5:$6 -u $7 -p $8 --trusted-cert $9 --persistent=5 &
    fi
done
echo "isConnected=$isConnected" >> "$GITHUB_OUTPUT"
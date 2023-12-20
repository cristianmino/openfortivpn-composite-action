# Comprobación de VPN Fortinet

Este proyecto consiste en un script de shell llamado `check.sh` y un composite de GitHub Action definido en `action.yml` que se utiliza para establecer una conexión VPN utilizando Fortinet y luego verificar la conexión a una URL específica que debe estar dentro de la VPN.

## Cómo funciona

El script `check.sh` utiliza el comando `openfortivpn` para establecer una conexión VPN. Una vez establecida la conexión, el script intentará acceder a una URL específica que debe estar dentro de la VPN.

Si la conexión a la URL falla, el script intentará reconectar la VPN utilizando `openfortivpn` y repetirá este proceso tantas veces como se especifique en un parámetro al ejecutar `check.sh`.

El `action.yml` es un composite de GitHub Action que utiliza el script `check.sh` para realizar la comprobación de la VPN. Este composite toma ciertos inputs y produce outputs que pueden ser utilizados en otros pasos de su flujo de trabajo de GitHub Actions.

## Inputs

- `vpn_host`: El host de la VPN.
- `vpn_port`: El puerto de la VPN.
- `vpn_username`: El nombre de usuario para la VPN.
- `vpn_password`: La contraseña para la VPN.
- `vpn_trusted_cert`: El certificado de confianza para la VPN.
- `vpn_persistent`: El número de intentos de reconexión a la VPN.
- `check_url`: La URL a verificar.
- `check_port`: El puerto a verificar.
- `check_sleep`: El tiempo de espera entre verificaciones.
- `check_retries`: El número de reintentos de verificación.

## Outputs

- `isConnected`: El estado de la conexión después de ejecutar el script. Este output puede ser utilizado en otros pasos de su flujo de trabajo de GitHub Actions.

## Uso

```shell
- name: Connect Forti VPN
  id: vpn
  uses: cristianmino/openfortivpn-composite-action@v2
  with:
    vpn_host: ${{ env.VPN_HOST }}
    vpn_port: ${{ env.VPN_PORT }}
    vpn_username: ${{ env.VPN_USERNAME }}
    vpn_password: ${{ secrets.VPN_PASSWORD }}
    vpn_trusted_cert: ${{ env.TRUST_CERT }}
    check_url: ${{ env.VAULT_INTERNAL_ADDR }}
    check_port: ${{ env.VAULT_PORT }}
```

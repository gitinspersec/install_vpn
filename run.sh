#!/bin/bash

# Obtém o diretório do script atual
SCRIPT_DIR=$(dirname "$(realpath "$0")")

echo "Iniciando a instalação do WireGuard..."
# Instala o WireGuard
sudo apt-get install -y wireguard
echo "WireGuard instalado com sucesso."

# Cria o diretório /etc/wireguard se ele não existir
if [ ! -d /etc/wireguard ]; then
    echo "Diretório /etc/wireguard não encontrado. Criando o diretório..."
    sudo mkdir -p /etc/wireguard
    echo "Diretório /etc/wireguard criado."
else
    echo "Diretório /etc/wireguard já existe."
fi

# Verifica se o arquivo já existe e tenta realizar wg-quick down
if [ -f /etc/wireguard/wg-conf-1.conf ]; then
    echo "Arquivo wg-conf-1.conf encontrado em /etc/wireguard."
    echo "Tentando derrubar a interface wg-conf-1..."
    sudo wg-quick down wg-conf-1 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "Interface wg-conf-1 derrubada com sucesso."
    else
        echo "Falha ao derrubar a interface wg-conf-1 ou ela já está inativa."
    fi
    echo "Removendo o arquivo wg-conf-1.conf existente..."
    sudo rm /etc/wireguard/wg-conf-1.conf
    echo "Arquivo existente removido."
else
    echo "Arquivo wg-conf-1.conf não encontrado em /etc/wireguard. Pronto para mover o novo arquivo."
fi

# Move o arquivo do diretório do script para /etc/wireguard
echo "Movendo wg-conf-1.conf do diretório do script ($SCRIPT_DIR) para /etc/wireguard..."
sudo mv "$SCRIPT_DIR/wg-conf-1.conf" /etc/wireguard
echo "Arquivo movido com sucesso."

# Sobe a interface WireGuard
echo "Subindo a interface WireGuard..."
sudo wg-quick up wg-conf-1
if [ $? -eq 0 ]; then
    echo "Interface WireGuard subida com sucesso."
else
    echo "Falha ao subir a interface WireGuard. Verifique o arquivo de configuração."
    exit 1
fi

# Mostra o status do WireGuard
echo "Exibindo o status do WireGuard:"
sudo wg show


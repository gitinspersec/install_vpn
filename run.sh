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

# Verifica se o arquivo já existe antes de mover
if [ -f /etc/wireguard/wg-conf-1.conf ]; then
    echo "Arquivo wg-conf-1.conf encontrado em /etc/wireguard. Removendo o arquivo existente..."
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
echo "Interface WireGuard subida com sucesso."

# Mostra o status do WireGuard
echo "Exibindo o status do WireGuard:"
sudo wg show

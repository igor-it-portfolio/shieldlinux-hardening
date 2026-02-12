#!/bin/bash

# =================================================================
# ShieldLinux - Script de Automação de Hardening
# Autor: Igor Cesar
# Versão: 1.0
# =================================================================

# Cores para feedback
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}[1/4] Atualizando repositórios e pacotes...${NC}"
sudo apt update && sudo apt upgrade -y

echo -e "${GREEN}[2/4] Instalando ferramentas essenciais...${NC}"
sudo apt install -y ufw curl vim git

echo -e "${GREEN}[3/4] Configurando Firewall (UFW)...${NC}"
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp   # SSH
sudo ufw allow 80/tcp   # HTTP
sudo ufw allow 443/tcp  # HTTPS
echo "y" | sudo ufw enable

echo -e "${GREEN}[4/4] Criando Usuário de Gestão...${NC}"
# Aqui definimos um nome padrão, mas o ideal é ser dinâmico
NOVO_USER="admin_secure"
if id "$NOVO_USER" &>/dev/null; then
    echo "Usuário $NOVO_USER já existe."
else
    sudo useradd -m -s /bin/bash "$NOVO_USER"
    sudo usermod -aG sudo "$NOVO_USER"
    echo -e "${GREEN}Usuário $NOVO_USER criado com sucesso!${NC}"
fi

echo -e "${GREEN}==========================================${NC}"
echo -e "${GREEN} HARDENING INICIAL CONCLUÍDO COM SUCESSO! ${NC}"
echo -e "${GREEN}==========================================${NC}"

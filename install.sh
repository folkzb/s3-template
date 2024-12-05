#!/bin/bash

# URL do arquivo a ser baixado
FILE_URL="https://raw.githubusercontent.com/marmotitude/s3-template/main/s3config"

# Destino final do arquivo
DESTINATION="/usr/local/bin/s3config"

# Verificar se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, execute como root (ou use sudo)."
  exit 1
fi

# Baixar o arquivo
echo "Baixando o arquivo de $FILE_URL..."
curl -fLo "$DESTINATION" "$FILE_URL"
if [ $? -ne 0 ]; then
  echo "Erro ao baixar o arquivo. Verifique a URL."
  exit 1
fi

# Tornar o arquivo executável
chmod +x "$DESTINATION"

# Confirmar sucesso
echo "Arquivo instalado com sucesso em $DESTINATION."

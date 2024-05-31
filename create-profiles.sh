#!/bin/bash

# Função para criar diretórios, se não existirem
create_paths() {
    mkdir -p "$1"
}

# Função para escrever configuração AWS
write_aws_config() {
    local config="$1"

    # Iniciar arquivos
    > ~/.aws/config
    > ~/.aws/credentials

    # Iterar sobre cada remote
    echo "$config" | yq eval '.remotes | keys' - | while IFS= read -r remote; do
        if [ -n "$remote" ]; then
            remote=$(echo "$remote" | sed 's/^- //')  # Remover prefixo de lista
            access_key=$(echo "$config" | yq eval ".remotes.\"$remote\".access_key" -)
            secret_key=$(echo "$config" | yq eval ".remotes.\"$remote\".secret_key" -)
            region=$(echo "$config" | yq eval ".remotes.\"$remote\".region" -)
            endpoint=$(echo "$config" | yq eval ".remotes.\"$remote\".endpoint" -)
            host=$(echo "$config" | yq eval ".remotes.\"$remote\".host" -)

            # Escrever config
            {
                echo "[profile $remote]"
                echo "endpoint_url = $endpoint"
                echo "region = $region"
                echo "s3 ="
                echo "    addressing_style = ${host:-path}"
                echo
            } >> ~/.aws/config

            # Escrever credentials
            {
                echo "[$remote]"
                echo "aws_access_key_id = $access_key"
                echo "aws_secret_access_key = $secret_key"
                echo
            } >> ~/.aws/credentials
        fi
    done
    echo 'write aws config e credencials'
}

# Função para escrever configuração Rclone
write_rclone_config() {
    local config="$1"

    # Iniciar arquivo
    > ~/.config/rclone/rclone.conf

    # Iterar sobre cada remote
    echo "$config" | yq eval '.remotes | keys' - | while IFS= read -r remote; do
        if [ -n "$remote" ]; then
            remote=$(echo "$remote" | sed 's/^- //')  # Remover prefixo de lista
            access_key=$(echo "$config" | yq eval ".remotes.\"$remote\".access_key" -)
            secret_key=$(echo "$config" | yq eval ".remotes.\"$remote\".secret_key" -)
            region=$(echo "$config" | yq eval ".remotes.\"$remote\".region" -)
            endpoint=$(echo "$config" | yq eval ".remotes.\"$remote\".endpoint" -)

            # Escrever rclone.conf
            {
                echo "[$remote]"
                echo "type = s3"
                echo "provider = Other"
                echo "access_key_id = $access_key"
                echo "secret_access_key = $secret_key"
                echo "region = $region"
                echo "endpoint = $endpoint"
                echo
            } >> ~/.config/rclone/rclone.conf
        fi
    done
    echo 'write rclone.conf'
}

# Função para escrever arquivos MGC
write_mgc_configs() {
    local remote_folder="$1"
    local access_key="$2"
    local secret_key="$3"
    local region="$4"

    echo "access_key_id: $access_key" > "${remote_folder}/auth.yaml"
    echo "secret_access_key: $secret_key" >> "${remote_folder}/auth.yaml"

    echo "region: $region" > "${remote_folder}/cli.yaml"

}

# Carregar o conteúdo do arquivo YAML config.yaml usando yq
config=$(yq eval '.' config.yaml)

# Criar diretórios necessários
mkdir -p ~/.config/rclone
mkdir -p ~/.aws

# Escrever configurações AWS e Rclone
write_aws_config "$config"
write_rclone_config "$config"

# Processar cada remote no arquivo YAML
echo "$config" | yq eval '.remotes | keys' - | while IFS= read -r remote; do
    remote=$(echo "$remote" | sed 's/^- //')  # Remover prefixo de lista
    remote_folder="$HOME/.config/mgc/$remote"
    create_paths "$remote_folder"

    access_key=$(echo "$config" | yq eval ".remotes.\"$remote\".access_key" -)
    secret_key=$(echo "$config" | yq eval ".remotes.\"$remote\".secret_key" -)
    region=$(echo "$config" | yq eval ".remotes.\"$remote\".region" -)

    write_mgc_configs "$remote_folder" "$access_key" "$secret_key" "$region"
done

echo 'write mgc auth'
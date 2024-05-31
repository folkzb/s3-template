# Gerador de Documentos de Configuração para Clientes AWS S3, Rclone e MGC

Este projeto consiste em um gerador de documentos de configuração para clientes AWS S3, Rclone e MGC. Ele utiliza bash e yq como dependência.

## Pré-requisitos

Certifique-se de ter as seguintes dependências instaladas em sua máquina:

- yq
- bash

## Instalação

1. Clone este repositório:

    ```sh
    git clone https://github.com/marmotitude/s3-template.git
    ```

2. Navegue até o diretório do projeto:

    ```sh
    cd s3-template
    ```

3. Instale as dependências:

    ```sh
    # Para Linux
    sudo wget https://github.com/mikefarah/yq/releases/download/v4.31.1/yq_linux_amd64 -O /usr/local/bin/yq
    sudo chmod +x /usr/local/bin/yq
    ```

## Uso

Crie um arquivo com o nome `config.yaml` e configure conforme o `example.config.yaml`.

Para gerar os arquivos de configuração, execute o script `create-profiles.sh`:

```sh
./create-profiles.sh
```

Este script irá gerar os documentos de configuração para os clientes AWS S3, Rclone e MGC.

## Plus

adicione as linhas do .bashrc.config em seu bashrc e defina o profile da aws-cli e mgc com:

```
profile <profile-name>
```

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir uma issue ou enviar um pull request.

## Licença

Este projeto está licenciado sob a [Licença MIT](LICENSE).

---

# Gerador de Documentos de Configuração para Clientes AWS S3, Rclone e MGC

Este projeto consiste em uma CLI que gera documentos de configuração para clientes AWS S3, Rclone e MGC, Mantendo os mesmos profiles nos 3 provedores. Ele utiliza bash e yq como dependência.

## Pré-requisitos

Certifique-se de ter as seguintes dependências instaladas em sua máquina:

- yq
- bash

## Instalação

Rode o comando abaixo para instalar seu s3config:



```sh
sudo -v ; curl https://raw.githubusercontent.com/marmotitude/s3-template/main/install.sh | sudo bash
```

## Uso

Para instalar as dependencias use:

```
s3config install
```


Comandos disponíveis:

```
Usage: s3config <command>

Commands:
  configure               Configure a new s3 profile
  set <profile-name>      Set the s3 profile to use
  create                  Write AWS,Rclone and MGC configurations
  delete <profile-name>   Delete a profile
  list                    List remotes
  show <profile-name>     List remote details
  install                 Install dependecy YQ and clients aws/mgc/rclone in the latest version
```

Peculiaridade, para o comando "set" precisa rodar a cli com source, exemplo:

```
source s3config set <profile-name>
```
ou

adicione as linhas do .bashrc.config em seu bashrc e defina o profile da aws-cli e mgc com:

```sh
profile() {
    export AWS_PROFILE="$1"
    mgc workspace set "$1"
}
```

```
profile <profile-name>
```

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir uma issue ou enviar um pull request.

## Licença

Este projeto está licenciado sob a [Licença MIT](LICENSE).

---

# 🐳 Desafio Docker 01 — Python

## 🎯 Objetivo

Criar uma imagem Docker para executar uma aplicação Python simples e, a partir dela, criar um container para executar a aplicação.

Este desafio foi desenvolvido como parte dos estudos práticos de **DevOps e Docker**.

---

## 📁 Estrutura do projeto

```text
desafio1/
├── app.py
├── requirements.txt
├── Dockerfile
├── .dockerignore
└── README.md
```

---

## 🐍 Aplicação

A aplicação Python é simples e tem como objetivo apenas validar que o container consegue executar corretamente o código.

Ao iniciar, ela exibe:

```text
Aplicação iniciada em: ...
Olá, DevOps!
```

---

# 🐳 Dockerfile

O Dockerfile foi construído utilizando uma imagem oficial do Python:

```dockerfile
FROM python:3.12-slim

WORKDIR /app

COPY ./requirements.txt /app/

RUN pip install -r ./requirements.txt

COPY . /app/

CMD ["python", "app.py"]
```

### Principais instruções utilizadas

| Instrução | Função |
|---|---|
| `FROM` | Define a imagem base utilizada |
| `WORKDIR` | Define o diretório de trabalho dentro do container |
| `COPY` | Copia arquivos do contexto do build para a imagem |
| `RUN` | Executa comandos durante a construção da imagem |
| `CMD` | Define o comando executado quando o container inicia |

---

# 🔨 Criando a imagem

Para construir a imagem:

```bash
docker build -t hello0devops .
```

### Entendendo o comando

```text
docker build
```

Solicita ao Docker a construção de uma imagem.

```text
-t hello0devops
```

`-t` significa **tag** e permite definir um nome/tag para identificar a imagem.

Nesse caso:

```text
hello0devops
```

Como nenhuma tag específica foi informada, o Docker utiliza `latest` por padrão:

```text
hello0devops:latest
```

```text
.
```

O ponto representa o **diretório atual**, que será utilizado como **contexto do build**.

---

# ▶️ Criando e executando o container

Depois de criar a imagem:

```bash
docker run hello0devops
```

O Docker utiliza a imagem `hello0devops` para criar e iniciar um novo container.

Nesse comando:

```text
hello0devops
```

é o nome/tag da imagem criada anteriormente.

Fluxo:

```text
Dockerfile
    │
    │ docker build
    ▼
  IMAGE
    │
    │ docker run
    ▼
 CONTAINER
    │
    ▼
 aplicação Python
```

---

# 🧠 Conceitos praticados

Durante o desafio foram praticados:

- criação de um `Dockerfile`;
- utilização de imagem oficial do Python;
- escolha de uma tag de imagem (`python:3.12-slim`);
- `WORKDIR`;
- `COPY`;
- instalação de dependências com `pip`;
- `RUN`;
- `CMD`;
- contexto de build;
- criação de imagens com `docker build`;
- criação e execução de containers com `docker run`;
- diferença entre **imagem** e **container**;
- cache das layers durante o build;
- utilização de `.dockerignore`;
- diagnóstico de erros durante o build e execução do container.

---

# 🚧 Problemas encontrados

### `pip install`

Inicialmente foi utilizado:

```dockerfile
RUN "pip install requirements.txt"
```

O comando apresentou erro porque o comando foi interpretado incorretamente pelo shell e o `pip` também não estava sendo instruído a utilizar o arquivo como lista de dependências.

A solução utilizada foi:

```dockerfile
RUN pip install -r ./requirements.txt
```

---

### Arquivo `app.py` não encontrado

Inicialmente foi utilizado:

```dockerfile
COPY .\* /app/
```

O container iniciou, mas o Python não encontrou:

```text
/app/app.py
```

Após investigar o conteúdo do container, foi identificado que o conteúdo da aplicação não estava sendo copiado como esperado.

A instrução foi alterada para:

```dockerfile
COPY . /app/
```

---

# ✅ Resultado

Após a construção da imagem:

```bash
docker build -t hello0devops .
```

e execução:

```bash
docker run hello0devops
```

A aplicação foi executada corretamente dentro do container:

```text
Aplicação iniciada em: 2026-10-06 23:52:24.226823
Olá, DevOps!
```
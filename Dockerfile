# Imagem que iremos usar como base
FROM python:3.12-slim

#definimos o diretorio raiz do projeto dentro do cotainer
WORKDIR /app

#copiamos o arjivo de configuracoes das dependencias
COPY ./requirements.txt /app/

#rodamos o comando pra instalar essas dependencias
RUN pip install -r ./requirements.txt

#copiamos o restante da appliacaoo
COPY . /app/

#EXPOSE 8008

#comando usado quando o container inicar
CMD [ "python", "app.py" ]
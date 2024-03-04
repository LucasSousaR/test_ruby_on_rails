# Use a imagem oficial do Ruby
FROM ruby:2.6.8

# Instale as dependências do sistema
RUN apt-get update -qq && apt-get install -y nodejs

# Crie um diretório de trabalho dentro do contêiner
WORKDIR /app

# Instale as gems necessárias
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# Copie o restante do aplicativo para o contêiner
COPY . .

# Exponha a porta 3000 para que a aplicação Rails possa ser acessada externamente
EXPOSE 3000

# Comando para iniciar o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
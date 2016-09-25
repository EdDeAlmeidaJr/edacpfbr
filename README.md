# EdaCPFbr

Esta gema valida CPFs, verificando se os dígitos verificadores estão corretos.

## Instalação

Adicione a seguinte linha ao seu Gemfile:

```ruby
gem 'edacpfbr'
```

E execute:

    $ bundle

Ou instale você, digitando:

    $ gem install edacpfbr

## Uso

Você pode invocar 

    EdaCPFbr.validar(cpf)

onde `cpf` é uma string contendo um CPF completo. O resultado será `true` se o CPF estiver correto, ou seja, se os dois dígitos verificadores estiverem corretos, ou `false` caso contrário.


É possível também validar uma lista de CPFs, passada como uma array, com

    EdaCPFbr.validar_lote(lista)

Nesse caso a saía será um Hash, com as chaves sendo os CPFs passados e os valores sendo `true` ou `false`, conforme cada CPF seja correto ou não.

## Desenvolvimento

Depois de fazer o checkout do repositório, execure `bin/setup` para instalar as dependências. Então execure `rake spec` para rodar todos os testes. Você pode também executar `bin/console` para obter um console iterativo que permitirá fazer experiências com a gema.

Para instalar esta gema em sua máquina local, execute `bundle exec rake install`.

Para submeter sua contribuição, faça o push do seu branch com `git pull origin <branch>` e gere o pull request, que será avaliado, sendo o merge resultado da avaliação positiva do código submetido.

Bugs e pull requests são bemvindos no GitHub em https://github.com/EdDeAlmeidaJr/edacpfbr.

Esta gema está disponível nos termos da [MIT License](http://opensource.org/licenses/MIT). Isto significa, em resumo, que você pode copiar, modificar e distribuir livremente o código, desde que informe quem é o autor.


# KobanaPix

Gem teste de integração do Pix da Kobana.

## Instalação

Adicione essa linha ao seu Gemfile:

```ruby
gem 'kobana_pix', git: 'https://github.com/meirabruno/kobana_pix.git', tag: '0.1.0'
```

Depois execute:

    $ bundle install

## Exemplos de Uso

Crie o arquivo kobana_pix.rb no seu initializer com o seguinte conteúdo:

```ruby
KobanaPix.configure do |config|
  config.url = ENV['KOBANA_PIX_URL']
  config.api_key = ENV['KOBANA_TOKEN_API']
end
```

Agora basta chamar o método de charge do pix:

```ruby
KobanaPix::Payable.charge(body)
```

O body deve seguir as regras da documentação oficial da Kobana que pode ser vista em https://developers.kobana.com.br/v2.0/reference/post_v2-charge-pix

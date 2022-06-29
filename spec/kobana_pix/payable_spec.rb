# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KobanaPix::Payable do
  before(:all) do
    KobanaPix.configuration.url = 'https://api-sandbox.kobana.com.br/v2/charge/pix'
    KobanaPix.configuration.api_key = '30s5PSaQqBNiJfcXyyTbhcKv7HDLrYhc8d3c3alulKc'
  end

  describe 'charge' do
    it 'send valid infos' do
      body = {
        payer: {
          document_number: '563.769.550-45',
          name: 'Jorge Jorginho'
        },
        amount: 300.99,
        pix_account_id: 63,
        expire_at: (Time.now + 86_400)
      }.to_json

      expect(KobanaPix::Payable.charge(body)['status']).to eq(201)
    end

    it 'invalid payer document_number' do
      body = {
        payer: {
          document_number: '123.456.789-10',
          name: 'Jorge Jorginho'
        },
        amount: 300.99,
        pix_account_id: 63,
        expire_at: (Time.now + 86_400)
      }.to_json

      response = KobanaPix::Payable.charge(body)

      expect(response['status']).to eq(422)
      expect(response['errors'][0]['code']).to eq('validation_error')
      expect(response['errors'][0]['param']).to eq('payer')
      expect(response['errors'][0]['detail']).to eq('Pagador > Número do Documento não é um CNPJ ou CPF válido')
    end

    it 'invalid payer name' do
      body = {
        payer: {
          document_number: '563.769.550-45',
          name: ''
        },
        amount: 300.99,
        pix_account_id: 63,
        expire_at: (Time.now + 86_400)
      }.to_json

      response = KobanaPix::Payable.charge(body)

      expect(response['status']).to eq(422)
      expect(response['errors'][0]['code']).to eq('validation_error')
      expect(response['errors'][0]['param']).to eq('payer')
      expect(response['errors'][0]['detail']).to eq('Pagador > Nome não pode ficar em branco')
    end

    it 'invalid amount' do
      body = {
        payer: {
          document_number: '563.769.550-45',
          name: 'Jorge Jorginho'
        },
        amount: 0,
        pix_account_id: 63,
        expire_at: (Time.now + 86_400)
      }.to_json

      response = KobanaPix::Payable.charge(body)

      expect(response['status']).to eq(422)
      expect(response['errors'][0]['code']).to eq('validation_error')
      expect(response['errors'][0]['param']).to eq('amount')
      expect(response['errors'][0]['detail']).to eq('Quantia deve ser maior que 0')
    end

    it 'invalid pix_account_id' do
      body = {
        payer: {
          document_number: '563.769.550-45',
          name: 'Jorge Jorginho'
        },
        amount: 300.00,
        pix_account_id: 3,
        expire_at: (Time.now + 86_400)
      }.to_json

      response = KobanaPix::Payable.charge(body)

      expect(response['status']).to eq(422)
      expect(response['errors'][0]['code']).to eq('validation_error')
      expect(response['errors'][0]['param']).to eq('pix_account')
      expect(response['errors'][0]['detail']).to eq('Conta PIX não encontrado')
    end

    it 'expire_at in past' do
      body = {
        payer: {
          document_number: '563.769.550-45',
          name: 'Jorge Jorginho'
        },
        amount: 300.00,
        pix_account_id: 63,
        expire_at: (Time.now - 86_400)
      }.to_json

      response = KobanaPix::Payable.charge(body)

      expect(response['status']).to eq(422)
      expect(response['errors'][0]['code']).to eq('validation_error')
      expect(response['errors'][0]['param']).to eq('expire_at')
      expect(response['errors'][0]['detail']).to eq('Vencimento não pode ser no passado')
    end
  end
end

require "spec_helper"

require 'json'

describe EdaCPFbr do

  let(:lote) {
    <<-JSON
      [ "92705910778", "92705910787", "98765432100", "98765432101" ]
    JSON
  }	

  let(:retorno_lote) {
    <<-JSON
      {
      	"92705910778": true,
      	"92705910787": false,
      	"98765432100": true,
      	"98765432101": false
      }
    JSON
  }

  context "Properties" do 
  
  	it "has a version number" do
      expect(EdaCPFbr::VERSION).not_to be nil
    end

  end

  context "Methods" do

    it "responds to validar" do
      expect(EdaCPFbr.respond_to?(:validar)).to be true
    end

    it "responds to primeiro_bloco" do
      expect(EdaCPFbr.respond_to?(:primeiro_bloco)).to be true
    end

    it "responds to segundo_bloco" do
      expect(EdaCPFbr.respond_to?(:segundo_bloco)).to be true
    end

    it "responds to dig1" do
      expect(EdaCPFbr.respond_to?(:dig1)).to be true
    end

    it "responds to dig2" do
      expect(EdaCPFbr.respond_to?(:dig2)).to be true
    end

    it "responds to validar_lote" do
      expect(EdaCPFbr.respond_to?(:validar_lote)).to be true
    end

    it "responds to digito_correto" do
      expect(EdaCPFbr.respond_to?(:digito_correto)).to be true
    end

    it "responds to digito" do
      expect(EdaCPFbr.respond_to?(:digito)).to be true
    end

    it "responds to digito_contextual" do
      expect(EdaCPFbr.respond_to?(:digito_contextual)).to be true
    end

    it "responds to gerar_lote" do
      expect(EdaCPFbr.respond_to?(:gerar_lote)).to be true
    end

    it "responds to lote_blocos" do
      expect(EdaCPFbr.respond_to?(:lote_blocos)).to be true
    end

    it "responds to gerar_lote_valido" do
      expect(EdaCPFbr.respond_to?(:gerar_lote_valido)).to be true
    end

    it "responds to gerar_lote_invalido" do
      expect(EdaCPFbr.respond_to?(:gerar_lote_invalido)).to be true
    end

  end

  context "Functionalities" do

  	context "Validation" do

  	  context 'digito_bloco' do

  	  	it 'returns the correct digit for a given block' do
  	  	  expect(EdaCPFbr.digito('927059107')).to eq(7)
  	  	end

  	  end

  	  context 'digito_correto' do 

  	    it 'returns true when given a correct digit for a block' do
  	  	  expect(EdaCPFbr.digito_correto('927059107','7')).to be true
  	    end

  	    it 'returns false when given a incorrect digit for a block' do
  	  	  expect(EdaCPFbr.digito_correto('927059107','6')).to be false
  	    end

  	  end

  	  context 'validar' do 

  	    it 'returns false when a uncomplete CPF (less than 11 digits) is given' do 
  	  	  expect(EdaCPFbr.validar('9270591076')).to be false
  	    end

  	    it 'returns false when a bad CPF (first digit) is given' do
  	  	  expect(EdaCPFbr.validar('92705910768')).to be false
  	    end

  	    it 'returns false when a bad CPF (second digit) is given' do
  	  	  expect(EdaCPFbr.validar('92705910777')).to be false
  	    end

  	    it 'returns true when a good CPF is given' do
  	  	  expect(EdaCPFbr.validar('92705910778')).to be true
  	    end

  	  end

  	  context 'validar_lote' do

  	  	it 'returns a correct hash of values when an array of CPFs is submmited' do
  	  	  expect(EdaCPFbr.validar_lote(JSON.load(lote))).to eq(JSON.load(retorno_lote))
  	  	end

  	  end

    end

    context 'Generation' do

      context 'digito_contextual' do

        it 'return the same dig as digito when @valids is true' do
          EdaCPFbr.set_valids(true)
          dig1 = EdaCPFbr.digito('927059107')
          dig2 = EdaCPFbr.digito_contextual('927059107')
          expect(dig2).to eq(dig1)
        end

        it 'return different from digito when @valids is false' do
          EdaCPFbr.set_valids(false)
          dig1 = EdaCPFbr.digito('927059107')
          dig2 = EdaCPFbr.digito_contextual('927059107')
          expect(dig2).not_to eq(dig1)
        end

      end

      context 'lote_blocos' do

        it 'returns a set of n first blocs for CPFs' do
          lote = EdaCPFbr.lote_blocos(5)
          expect(lote.length).to eq(5)
        end

        it 'returns only length-9 strings in a block' do
          lote = EdaCPFbr.lote_blocos(10)
          lote.each do |l|
            expect(l.length).to eq(9)
          end
        end

        it 'returns an array containing only distinct elements' do
          lote1 = EdaCPFbr.lote_blocos(15)
          lote2 = lote1.uniq
          expect(lote1).to eq(lote2)
        end

      end

      context 'gerar_lote' do

        it 'returns a set of n CPFs' do
          lote = EdaCPFbr.gerar_lote(5)
          expect(lote.length).to eq(5)
        end

        it 'returns only length-11 strings in a block' do
          lote = EdaCPFbr.gerar_lote(10)
          lote.each do |l|
            expect(l.length).to eq(11)
          end
        end

        it 'returns an array containing only distinct elements' do
          lote1 = EdaCPFbr.gerar_lote(15)
          lote2 = lote1.uniq
          expect(lote1).to eq(lote2)
        end

      end

      context 'gerar_lote_valido' do

        it 'returns an array of valid CPFs' do
          EdaCPFbr.set_valids(true)
          lote = EdaCPFbr.gerar_lote_valido(15)
          lote.each do |cpf|
            expect(EdaCPFbr.validar(cpf)).to be true
          end
        end

        it 'returns an array of invalid CPFs' do
          EdaCPFbr.set_valids(false)
          lote = EdaCPFbr.gerar_lote_invalido(15)
          lote.each do |cpf|
            expect(EdaCPFbr.validar(cpf)).to be false
          end
        end

      end

  	end

  end

end
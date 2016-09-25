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

  end

end
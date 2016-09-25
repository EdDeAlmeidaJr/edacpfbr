require "edacpfbr/version"

module EdaCPFbr
  
  def self.validar(cpf)
  	return false if cpf.length < 11
  	@cpf = cpf
  	@first_block = @cpf[0..8]
  	@dig1 = @cpf[9]
  	@dig2 = @cpf[10]
  	@second_block = @cpf[1..9]
  	return false if not digito_correto(@first_block,@dig1)
  	return false if not digito_correto(@second_block,@dig2)
  	true
  end

  def self.validar_lote(lote)
  	retorno_lote = Hash.new 
  	lote.each{ |cpf| retorno_lote[cpf] = validar(cpf) }
  	retorno_lote
  end

  def self.digito_correto(bloco,dig)
  	digito(bloco) == dig.to_i
  end

  def self.digito(bloco)
  	total = 0
  	(1..9).each do |i|
  	  ind = i - 1
  	  d = bloco[ind].to_i
  	  total += d*i
  	end
  	r = total % 11
  	(r>9) ? 0 : r  	
  end

end
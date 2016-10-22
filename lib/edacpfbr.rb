require 'edacpfbr/version'

module EdaCPFbr
  
  def self.validar(cpf)
  	return false if cpf.length < 11
  	@cpf = cpf
  	return false if not digito_correto(primeiro_bloco,dig1)
  	return false if not digito_correto(segundo_bloco,dig2)
  	true
  end

  def self.primeiro_bloco
    @cpf[0..8]
  end

  def self.segundo_bloco
    @cpf[1..9]
  end

  def self.dig1
    @cpf[9]
  end

  def self.dig2
    @cpf[10]
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

  def self.digito_contextual(bloco)
    dig = digito(bloco)
    return dig if valids
    dig = dig + 1
    dig > 9 ? 0 : dig
  end

  def self.gerar_lote_valido(qnt)
    set_valids(true)
    gerar_lote(qnt)
  end

  def self.gerar_lote_invalido(qnt)
    set_valids(false)
    gerar_lote(qnt)
  end

  def self.gerar_lote(qnt)
    lote = Array.new
    lote_blocos(qnt).each do |bloco1|
      dig1 = digito_contextual(bloco1)
      bloco2 = "#{bloco1}#{dig1}"[1..9]
      dig2 = digito(bloco2)
      @cpf = "#{bloco1}#{dig1}#{dig2}"
      lote.push(@cpf)
    end
    lote
  end

  def self.lote_blocos(qnt)
    blocos = Array.new
    while (blocos.length < qnt) do
      @cpf = ""
      (1..9).each do |n|
        @cpf = "#{@cpf}#{rand(10)}"
      end
      blocos.push(@cpf) if not blocos.include?(@cpf)
    end
    blocos
  end

  def self.valids
    @valids
  end

  def self.set_valids(v)
    @valids = v
  end

end
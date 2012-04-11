require 'file_text_delimiter'

class Teste < FileTextDelimiter::ClassDelimiter

    attr_delimiter :prontuario,           :delimiter => 10
    attr_delimiter :nome,                 :delimiter => 40, :format => Proc.new{|n| n.strip}
    attr_delimiter :data_coleta,          :delimiter => 10
    attr_delimiter :codigo_exame,         :delimiter => 20, :format => Proc.new{|n| n.strip}
    attr_delimiter :cpf,                  :delimiter => 11
    attr_delimiter :data_nascimento,      :delimiter => 10
    attr_delimiter :sexo,                 :delimiter => 1

end


testes = FileTextDelimiter::Document.parse("file_int.txt", Teste)

puts "#{testes.size}"

testes.each do |t|
  puts t
end

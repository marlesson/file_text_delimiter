#require '../lib/file_text_delimiter'
require '../lib/file_text_delimiter/class_delimiter'
require '../lib/file_text_delimiter/document'

class Teste < FileTextDelimiter::ClassDelimiter

    attr_delimiter :prontuario,           :delimiter => 10
    attr_delimiter :nome,                 :delimiter => 40, :format_get => Proc.new{|n| n.strip}
    attr_delimiter :data_coleta,          :delimiter => 10
    attr_delimiter :codigo_exame,         :delimiter => 20, :format_get => Proc.new{|n| n.strip}
    attr_delimiter :cpf,                  :delimiter => 11
    attr_delimiter :data_nascimento,      :delimiter => 10
    attr_delimiter :sexo,                 :delimiter => 1

    def self.line_match(line)
    	line[101...102] == "M"
    end
end

class Teste2 < FileTextDelimiter::ClassDelimiter

    attr_delimiter :prontuario,           :delimiter => 10
    attr_delimiter :nome,                 :delimiter => 40, :format_get => Proc.new{|n| n.strip}
    attr_delimiter :data_coleta,          :delimiter => 10
    attr_delimiter :codigo_exame,         :delimiter => 20, :format_get => Proc.new{|n| n.strip}
    attr_delimiter :cpf,                  :delimiter => 11
    attr_delimiter :data_nascimento,      :delimiter => 10
    attr_delimiter :sexo_2,               :delimiter => 1

    def self.line_match(line)
    	line[101...102] == "F"
    end
end

#puts "#{Teste.columns}"
#puts "#{Teste2.columns}"

testes = FileTextDelimiter::Document.parse("file_int.txt", [Teste, Teste2])

puts "#{testes.size}"

testes.each do |t|
  puts t
  #puts t.to_text
end

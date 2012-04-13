#require '../lib/file_text_delimiter'
require '../lib/file_text_delimiter/class_delimiter'
require '../lib/file_text_delimiter/document'

class Teste < FileTextDelimiter::ClassDelimiter

    attr_delimiter :prontuario,           :delimiter => 10
    attr_delimiter :nome,                 :delimiter => 40, :format_get => Proc.new{|n| n.strip}
    attr_delimiter :data_coleta,          :delimiter => 10, :format_get => Proc.new{|data| d, m, a = data.split("/"); Time.local(a,m,d)}
    attr_delimiter :codigo_exame,         :delimiter => 20, :format_get => Proc.new{|n| n.strip}
    attr_delimiter :cpf,                  :delimiter => 11
    attr_delimiter :data_nascimento,      :delimiter => 10
    attr_delimiter :sexo,                 :delimiter => 1,  :format_get => Proc.new{|s| (s == "M") ? 1 : 2} 

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

class ExportList < FileTextDelimiter::ClassDelimiter

    attr_delimiter :name,        :delimiter => 10
    attr_delimiter :description, :delimiter => 50
    attr_delimiter :value,       :delimiter => 10, :format_set => Proc.new{|v| v.to_s.rjust(10,"0")}
    
end

#puts "#{Teste.columns}"
#puts "#{Teste2.columns}"

testes = FileTextDelimiter::Document.parse_file("file_int.txt", [Teste, Teste2])

#puts "#{testes.size}"

testes.each do |t|
  #puts t
  #puts t.to_text
end


i = ExportList.new(:name => "banana       ", :description => "12 size", :value => 25.0)
puts i.to_text
puts i.to_text.size
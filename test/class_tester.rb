class Teste01 < FileTextDelimiter::ClassDelimiter
    attr_delimiter :prontuario,           :delimiter => 10
    attr_delimiter :nome,                 :delimiter => 40, :format_get => Proc.new{|n| n.strip}
    attr_delimiter :data_coleta,          :delimiter => 10, :format_get => Proc.new{|data| d, m, a = data.split("/"); Time.local(a,m,d)}
    attr_delimiter :codigo_exame,         :delimiter => 20, :format_get => Proc.new{|n| n.strip}
    attr_delimiter :cpf,                  :delimiter => 11
    attr_delimiter :data_nascimento,      :delimiter => 10
    attr_delimiter :sexo,                 :delimiter => 1,  :format_get => Proc.new{|s| (s == "M") ? 1 : 2} 
end

class ExportList < FileTextDelimiter::ClassDelimiter
    attr_delimiter :name,        :delimiter => 10
    attr_delimiter :description, :delimiter => 50
    attr_delimiter :value,       :delimiter => 10, :format_set => Proc.new{|v| v.to_s.rjust(10,"0")}
end

class Product < FileTextDelimiter::ClassDelimiter
    attr_delimiter :type,    :delimiter => 2
    attr_delimiter :name,    :delimiter => 10
    attr_delimiter :lenght,  :delimiter => 2
    attr_delimiter :value,   :delimiter => 10

    def self.line_match(line)
     line[0...2] == "01"
    end
end

class ListTotal < FileTextDelimiter::ClassDelimiter
    attr_delimiter :type,    :delimiter => 2
    attr_delimiter :lenght,  :delimiter => 12
    attr_delimiter :value,   :delimiter => 10

    def self.line_match(line)
     line[0...2] == "02"
    end
end
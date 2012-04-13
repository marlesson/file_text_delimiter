require "test/unit"
require "file_text_delimiter"  # Added


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

class FileTextDelimiterTest < Test::Unit::TestCase
   def test_parse_in_file01
   	objects = FileTextDelimiter::Document.parse_file("test/files_test/teste_01.txt", Teste01)
    obj_first = objects.first

    assert_equal "0000125889",            obj_first.prontuario
    assert_equal "JOAO DA SILVA",         obj_first.nome
    assert_equal Time.local(2009,12,15),  obj_first.data_coleta
    assert_equal "001",                   obj_first.codigo_exame
    assert_equal "14044170606",           obj_first.cpf
    assert_equal "13/02/1949",            obj_first.data_nascimento
    assert_equal 1,                       obj_first.sexo            
  end


  def test_export_file_text
    export_list = ExportList.new(:name => "banana       ", :description => "12 size", :value => 25.0)
    assert_equal "banana    12 size                                           00000025.0", export_list.to_text
  end
  
end
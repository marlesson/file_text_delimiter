require "test/unit"
require "file_text_delimiter"  # Added


class Teste01 < FileTextDelimiter::ClassDelimiter
    attr_delimiter :prontuario,           :delimiter => 10
    attr_delimiter :nome,                 :delimiter => 40, :format => Proc.new{|n| n.strip}
    attr_delimiter :data_coleta,          :delimiter => 10
    attr_delimiter :codigo_exame,         :delimiter => 20, :format => Proc.new{|n| n.strip}
    attr_delimiter :cpf,                  :delimiter => 11
    attr_delimiter :data_nascimento,      :delimiter => 10
    attr_delimiter :sexo,                 :delimiter => 1
end


class FileTextDelimiterTest < Test::Unit::TestCase
   def test_say_hello_to_the_world
   	 objects = FileTextDelimiter::Document.parse("test/files_test/teste_01.txt", Teste01)
     assert_equal 6, objects.size
  end
end
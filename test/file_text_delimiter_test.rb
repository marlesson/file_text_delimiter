require "test/unit"
require "file_text_delimiter"  # Added
require "test/class_tester"

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
  

  def test_import_file_multiple_format
    objects = FileTextDelimiter::Document.parse_file("test/files_test/teste_02.txt", [Product, ListTotal])

    product = objects.first
    assert_equal "01",           product.type
    assert_equal "Apple     ",   product.name

    total = objects.last
    assert_equal "02",           total.type
    assert_equal "00000030.9",   total.value    
  end
end
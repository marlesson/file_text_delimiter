# FileTextDelimiter - Análise de arquivos de texto

**FileTextDelimiter** É um gem para simplificar e organizar a realização de análise em arquivos de texto documentados e 
organizados. Podendo gerar tanto a importação de um arquivo de texto para objetos quanto a exportação de objetos para texto


## Uso

### Importar arquivo de texto

Tomando como base um arquivo de texto 'file_in.txt' com a seguinte formatação:

```txt
     1         2         3         4         5         6         7         8         9        10        11
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345

0000125889JOAO DA SILVA                           15/12/2009001                 1404417060613/02/1949M
0000125889JOAO DA SILVA                           15/12/2009011                 1404417060613/02/1949M
0000032644MARIA DAS DORES                         16/12/2009005                 4850527701525/10/1967F
0000032644MARIA DAS DORES                         16/12/2009007                 4850527701525/10/1967F
```

Podemos definir a classe `FileIn` com herança em `FileTextDelimiter::ClassDelimiter`. Delimitando todos os atributos contidos
no arquivo de texto. A ordem das definições de atributos devem ser iguais ao arquivo, pois o parametro `:delimiter` é 
acumulativo.

```ruby
class FileIn < FileTextDelimiter::ClassDelimiter

    attr_delimiter :id,              :delimiter => 10
    attr_delimiter :nome,            :delimiter => 40, :format_get => Proc.new{|n| n.strip}
    attr_delimiter :data,            :delimiter => 10, 
                              :format_get => Proc.new{|data| d, m, a = data.split("/"); Time.local(a,m,d)}
                                     
    attr_delimiter :codigo,          :delimiter => 20, :format_get => Proc.new{|n| n.strip}
    attr_delimiter :cpf,             :delimiter => 11
    attr_delimiter :data_nascimento, :delimiter => 10
    attr_delimiter :sexo,            :delimiter => 1,  :format_get => Proc.new{|s| (s == "M") ? 1 : 2} 
end
```

Para recuperar o Array de objetos contidos no arquivo:

```ruby
files_in = FileTextDelimiter::Document.parse_file("file_int.txt", FileIn)
```

#### Arquivos de texto com multiplas formatações

No caso do arquivo de texto apresentar multiplas formatações distintas, podemos criar várias classes herdadas da 
`FileTextDelimiter::ClassDelimiter` e passar como parametro para a função de parse_file.
O que irá definir qual classe deve representar cada linha do arquivo e a função `line_match(line)` que deve ser definida
em todas as classes.



### Exportar arquivo de texto

Definição da classe `ExportList` que será utilizada para a exportação do arquivo de texto formatado

```ruby
class ExportList < FileTextDelimiter::ClassDelimiter

    attr_delimiter :name,        :delimiter => 10
    attr_delimiter :description, :delimiter => 50
    attr_delimiter :value,       :delimiter => 10, :format_set => Proc.new{|v| v.to_s.rjust(10,"0")}
    
end
```

```ruby

export_list = ExportList.new(:name => "banana", :description => "12 size", :value => 25.0)
export_list.to_text

```

Resultado final 

```txt
     1         2         3         4         5         6         7    
0123456789012345678901234567890123456789012345678901234567890123456789
banana    12 size                                           00000025.0
```
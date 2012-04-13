# FileTextDelimiter - Análise de arquivos de texto

**FileTextDelimiter** É um gem para simplificar e organizar análise de arquivos texto com padrões. 
Podendo gerar tanto a importação de um arquivo de texto para objetos quanto a exportação de objetos para texto.


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

No caso do arquivo de texto apresentar multiplas formatações, podemos criar várias classes herdadas da 
`FileTextDelimiter::ClassDelimiter` e passar como parametro para a função de parse_file.
O que irá definir qual classe deve representar cada linha do arquivo e a função `self.line_match(line)` que deve ser definida
em todas as classes.

O arquivo de texto abaixo tem dois tipos de formatação.

* `01` que indica o produto
* `02` que indica o total


```txt
     1         2         3         4         5         6         7         8         9        10        11
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345
                        
01Apple     1000000020.6
01banana    0500000010.3
02          1500000030.9
```

```ruby
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

objects = FileTextDelimiter::Document.parse_file("file_int.txt", [Product, ListTotal])

```

A `self.line_match` deve retornar `true` no caso da linha 'casar' com a definição da classe. Assim os objetos retornados 
dependem da linha.

### Exportar arquivo de texto

Definição da classe `ExportList` que será utilizada para a exportação do arquivo de texto formatado

```ruby
class ExportList < FileTextDelimiter::ClassDelimiter

    attr_delimiter :name,        :delimiter => 10
    attr_delimiter :description, :delimiter => 50
    attr_delimiter :value,       :delimiter => 10, :format_set => Proc.new{|v| v.to_s.rjust(10,"0")}
    
end
```
Criado o objeto e gerando o texto formatado seguindo a documentação na classe

```ruby
export_list = ExportList.new(:name => "banana", :description => "12 size", :value => 25.0)
export_list.to_text
```

Resultado final 

```txt
banana    12 size                                           00000025.0
```

## Issues

Please report any issues to the GitHub Issue tracker (https://github.com/marlesson/file_text_delimiter).
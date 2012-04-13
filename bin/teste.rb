#require '../lib/file_text_delimiter'
require '../lib/file_text_delimiter/class_delimiter'
require '../lib/file_text_delimiter/document'

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

puts "#{objects.inspect}"

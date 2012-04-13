module FileTextDelimiter
	class SizeTextNotSuporte < Exception; end

	class ClassDelimiter
  	
		class << self; attr_accessor :columns, :formats_get, :formats_set; end

		def self.attr_delimiter(column, params = {})
			attr_accessor column

			self.columns			||= []
			self.formats_get 	||= {}
			self.formats_set	||= {}

			raise ArgumentNotFound, "Argument :delimiter not found" if params[:delimiter].nil?

			self.columns << [column, params[:delimiter]]
			self.formats_get[column] = params[:format_get] if not params[:format_get].nil?
			self.formats_set[column] = params[:format_set] if not params[:format_set].nil?
		end

		def self.parse_text(line)
			x = 0
			object = self.new
			self.columns.each do |column_value|

				column 	= column_value[0]
				size 		= column_value[1]
				value		= line[x...(x+size)]

				raise SizeTextNotSuporte, "Size text not suporte for range(#{x},#{x+size})" if value.nil?

				if not self.formats_get[column].nil? and self.formats_get[column].instance_of? Proc
					value = self.formats_get[column].call(value)
				end

				object.send("#{column.to_s}=", value)

				x+=size
			end
			object
		end

		def to_text
			text = ""
			self.class.columns.each do |column_value|

				column 	= column_value[0]
				size 		= column_value[1]
				value 	= self.send(column.to_s)

				if not self.class.formats_set[column].nil? and self.class.formats_set[column].instance_of? Proc
					value = self.class.formats_set[column].call(value)
				end

				text <<  value.to_s.ljust(size)
			end			
			text
		end

		def self.line_match(line)
			true
		end

		def to_s
			puts "#{self.inspect}"
		end
	end
end
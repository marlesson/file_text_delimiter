module FileTextDelimiter
	class ClassDelimiter

			@@columns = []
			@@formats = {}

			def self.attr_delimiter(column, params = {})
					attr_accessor column

					@@columns << [column, params[:delimiter]]
					@@formats[column] = params[:format] if not params[:format].nil?


			end


			def self.parse(line)
				x = 0
				object = self.new
				@@columns.each do |column_value|

					column 		= column_value[0]
					size 			= column_value[1]
					value			= line[x...(x+size)]

					if not @@formats[column].nil? and @@formats[column].instance_of? Proc
						value = @@formats[column].call(value)
					end

					object.send("#{column.to_s}=", value)

					x+=size
				end
				object
			end


			def to_s
				puts "#{self.inspect}"
			end
	end

	class Document

		def self.parse(file, klass)
			file = File.open(file, "r")

			klasses = []
			file.each_line do |line|
				klasses << klass.parse(line)
			end
			klasses
		end
		
	end

end
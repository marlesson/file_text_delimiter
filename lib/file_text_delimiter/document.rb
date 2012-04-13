module FileTextDelimiter
  
  class NotFindClassMatch < Exception; end
  class MultipleFindClassMatch < Exception; end

	class Document

		def self.parse_file(file, klasses)
			file = File.open(file, "r")
			
			klasses = [*klasses]
			objects = []
			file.each_line do |line|
				objects << parse_text(line, klasses)
			end
			objects
		end

		def self.parse_text(text, klasses)
				klass = [*klasses].select{|k| k.line_match(text)}
				
				raise NotFindClassMatch, "Not find class match in line '#{text}'" if klass.empty?
				raise MultipleFindClassMatch, "Find many class match in line '#{text}', #{klass.inspect}" if klass.size > 1

				klass.first.parse_text(text)
		end
	end

end
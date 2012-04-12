module FileTextDelimiter
	class Document

		def self.parse(file, klasses)
			file = File.open(file, "r")
			
			klasses = [*klasses]
			objects = []
			file.each_line do |line|
				klass = klasses.select{|k| k.line_match(line)}.first

				raise "Not find class compatible in line '#{line}'" if klass.nil?

				objects << klass.parse_text(line)

			end
			objects
		end

	end

end
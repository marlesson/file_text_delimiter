module FileTextDelimiter
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
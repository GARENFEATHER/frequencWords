class LineAnalyzer
	attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number
	def initialize(content,line_number)
		@content=content
		@line_number=line_number
		@highest_wf_count=0
		calculate_word_frequency
	end
	def calculate_word_frequency
		count=Hash.new(0)
		arr=self.content.split
		arr.each do |word|
			count[word]+=1
		end
		count.each do |key,value|
			if value>@highest_wf_count
				@highest_wf_count=value
				@highest_wf_words=[key]
			elsif value == @highest_wf_count
				@highest_wf_words.push(key)
			end
		end
	end
end

class Solution
	attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines
	def initialize
		@analyzers=[]
		analyze_file
	end
	def analyze_file
		i=1
		File.foreach("test.txt") do |line|
			lineAnalize=LineAnalyzer.new(line.chomp.downcase,i)
			@analyzers.push(lineAnalize)
			i+=1
		end
	end
	def calculate_line_with_highest_frequency
		@highest_count_words_across_lines=[]
		@highest_count_across_lines=0
		@analyzers.each do |analyzer|
			if analyzer.highest_wf_count>@highest_count_across_lines
				@highest_count_across_lines=analyzer.highest_wf_count
			end
		end
		@analyzers.each do |analyzer|
			if analyzer.highest_wf_count == @highest_count_across_lines
				@highest_count_words_across_lines.push(analyzer)
				print "#{analyzer.highest_wf_words}\n"
			end
		end
	end
	def print_highest_word_frequency_across_lines
		@highest_count_words_across_lines.each do |analy|
			gs="\""+analy.highest_wf_words.join("\",\"")+"\""
		end
	end
end

s=Solution.new
s.calculate_line_with_highest_frequency
s.print_highest_word_frequency_across_lines
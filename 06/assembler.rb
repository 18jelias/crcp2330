#! /usr/bin/env ruby

require_relative 'parser'

class Assembler 
	def initialize(asm_file, hack_file)
		@asm_file = asm_file
		@hack_file = hack_file
		@parser = Parser.new(instructions_from_file)

		#@parser = Parser.new(@asm_instructions)
	end 

	def assemble!
		@parser.parse.each do |instruction|
			@hack_file << instruction << "\n"
		end
	end 

	def instructions_from_file
		lines = @asm_file.readlines
		lines.each do |line|
			line.gsub! /\/\/.*/, ''
			line.strip!
		end
		lines.delete("")
		return lines
	end

end


def args_valid?
	return (ARGV[0] && ARGV[0].end_with?(".asm") && ARGV.length == 1)
end 

def is_readable?(path)
	File.readable?(path)
end

def hack_filename(asm_filename)
	asm_basename = File.basename(asm_filename, '.asm')
	path = File.split(asm_filename)[0]
	return "#{path}/#{asm_basename}.hack"
end

unless args_valid?
	abort("Usage: ./assembler.rb Prog.asm")
end 

asm_filename = ARGV[0]

unless(is_readable?(asm_filename))
	abort("#{asm_filename} is not found or is unreadable readable.")
end


hack_filename = hack_filename(asm_filename)


File.open(asm_filename) do |asm_file|
	File.open(hack_filename(asm_filename), 'w') do |hack_file|
		assembler = Assembler.new(asm_file, hack_file)
		assembler.assemble!
	end
end 


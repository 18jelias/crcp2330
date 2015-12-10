#! /usr/bin/env ruby


def args_valid?
	return (ARGV[0] && ARGV[0].end_with?(".asm") && ARGV.length == 1)
end 

def is_readable?(path)
	File.readable?(path)
end

unless args_valid?
	abort("Usage: ./assembler.rb Prog.asm")
end 

asm_filename = ARGV[0]

unless(is_readable?(asm_filename))
	abort("#{asm_filename} is not found or is unreadable readable.")
end
	puts "The contents of #{asm_filename}"


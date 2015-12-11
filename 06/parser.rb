require_relative 'code'

class Parser
	
	def initialize(assembly_instructions)
		@assembly_instructions = assembly_instructions
		@machine_instructions = []
		@code = Code.new()
	end


	def parse
		@assembly_instructions.each do |instruction|
			if command_type(instruction) == :a_command
				@machine_instructions << assemble_a_command(instruction)
			else command_type(instruction) == :c_command
				@machine_instructions << assemble_c_command(instruction)
			#elsif command_type(instruction) == :l_command
			#	@machine_instructions << assemble_l_command(instruction)
			end
		end
		@machine_instructions
	end

	def assemble_a_command(instruction)
		command = "0"
		command << constant(instruction[1..-1])
		return command
	end

	#Translates into binary
	def constant(value)
		"%015b" % value 
	end

	def assemble_l_command(instruction)
		"%016b" % symbol(instruction) 
	end


	def parseComp(instruction)
		if instruction.include?('=')
			return instruction.split('=')[1]
		elsif instruction.include?(';')
			return instruction.split(';')[0]
		end
	end

	def parseDest(instruction)
		if instruction.include?('=')
			return instruction.split('=')[0]
		end
	end

	def parseJump(instruction)
		if instruction.include?(';')
			return instruction.split(';')[1]
		end
	end

	def assemble_c_command(instruction)
		command = "111"
	
		command << @code.comp(parseComp(instruction))
		command << @code.dest(parseDest(instruction))
		command << @code.jump(parseJump(instruction))

		return command
	end


	def command_type(instruction)
		if instruction.start_with?("@")
			return :a_command
		#else instruction.start_with?('(')
		#	return :l_command
		else
			return :c_command
		end
	end
end

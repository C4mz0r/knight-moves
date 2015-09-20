require 'colorize'

class Node
	attr_accessor :name
	attr_accessor :row_value
	attr_accessor :col_value
	attr_accessor :prev
	attr_accessor :child_UL # the child found by moving Up 2 and Left 1 (i.e. long direction listed first)
	attr_accessor :child_UR
	attr_accessor :child_RU
	attr_accessor :child_RD
	attr_accessor :child_LU
	attr_accessor :child_LD
	attr_accessor :child_DL
	attr_accessor :child_DR


	def initialize(row_value, col_value)
		@row_value = row_value
		@col_value = col_value
		@name = row_value.to_s + col_value.to_s
	end

	def Node.childPointers
		["child_UL", "child_UR", "child_RU", "child_RD", "child_LU", "child_LD", "child_DL", "child_DR" ]
	end
	
	def Node.knight_offsets(key)
		offset = case key
		when "child_UL"
			{ row: -2, col: -1 } 
		when "child_UR"
			{row: -2, col: +1 }
		when "child_RU"
			{row: -1, col: +2 }
		when "child_RD"
			{row: +1, col: +2 }
		when "child_LU"
			{row: -1, col: -2 }
		when "child_LD"
			{row: +1, col: -2 }
		when "child_DL"
			{row: +2, col: -1 }
		when "child_DR"
			{row: +2, col: +1 }		
		else
			puts "Could not find entry according to key: #{key}"
		end
	end

end






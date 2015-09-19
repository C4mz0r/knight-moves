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

end






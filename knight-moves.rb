require 'colorize'
require './tree-lib.rb'

BOARD_SIZE = 8 # Board size, 8 denotes standard 8x8 chess board

class KnightTravails

	attr_accessor :node_list	
	
	def build_tree
		# for each row and column, create the Node
		# let's give it a name so it can be searched
		# name will be a string with row# followed by col# e.g. "00", "01",...,"77"

		@node_list = []

		for row in (0...BOARD_SIZE) do
			for col in (0...BOARD_SIZE) do
				@node_list << Node.new(row, col)
			end
		end

		# update each node's pointers to show possible places it can get to
		node_list.each do |node|
			Node.childPointers.each do |child|								
				offsets = eval("Node.knight_offsets('#{child}')")
				eval("node.#{child} = get_node_by_coordinates( node.row_value + offsets[:row], node.col_value + offsets[:col] )")
			end			
		end

		

		@node_list
	end

	# return the node from the array that is at a given coordinate (note: rows and cols are 0-based)
	# returns nil if out of bounds
	def get_node_by_coordinates( node_row, node_col )
		return nil if ( node_row < 0 or node_row >= BOARD_SIZE)
		return nil if ( node_col < 0 or node_col >= BOARD_SIZE)
		return @node_list[ BOARD_SIZE * node_row + node_col ]
	end

	# Used for debugging
	def print_node( node )
		puts "Node name is #{node.name}".colorize(:yellow)
		puts "Node row, col is #{node.row_value}, #{node.col_value}".colorize(:yellow)
		puts "Node prev = #{node.prev} (#{node.prev.name if !node.prev.nil?})".colorize(:blue)
		
		Node.childPointers.each do |child|								
			puts (("#{child} = ") + eval("node.#{child}").to_s).colorize(:yellow)
		end		
	end

	# Returns the node which contains the target value, nil otherwise
	# The use of "prev" will allow us to work backward from the final node to list out the search path
	# Cleaned up cut-and-paste by using each and eval - not sure how much I like that though :D
	def breadth_first_search(start_node, target_value)
		visited = [start_node]			
		queue = [start_node]
	
		while ( queue.length > 0 )	

			# dequeue
			vertex = queue.shift
			return vertex if target_value.name == vertex.name
	
			# visit all adjacent unvisited vertexes, mark visited, enqueue
			Node.childPointers.each do |child|
				if !eval("vertex.#{child}.nil?")
					if !eval("visited.include?vertex.#{child}")
						visited << eval("vertex.#{child}")
						eval("vertex.#{child}.prev = vertex")
						queue << eval("vertex.#{child}")
					end
				end
			end
		end

		nil
	end

	def knight_moves(start, finish)

		path_node = breadth_first_search( get_node_by_coordinates( start[0], start[1] ), get_node_by_coordinates( finish[0], finish[1] ))
	
		answer = []
		loop do

			answer << path_node
			path_node = path_node.prev
			break if path_node.nil?
		end
	
		answer.reverse!
		puts "You made it in #{answer.length-1} moves.  Here's your path:"
		answer.each { |node| puts "[#{node.row_value},#{node.col_value}]" }

	end
end

journey = KnightTravails.new
journey.build_tree
puts journey.knight_moves( [0,0],[3,3])
#journey.print_node(journey.node_list[0])
#node_list = build_tree
#puts knight_moves( node_list, [0,0],[1,2])
#puts knight_moves( node_list, [3,3],[4,3])
#puts knight_moves( node_list, [0,0],[3,3])
#puts knight_moves( node_list, [3,3],[0,0])
#puts knight_moves( node_list, [7,7],[0,0])


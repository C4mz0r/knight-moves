require 'colorize'
require './tree-lib.rb'

class KnightTravails

	attr_accessor :node_list	
	
	def build_tree
		# for each row and column, create the Node
		# let's give it a name so it can be searched
		# name will be a string with row# followed by col# e.g. "00", "01",...,"77"

		@node_list = []

		for row in (0...8) do
			for col in (0...8) do
				@node_list << Node.new(row, col)
			end
		end

		# update each node's pointers to show possible places it can get to
		node_list.each do |node|
			node.child_UL = get_node_by_coordinates( node.row_value - 2, node.col_value - 1 )
			node.child_UR = get_node_by_coordinates( node.row_value - 2, node.col_value + 1 )
			node.child_RU = get_node_by_coordinates( node.row_value - 1, node.col_value + 2 )
			node.child_RD = get_node_by_coordinates( node.row_value + 1, node.col_value + 2 )
			node.child_LU = get_node_by_coordinates( node.row_value - 1, node.col_value - 2 )
			node.child_LD = get_node_by_coordinates( node.row_value + 1, node.col_value - 2 )
			node.child_DL = get_node_by_coordinates( node.row_value + 2, node.col_value - 1 )
			node.child_DR = get_node_by_coordinates( node.row_value + 2, node.col_value + 1 )
		end

		

		@node_list
	end

	# return the node from the array that is at a given coordinate (note: rows and cols are 0-based)
	# returns nil if out of bounds
	def get_node_by_coordinates( node_row, node_col )
		return nil if ( node_row < 0 or node_row >= 8)
		return nil if ( node_col < 0 or node_col >= 8)
		return @node_list[ 8 * node_row + node_col ]
	end

	# Used for debugging
	def print_node( node )
		puts "Node name is #{node.name}".colorize(:yellow)
		puts "Node row, col is #{node.row_value}, #{node.col_value}".colorize(:yellow)
		puts "Node prev = #{node.prev} (#{node.prev.name if !node.prev.nil?})".colorize(:blue)
		puts "Node UL = #{node.child_UL}".colorize(:yellow)
		puts "Node UR = #{node.child_UR}".colorize(:yellow)
		puts "Node RU = #{node.child_RU}".colorize(:yellow)
		puts "Node RD = #{node.child_RD}".colorize(:yellow)
		puts "Node LU = #{node.child_LU}".colorize(:yellow)
		puts "Node LD = #{node.child_LD}".colorize(:yellow)
		puts "Node DL = #{node.child_DL}".colorize(:yellow)
		puts "Node DR = #{node.child_DR}".colorize(:yellow)
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

#node_list = build_tree
#puts knight_moves( node_list, [0,0],[1,2])
#puts knight_moves( node_list, [3,3],[4,3])
#puts knight_moves( node_list, [0,0],[3,3])
#puts knight_moves( node_list, [3,3],[0,0])
#puts knight_moves( node_list, [7,7],[0,0])


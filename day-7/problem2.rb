
require 'pry'

class TreeNode
  TYPES = {
    DIR: "dir",
    FILE: "file"
  }.freeze

  def initialize(value, type, children)
    @value = value
    @type = type
    @children = children
  end

  attr_accessor :value, :type, :children
end

class Tree
  def initialize(root)
    @root = root
  end

  attr_accessor :root
end

@terminal_output = File.open("input.txt").read.split("\n")
@filesystem = Tree.new(TreeNode.new("/", TreeNode::TYPES[:DIR], []))
@history_stack = []
@current_dir = nil

def process_terminal_output
  @terminal_output.each do |line|
    unless @current_dir.nil?
      puts "-----------"
      puts "Currently in: " 
      puts " "
      @history_stack.each {|hs| print "#{hs.value}/" } 
      print @current_dir.value
      puts " "
      puts "terminal line: #{line}"
      puts "-----------" 
    end

    terminal_line = line.split(" ")

    if terminal_line[0] == "$"
      case(terminal_line[1])
        
      when "cd"
        if terminal_line[2] == "/"
          @history_stack = []
          @current_dir = @filesystem.root
        elsif terminal_line[2] == ".."
          @current_dir = @history_stack.pop
        else 
          @history_stack << @current_dir unless @current_dir.nil?

          child_node = @current_dir.children.filter do |child|
             child.value == terminal_line[2] && child.type == TreeNode::TYPES[:DIR]
          end
          
          unless child_node.empty?
              @current_dir = child_node.first
              next
          end
          
          child_node = TreeNode.new(terminal_line[2], TreeNode::TYPES[:dir], [])
          @current_dir.children << child_node
          @current_dir = child_node
          
        end
      when "ls"
        next
      end
    else
      if terminal_line[0] == TreeNode::TYPES[:DIR]
          next if @current_dir.children.any? do |child| 
            child.value == terminal_line[1] && child.type == TreeNode::TYPES[:DIR]
          end

          @current_dir.children << TreeNode.new(terminal_line[1], TreeNode::TYPES[:DIR], [])
      else
          next if @current_dir.children.any? do |child| 
            child.value == line && child.type == TreeNode::TYPES[:FILE]
          end

          @current_dir.children << TreeNode.new(line, TreeNode::TYPES[:FILE], [])
      end

    end
  end
end

@possible_dirs_for_deletion = []


def dfs_traverse(node)
  size_counter = 0
  

  dirs = node.children.filter { |child| child.type == TreeNode::TYPES[:DIR] }
  files = node.children.filter { |child| child.type == TreeNode::TYPES[:FILE] }

  dirs.each { |dir| size_counter += dfs_traverse(dir)}

  files.each { | file| size_counter += file.value.split(" ").first.to_i }
  
  puts "dir #{node.value} has a size of #{size_counter}"

  space_to_free_up = 2677139

  @possible_dirs_for_deletion << { dir: node.value, size: size_counter} if size_counter > space_to_free_up

  return size_counter
end


def find_directories_under_limit
  dfs_traverse(@filesystem.root)
end

def deletable_dirs_for_update
  @possible_dirs_for_deletion.sort_by! { |dir| dir[:size] }
  puts @possible_dirs_for_deletion.first
end

# total filesystem space is 70,000,000
# to run the update you need 30,000,000 free
# 
#my puzzle total is 42,677,139
# 70,000,000 - 42,677,139 = 27,322,861
# 30,000,000 - 27,322,861 = 2,677,139


# I need to find all the dirs larger than 2,677,139
# and then return the smallest one > 2,677,139
process_terminal_output
find_directories_under_limit
deletable_dirs_for_update


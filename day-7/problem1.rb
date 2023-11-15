# puzzle input is a terminal output
# 
# filesystem is a tree of files
# outer most directory is /
# commands you have issued begin with $
# 
#
# So I need to parse the terminal input to understand what the filesystem we are looking at contains
# and save that in a data structure
# 
#
#
# Then I need to use this data structure to find all the directories with a size < 100000
# and then return sum the size of all of those directories together.
# 
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

#jljrdvw 101940

@dirs_under_threshold = []

def dfs_traverse(node)
  size_counter = 0

  dirs = node.children.filter { |child| child.type == TreeNode::TYPES[:DIR] }
  files = node.children.filter { |child| child.type == TreeNode::TYPES[:FILE] }

  dirs.each { |dir| size_counter += dfs_traverse(dir)}

  files.each { | file| size_counter += file.value.split(" ").first.to_i }
  
  puts "dir #{node.value} has a size of #{size_counter}"

  @dirs_under_threshold << { dir: node.value, size: size_counter} if size_counter < 100000

  return size_counter
end


def find_directories_under_limit
  dfs_traverse(@filesystem.root)
end

def sum_of_suggested_dirs_to_delete
  sum = 0

  @dirs_under_threshold.each { |dir| sum += dir[:size] }

  puts "Deleting all #{@dirs_under_threshold.count} suggested dirs would free up a total of: #{sum}"
  # 1,182,909
end

process_terminal_output
find_directories_under_limit
sum_of_suggested_dirs_to_delete

# so on change directory
# if current_directory isnt nil put current dir on stack
# I want to change the current directory to the value of whatever is happening

# current location as well as previous locations -
# could use a stack? if they cd one location in we pop previous location into before changing current 
# if we cd '/' stack gets emptied. if we cd .. current location becomes stack.pop
# 
# if we ls we want store all files + file info (size) and dir printed against the current dir
# 

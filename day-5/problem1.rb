# Whats the aim?
# After performing all of the rearrange operations
# Print the top crate of each stack
# 
#
# So what do we need to do to get that?
# Parse the input puzzle
# Figure out how many stacks there are
# and what the starting setup for each stack is
# 
# Parse the operations in the format of
# 'move #{crate_quantities} from #{stack_no} to #{stack_no}'
# 
#
require 'pry'

# so far parsing the input puzzle 3 chars represent a crate if its populated its [M] if its empty its " " " " " "
# number of stacks = line.chomp.chars.count + 1 / 4
no_of_stacks = (File.open('input.txt', &:readline).chomp.chars.count + 1) / 4

@stacks = Array.new(no_of_stacks) {[]}
@operations = []

def parse_input
  file = File.open("input.txt")

  loop do
    line = file.readline.chomp
    break if line[1] == "1"
    
    parse_stacks_from_file(line)
  end 

  setup_initial_stack_order
  file.readline
  
  while !file.eof?
    parse_operation(file.readline.chomp)
  end
end

def parse_stacks_from_file(line)
  stack_no = 0 
    line.chars.each_slice(4) do |slice| 
      if slice[0] == " "
        stack_no += 1
        next
      else
        @stacks[stack_no] << slice[1]
        stack_no += 1
      end 
  end
end

def setup_initial_stack_order
  starting_stacks = Array.new(@stacks.count) {[]}
  
  @stacks.each_with_index do |stack, index| 
    loop do
      crate = stack.pop
      break if crate.nil?
      starting_stacks[index] << crate
    end
  end

  @stacks = starting_stacks
end

def parse_operation(line)
  instructions = line.split(" ")
  crate_quantity = instructions[1].to_i
  from_stack = instructions[3].to_i - 1
  destination_stack = instructions[5].to_i - 1

  @operations << [crate_quantity, from_stack, destination_stack]
end

def perform_operations
  @operations.each do |op| 
    quantity, from_stack, destination_stack = op
    begin
      quantity.times do
        @stacks[destination_stack] << @stacks[from_stack].pop
      end
    rescue => e
      binding.pry
    end
  end
end

def print_output
  output_crates = @stacks.map { |stack| stack.pop }
  p output_crates.join
end

parse_input
perform_operations
print_output




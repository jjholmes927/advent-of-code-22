# Same as the previous task
# But this time when moving crates from
# One stack to another they retain their current ordering
# Due to crane being able to move multiple cranes at once
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

    stack_to_move = []
    quantity.times do
      stack_to_move.unshift(@stacks[from_stack].pop)
    end

    @stacks[destination_stack] = @stacks[destination_stack] + stack_to_move
  end
end

def print_output
  output_crates = @stacks.map { |stack| stack.pop }

  p output_crates.join
end

parse_input
perform_operations
print_output




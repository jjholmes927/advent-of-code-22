# grid of trees is given
# we need to determine if a tree house can be built and hidden by all the surrounding trees
# 
#a tree is visible if all trees between it and the grid edge are shorter than it
# only look horizontally and vertically not diagonally
# all edge trees are visible
# count how many trees are visible on the grid
# 
#
# Iterate through each non edge grid tree
# and see if its visible from either horizontal or vertical plane
# if it is increment the counter
# 
# the edge consists of the first and last row and the first and last column


require 'pry'

test_grid = [
  [3,0,3,7,3],
  [2,5,5,1,2],
  [6,5,3,3,2],
  [3,3,5,4,9],
  [3,5,3,9,0]
]

def calculate_visible_trees(grid)
  no_of_visible_trees = grid.count * 4 - 4

  for row in 1..grid.count-2
    for col in 1..grid.count-2
      visible = check_visibility(grid[row], col)

      if visible
        no_of_visible_trees += 1
        next
      end

      tree_column = []

      max = grid.count-1
      (0..max).each { |num| tree_column << grid[num][col] }

      visible = check_visibility(tree_column, row)

      no_of_visible_trees += 1 if visible
    end
  end

  puts "no_of_visible_trees: #{no_of_visible_trees}"
end

def check_visibility(trees, index_to_check)
  l = index_to_check - 1
  r = index_to_check + 1

  tree_to_check = trees[index_to_check]

  while l >= 0
    return true if l == 0 && trees[l] < tree_to_check
    break if trees[l] >= tree_to_check

    l -= 1
  end
  max = trees.count - 1
  while r <= max
    return true if r == max && trees[r] < tree_to_check
    break if trees[r] >= tree_to_check
    r += 1
  end

  return false
end



#calculate_visible_trees(test_grid)

def read_input
  grid = []
  File.foreach("input.txt") do |line|
    grid << line.chomp.split("")
  end
  grid
end

grid = read_input
calculate_visible_trees(grid)





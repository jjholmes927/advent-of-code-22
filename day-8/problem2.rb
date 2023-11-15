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
  highest_scenic_tree_score = 0

  for row in 1..grid.count-2
    for col in 1..grid.count-2

      row_score = check_score(grid[row], col)

      tree_column = []

      max = grid.count-1

      (0..max).each { |num| tree_column << grid[num][col] }

      column_score = check_score(tree_column, row)
      tree_score = row_score * column_score

      highest_scenic_tree_score = tree_score if tree_score > highest_scenic_tree_score
    end
  end

  puts "highest scenic tree score: #{highest_scenic_tree_score}"
end

def check_score(trees, index_to_check)
  l = index_to_check - 1
  r = index_to_check + 1

  tree_to_check = trees[index_to_check]


  while l > 0
    break if trees[l] >= tree_to_check

    l -= 1
  end

  max = trees.count - 1
  while r < max
    break if trees[r] >= tree_to_check
    r += 1
  end

  
  return (index_to_check - l) * (r - index_to_check)
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





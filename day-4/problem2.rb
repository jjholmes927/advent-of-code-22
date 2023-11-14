# go through input of paired ranges
# return a count of how many times one range in a pair is fully contained within the other
#
# read file pairs into an array
# go through array and check if they overlap
# theres overlap if the min is >= the other min && the max <= the other max
# increment counter if so
# 
def read_input
    File.open("input.txt").read.split
end

def count_overlapping_pairs
  number_of_pairs_overlapping = 0
  pairs = read_input

  pairs.each do |pair|
    left_elf, right_elf = pair.split(',')

    number_of_pairs_overlapping += 1 if overlapping_at_all_pair?(left_elf, right_elf)
  end

  puts "#{number_of_pairs_overlapping} pairs overlap"
end

def overlapping_at_all_pair?(left_elf, right_elf)
  left_elf_min, left_elf_max = parse_min_max(left_elf)
  right_elf_min, right_elf_max = parse_min_max(right_elf) 

  return true if left_elf_min >= right_elf_min && left_elf_min <= right_elf_max
  return true if left_elf_max >= right_elf_min && left_elf_max <= right_elf_max
  
  return true if right_elf_min >= left_elf_min && right_elf_min <= left_elf_max
  return true if right_elf_max >= left_elf_min && right_elf_max <= left_elf_max
  false
end

def parse_min_max(section)
  return section.split('-').map(&:to_i)
end


count_overlapping_pairs
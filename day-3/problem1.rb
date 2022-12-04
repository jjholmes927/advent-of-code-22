# each elf has 1 rucksack
# 1 rucksack has 2 large compartments
# items of a given type are supposed to be in the same compartment

#number of items in each compartment of a rucksack is equal


# find the items that appear in both compartments of a rucksack and sum the priorities of item types 

PRIORITIES = {}

def populate_priorties
    i = 1
    for l in "a".."z"
        PRIORITIES[l] = i
        PRIORITIES[l.upcase] = i + 26 
        i += 1
    end
end

def priorities_sum
    priorities_sum = 0
    populate_priorties
    rucksacks = read_input

    rucksacks.map { |r| priorities_sum += calculate_rucksack_priority(r) }
    priorities_sum
end

def read_input
    File.open("input.txt").read.split
end

def calculate_rucksack_priority(rucksack)
    compartment_dupes = {}
    rucksack_priority = 0
    last = rucksack.size - 1
    half_arr_index = last / 2
    compartment1 = rucksack[0..half_arr_index]
    compartment2 = rucksack[half_arr_index + 1..last]

    compartment1.each_char do |item_type|  
        next unless compartment_dupes[item_type].nil?
        if compartment2.include?(item_type)
            compartment_dupes[item_type] = true 
            rucksack_priority += PRIORITIES[item_type] 
        end
    end
    rucksack_priority
end


puts priorities_sum
# answer was 7878

# each elf has 1 rucksack
# 1 rucksack has 2 large compartments
# items of a given type are supposed to be in the same compartment

#number of items in each compartment of a rucksack is equal


# find the badge (item_type that occurs in each group of 3 elves)
# sum the priority of each of these

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
    last_group = rucksacks.size - 3

    i = 0

    while i <= last_group
        elf_group = rucksacks[i..i+2]
        priorities_sum += calculate_elf_group_priority(elf_group)
        i = i + 3
    end

    priorities_sum
end

def read_input
    File.open("input.txt").read.split
end

def calculate_elf_group_priority(elf_group)
    group_item_type_count = {}

    elf_group.each do |elf|
        elf_group = {}

        elf.each_char do |item_type|
            next if elf_group[item_type]

            elf_group[item_type] = 1

            if group_item_type_count[item_type]
                group_item_type_count[item_type] = group_item_type_count[item_type] +=1 
                next
            end

            group_item_type_count[item_type] = 1
        end
    end
    elf_group_badge = group_item_type_count.invert[3]

    PRIORITIES[elf_group_badge]
end

puts priorities_sum
# answer was 2760

# input contains rows of numbers
# numbers are in groups split by an empty row
# find the row


# parse the file
# calculate groups
# return highest group (the sum of each row in a group)


def find_calorific_elf 
    highest_calorie = 0
    calorie_group_count = 0

    File.foreach("./input-problem-1.txt") do |line|
        if line == "\n"
            highest_calorie = calorie_group_count if calorie_group_count > highest_calorie
            calorie_group_count = 0
            next
        end 

        calorie_group_count = calorie_group_count + line.chomp.to_i
    end
end

puts find_calorific_elf

# answer for input was 72240



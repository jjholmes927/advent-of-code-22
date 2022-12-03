#--- Part Two ---

# Find the top 3 calorific elves and sum their calorie counts

def find_calorific_elves
    top_3_elves = [0, 0, 0]
    calorie_group_count = 0

    File.foreach("./input.txt") do |line|
        if line == "\n"
            for i in 0..2 do
                if calorie_group_count > top_3_elves[i]
                    top_3_elves.insert(i, calorie_group_count)
                    break
                end
            end
            calorie_group_count = 0
            next
        end 
        calorie = line.chomp.to_i
        calorie_group_count = calorie_group_count + calorie
    end

    puts top_3_elves.take(3).sum
end

find_calorific_elves
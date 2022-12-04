SHAPES = {
    "A" => "ROCK",
    "B" => "PAPER",
    "C" => "SCISSORS",
}

RESULT_SCORES = {
    "X" => 0,
    "Y" => 3,
    "Z" => 6
}

WINNING_COMBOS = {
    "A" => "B",
    "B" => "C",
    "C" => "A"
}

LOSING_COMBOS = WINNING_COMBOS.invert

SHAPE_SCORES = {
    "A" => 1,
    "B" => 2,
    "C" => 3,
}

def calculate_strategy
    total_score = 0

    matches = read_matches_file
    matches.each do |match|
        match = match.split

        opponent = match.first
        desired_result = match.last
        total_score = total_score + score(opponent, desired_result)
    end

    total_score
end

def score(opponent, desired_result)
    shape = get_shape(opponent, desired_result)

    SHAPE_SCORES[shape] + RESULT_SCORES[desired_result]
end

def get_shape(opponent, desired_result)
    return opponent if draw?(desired_result)
    return WINNING_COMBOS[opponent] if win?(desired_result)
    LOSING_COMBOS[opponent]
end

def win?(desired_result)
    desired_result == "Z"
end

def draw?(desired_result)
    desired_result == "Y"
end

def lose?(desired_result)
    desired_result == "X"
end

def read_matches_file
    File.open("input.txt").readlines.map(&:chomp)
end


puts "total score for strategy is: #{calculate_strategy}"
#answer for input: 13022
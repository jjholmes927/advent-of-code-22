#Opponents choice
#A: ROCK
#B: PAPER
#C: SCISSORS

#Our choice
#X: ROCK
#Y: PAPER
#Z: SCISSORS


#First column is opponents choice second is ours
#Scoring outcomes
# WIN  6 points 
# DRAW 3 points 
# LOSE 0 points 

# Rock 1 point
# Paper 2 points
# Scissors 3 points

# read columns
# calulcate score for each row
# output sum of all rows


OPPONENT_SHAPE = {
    "A" => "ROCK",
    "B" => "PAPER",
    "C" => "SCISSORS",
}

MY_SHAPE = {
    "X" => "ROCK",
    "Y" => "PAPER",
    "Z" => "SCISSORS",
}

WINNING_COMBOS = {
    "X" => "C",
    "Y" => "A",
    "Z" => "B"
}

SHAPE_SCORES = {
    "X" => 1,
    "Y" => 2,
    "Z" => 3,
}

def calculate_strategy
    total_score = 0

    matches = read_matches_file
    matches.each do |match|
        match = match.split

        opponent = match.first
        mine = match.last
        total_score = total_score + score(opponent, mine)
    end

    total_score
end

def score(opponent, mine)
    shape_score = SHAPE_SCORES[mine]
    result_score = 0

    result_score = 6 if win?(opponent, mine)
    result_score = 3 if draw?(opponent, mine)

    shape_score + result_score
end

def win?(opponent, mine)
    WINNING_COMBOS[mine] == opponent
end

def draw?(opponent, mine)
    OPPONENT_SHAPE[opponent] == MY_SHAPE[mine]
end

def read_matches_file
    File.open("input.txt").readlines.map(&:chomp)
end


puts "total score for strategy is: #{calculate_strategy}"
#answer for input: 11841
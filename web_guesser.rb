# # This Sinatra project is a Web Guesser. 
# # The program chooses a secret number at random from 1 to 100. 
# # The user gets at most 7 guesses for the number.
# # For each guess, if the guess is more than 10 less than the secret number, 
# # the program says Your guess is much too low. If the guess is within 10,
# # but too low, the program says, your guess is close but too low. 
# # If the guess is within 10,but too high, the program says,
# # your guess is close but too high.If the guess is more than 10 too high, 
# # the program says, your guess is way too high. If the user guesses right, 
# # the program says you win, but if the user runs out of guesses, the program says you lose. 
# # The screen shows the list of guesses. If the user wins or loses, 
# # a screen is put up that announces the result, with a "play again" 
# # button at the bottom to restart the game.


require "sinatra"
set :bind,'0.0.0.0'

set :SECRET_NUMBER, rand(100)
@@guesses = 5 

get ("/")  do 
    "Test the first line of code "
    guess = params["guess"]
    cheat = params["cheat"]
    message = cheat =="true" ? "#{secret_number}" :process_guess(guess)
    color = get_color(message)
    erb :index, :locals =>  {:number =>secret_number, :message => message, :color => color}
end

def secret_number
    settings.SECRET_NUMBER
end

def process_guess(guess)
    @@guesses -=1
    message = compare_guess(guess) 
    if message[1..2] =="You"
        reset
        message
    elsif @@guesses == 0 
        reset
        "you lost. #{@@guesses} guesses remaining in a new game"
    else 
        message
    end
end

def reset 
    @@guesses = 5 
    settings.SECRET_NUMBER = random(100)
end

def compare_guess(guess)
    return "Please guess a number." if guess.nil? 
    guess = guess.to_i
    if guess > secret_number + 5 
        "way too high!"
    elsif guess < secret_number - 5 
         "way too low!"
    elsif guess > secret_number
        "too high!"
    elsif guess <secret_number 
        "too low!"
    else
        "you got it right! <br><br> The secret number was #{secret_number}.<br><br> the number has been reset"
    end 
end


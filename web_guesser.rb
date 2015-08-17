require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(0..100)

def responses(response)
  responses = {too_high: "Too high!", too_low: "Too low!", correct: "You are correct. Nice work!", out_of_guesses: "Sorry, you're out of guesses!"}
  responses[response]
end

def guesses
  @@guesses ||= []
end

def answer
  "The secret number is #{SECRET_NUMBER}"
end

def check_guess(guess)
  return responses(:out_of_guesses) if guesses.size > 4
  if guess.to_i > SECRET_NUMBER
    guesses << guess
    responses(:too_high)
  elsif guess.to_i < SECRET_NUMBER
    guesses << guess
    responses(:too_low)
  else guess.to_i == SECRET_NUMBER
    responses(:correct)
  end
end

get '/' do
  guess = params["guess"]
  response = check_guess(guess)
  erb :index, :locals => {:response => response, :guesses => guesses}
end

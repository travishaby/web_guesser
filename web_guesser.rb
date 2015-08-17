require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(0..100)

def responses(response)
  responses = {too_high: "Too high!", too_low: "Too low!", correct: "You are correct. Nice work!"}
  responses[response]
end

def guesses
  @guesses ||= []
end

def check_guess(guess)
  if guess.to_i > SECRET_NUMBER
    guesses << guess
    responses(:too_high)
  elsif guess.to_i < SECRET_NUMBER
    guesses << guess
    responses(:too_low)
  else
    responses(:correct)
  end
end

get '/' do
  guess = params["guess"]
  response = check_guess(guess)
  erb :index, :locals => {:response => response, :guesses => guesses}
end

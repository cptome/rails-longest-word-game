require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { charset = Array('A'..'Z').sample }.join
  end

  def included?(@palabra, @letters)
    @palabra.chars.all? { |letter| @palabra.count(letter) <= @letters.count(letter) }
  end

  def english_word?(word)
    @palabra = params[:palabra]
      url = "https://wagon-dictionary.herokuapp.com/#{@palabra}"
    user_serialized = open(url).read
    @user = JSON.parse(user_serialized)    
  end
  
  def score
    
    # verificar que use las letras originales (no esta hecho)
    # palabra_por_letra = @palabra.split(%r{\s*})
    # @palabra tenga include all @letters
    # enumaerable#all hace esto de alguna forma
    if @user["found"] == true
       @score = @user["length"]
    else
      @score = 0
    end
  end

end

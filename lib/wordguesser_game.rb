class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    word = word.downcase
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def guess(letter)
    if (letter =~ /[a-z]/i).nil?
      raise ArgumentError.new("Invalid letter")
    end
    letter = letter.downcase
    if @guesses.include? letter or @wrong_guesses.include? letter
      return false
    end
    if @word.include? letter
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    return true
  end
  
  def word_with_guesses
    result = ""
    @word.each_char do |ch|
      if @guesses.include? ch
        result += ch
      else
        result += "-"
      end
    end
    return result
  end
  
  def check_win_or_lose
    if @wrong_guesses.length >= 7
      return :lose
    end
    if word_with_guesses == @word
      return :win
    end
    return :play
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end

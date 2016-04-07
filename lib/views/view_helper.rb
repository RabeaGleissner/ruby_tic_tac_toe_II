module ViewHelper
  def convert_to_kebab_case(words)
    words.split( ).each {|word| word.downcase!}.join("-")
  end
end

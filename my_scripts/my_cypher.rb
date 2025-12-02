#!/usr/bin/env ruby

def generate_random_string(input_string)
  # Define the character set (a-z, A-Z, 0-9)
  chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
  
  # Generate random string of same length
  result = Array.new(input_string.length) { chars.sample }.join
  
  # Ensure result is different from input
  while result == input_string
    result = Array.new(input_string.length) { chars.sample }.join
  end
  
  result
end

# Get input from command line or prompt user
input = ARGV[0] || gets.chomp

# Generate and output the result
puts generate_random_string(input)

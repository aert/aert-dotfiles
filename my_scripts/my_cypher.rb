#!/usr/bin/env ruby

def xor_cipher(text, key, decrypt = false)
  # If no key provided, generate a random one
  if key.nil? || key.empty?
    key = generate_random_key(text.length)
    puts "Generated key: #{key}"
  end
  
  # Ensure key is the same length as text
  key = expand_key(key, text.length)
  
  if decrypt
    # For decryption, we XOR the ciphertext with the key again
    result = ""
    text.chars.each_with_index do |char, i|
      result += (char.ord ^ key[i].ord).chr
    end
    result
  else
    # For encryption, XOR the plaintext with the key
    result = ""
    text.chars.each_with_index do |char, i|
      result += (char.ord ^ key[i].ord).chr
    end
    result
  end
end

def generate_random_key(length)
  # Generate a random key of specified length using alphanumeric characters
  chars = ('a'..'z').to_a + ('0'..'9').to_a
  Array.new(length) { chars.sample }.join
end

def expand_key(key, target_length)
  # Repeat the key to match the target length
  key * (target_length / key.length) + key[0, target_length % key.length]
end

# Main execution
if __FILE__ == $0
  if ARGV.length < 1
    puts "Usage: ruby xor_cipher.rb <text> [key] [decrypt: 0|1]"
    puts "  text: The text to encrypt/decrypt"
    puts "  key: Optional secret key (if not provided, will be random)"
    puts "  decrypt: 0 for encrypt, 1 for decrypt (default: 0)"
    exit 1
  end

  text = ARGV[0]
  key = ARGV[1]
  decrypt = ARGV[2] ? (ARGV[2] == '1') : false

  begin
    result = xor_cipher(text, key, decrypt)
    puts "Original: #{text}"
    puts "Key: #{key || 'random'}"
    puts "Result: #{result}"
    
    if !decrypt && key.nil?
      # Show how to decrypt it back
      puts "\nTo decrypt, use:"
      puts "ruby xor_cipher.rb \"#{result}\" \"#{generate_random_key(text.length)}\" 1"
    end
  rescue => e
    puts "Error: #{e.message}"
  end
end

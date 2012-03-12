require 'ripple'

class Book
  include Ripple::Document

  property :title, String, :presence => true
  property :author, String, :presence => true
  property :summary, String, :presence => true
end


book = Book.new
book.title = 'The Well-Grounded Rubyist'
book.author = 'David Black'
book.summary = 'The Well-Grounded Rubyist takes you from interested novice to proficient practitioner.'

book.save

puts book.key

puts Book.find('erlang_otp_in_action').to_json

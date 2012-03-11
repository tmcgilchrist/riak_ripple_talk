require 'riak'

puts "Load Books into Riak"

client = Riak::Client.new
bucket = client.bucket("books")

json_data = {
  'erlang_otp_in_action' => {
    title: 'Erlang and OTP in Action',
    author: 'Logan Martin',
    summary: 'Erlang is an adaptable and fault tolerant functional programming language originally designed for the unique demands of the telecom industry'},
  'well_grounded_rubyist' => {
    title: 'The Well-Grounded Rubyist',
    author: 'David Black',
    summary: 'The Well-Grounded Rubyist takes you from interested novice to proficient practitioner.'},
  'machine_learning_in_action' => {
    title: 'Machine Learning in Action',
    author: 'Peter Harrington',
    summary: 'The ability to take raw data, access it, filter it, process it, visualize it, understand it, and communicate it to others is possibly the most essential business problem for the coming decades.'},
  'javascript_good_parts' => {
    title: 'JavaScript: The Good Parts',
    author: 'Douglas Crockford',
    summary: 'Most programming languages contain good and bad parts, but JavaScript has more than its share of the bad, having been developed and released in a hurry before it could be refined.'},
  'practical_common_lisp' =>  {
    title: 'Practial Commmon LISP',
    author: 'Peter Seibel',
    summary: 'Lisp is thought of as an academic language, but it need not be. This is the first book that introduces Lisp as a language for the real world and provides an overall understanding of the language features and how they work.'},
  'programming_erlang' => {
    title: 'Programming Erlang: Software for a Concurrent World',
    author: 'Joe Armstrong',
    summary: 'Erlang solves one of the most pressing problems facing developers today: how to write reliable, concurrent, high-performance systems.'}
}

json_data.each do |key, value|
  new_book = Riak::RObject.new(bucket, key)
  new_book.content_type = 'application/json'
  new_book.data = value
  new_book.store
end

require 'riak'

puts "Create a client connection"
client = Riak::Client.new

puts "Retrieve a bucket"
bucket = client.bucket("books")

puts "Create a new object"
new_book = Riak::RObject.new(bucket, "erlang_otp_in_action")
new_book.content_type = 'application/json'
new_book.data = "{title: 'Erlang and OTP in Action',
                  author: 'Logan Martin',
                  summary: 'Erlang is an adaptable and fault tolerant functional programming language originally designed for the unique demands of the telecom industry'}"

new_book.store

puts new_book.to_s

puts "List the keys in #{bucket.name} bucket"

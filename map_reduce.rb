require 'riak'

client = Riak::Client.new
bucket = client.bucket("books")
Riak.disable_list_keys_warnings = true

results = Riak::MapReduce.new(client).add("books").
  map("function(v) {
     var results = [];
     var book = JSON.parse(v.values[0].data);
     if (book.author == 'Joe Armstrong') {
       results.push(book);
     }
     return results;
  }", :keep => true).run

puts results

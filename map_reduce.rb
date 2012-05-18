require 'riak'

Riak.disable_list_keys_warnings = true

client = Riak::Client.new(:http_port => 8098)

# results = Riak::MapReduce.new(client).
#   add("room", "102").add("room", "103").add("room", "103").
#   map(" function(v) {
#   /* From the Riak object, pull data and parse it as JSON */
#   var parsed_data = JSON.parse(v.values[0].data);
#   var data = {};
#   /* Key capacity number by room style string */
#   data[parsed_data.style] = parsed_data.capacity;
#   return [data];
# }
# ", :keep => true).run

results = Riak::MapReduce.new(client).
  add("room").
  link(:bucket => "room").
  map(" function(v) {
  /* From the Riak object, pull data and parse it as JSON */
  var parsed_data = JSON.parse(v.values[0].data);
  var data = {};
  /* Key capacity number by room style string */
  data[parsed_data.style] = parsed_data.capacity;
  return [data];
}
", :keep => true).run

puts "Results\n"
puts results.to_json

{
  "inputs":[
    ["room","101"],["room","102"],["room","103"]
], "query":[
    {"map":{
      "language":"javascript",
      "bucket":"my_functions",
      "key":"map_capacity"
}} ]
}

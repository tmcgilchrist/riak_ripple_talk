require 'riak'

client = Riak::Client.new(:http_port => 8098)

results = Riak::MapReduce.new(client).
  add("alice", "p1").add("alice", "p2").
  map("function(v) {
  var m = v.values[0].data.toLowerCase().match(/\w*/g);
  var r = [];
  for(var i in m) {
    if(m[i] != '') {
      var o = {};
      o[m[i]] = 1;
      r.push(o);
    }
  }
  return r;
}").reduce("function(v) {
  var r = {};
  for(var i in v) {
    for(var w in v[i]) {
      if(w in r) r[w] += v[i][w];
      else r[w] = v[i][w];
    }
  }
  return [r];
}", :keep => true).run

puts "Results:"
puts results

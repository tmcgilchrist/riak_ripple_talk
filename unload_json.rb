require 'riak'

client = Riak::Client.new
bucket = client.bucket("books")

keys = ['erlang_otp_in_action', 'well_grounded_rubyist', 'machine_learning_in_action', 'javascript_good_parts',
        'practical_common_lisp', 'programming_erlang']

keys.each do |key|
  bucket.delete(key)
end

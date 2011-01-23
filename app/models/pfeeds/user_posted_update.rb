class Pfeeds::UserPostedUpdate < PfeedItem
def pack_data(method_name, method_name_in_past_tense, returned_result, *args_supplied_to_method, &block_supplied_to_method)
     self.data = {} if ! self.data

     update = Update.find(returned_result)

     hash_to_be_merged = {:update => update.text }
     self.data.merge!  hash_to_be_merged
     super
  end
end
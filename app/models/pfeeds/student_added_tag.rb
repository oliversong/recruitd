class Pfeeds::StudentAddedTag < PfeedItem
def pack_data(method_name, method_name_in_past_tense, returned_result, *args_supplied_to_method, &block_supplied_to_method)
     self.data = {} if ! self.data

     #update = Update.find(returned_result)
     term = args_supplied_to_method[0]
     pronoun = (returned_result ? "his" : "her")

     hash_to_be_merged = {:term_name => term.name, :term_id => term.id, :pronoun => pronoun }
     self.data.merge!  hash_to_be_merged
     super
  end
end
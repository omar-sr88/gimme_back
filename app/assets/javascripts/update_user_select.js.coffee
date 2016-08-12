$('.chosen-select).html(<%= options_from_collection_for_select(@users, :id, :name) %>);

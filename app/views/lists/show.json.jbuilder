json.partial! 'lists/list', list: @list
json.contacts do
  json.array! @list.contacts do |contact|
    json.id contact.id
    json.firstname contact.firstname
    json.lastname contact.lastname
    json.phone contact.phone
  end
end

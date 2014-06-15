json.total @lists.length
json.lists do
  json.array! @lists do |list|
    json.extract! list, :id, :name, :position
    json.contacts do
      json.array! list.contacts do |contact|
        json.id contact.id
        json.firstname contact.firstname
        json.lastname contact.lastname
        json.phone contact.phone
        json.list_id list.id
      end
    end
  end
end
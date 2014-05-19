require 'spec_helper'

describe '/lists endpoints' do

  valid_contact   = { lastname: "Guez", firstname: "Benjamin", phone: 5555566666 }
  invalid_contact = { lastname: "g", firstname: "b", phone: 'not_a_number' }

  before(:each) do
    @list     = FactoryGirl.create(:list, name: 'friends', position: 0)
    @contact1 = create(:contact, list_id: @list.id)
    @contact2 = create(:contact, list_id: @list.id)
    @list2    = FactoryGirl.create(:list, name: 'family', position: 1)
    @contact3 = create(:contact, list_id: @list2.id)
  end

  it "should have contacts" do
    get "/lists/#{@list.id}/contacts.json"
    @list.reload

    expect(response.status).to be == 200
    expected_json = @list.contacts.map { |c| {
        "id"        => c.id,
        "list_id"   => @list.id,
        "lastname"  => c.lastname,
        "firstname" => c.firstname,
        "phone"     => c.phone
      }
    }
    expect(response_json).to eq expected_json
  end

  it "should retrieve one contact from a list" do
    get "/lists/#{@list.id}/contacts/#{@contact1.id}.json"

    expect(response.status).to be == 200
    expect(response_json).to eq({
      "id"        => @contact1.id,
      "list_id"   => @list.id,
      "lastname"  => @contact1.lastname,
      "firstname" => @contact1.firstname,
      "phone"     => @contact1.phone,
    })
  end

  it "should not retrieve a contact that doesn't belongs to the list" do
    get "/lists/#{@list.id}/contacts/#{@contact3.id}.json"

    expect(response.status).to be == 404
  end

  it "should destroy a contact from a list" do
    delete "/lists/#{@list2.id}/contacts/#{@contact3.id}.json"

    expect(response.status).to be == 204
    expect(@list2.contacts).to have_exactly(0).items
  end

  it "should update a contact from a list" do
    patch "lists/#{@list2.id}/contacts/#{@contact3.id}.json", { contact: { firstname: "firstname Edit",
                                                                lastname: "lastname Edit",
                                                                phone: 312313223132 } }

    expect(response.status).to be == 200
    expect(response_json).to eq({
      "id"        => @contact3.id,
      "list_id"   => @list2.id,
      "lastname"  => "lastname Edit",
      "firstname" => "firstname Edit",
      "phone"     => "312313223132"
    })
  end

  it "should not update a contact from a list (bad input)" do
    patch "lists/#{@list2.id}/contacts/#{@contact3.id}.json", { contact: invalid_contact }

    expect(response.status).to be == 400
    expect(response_json.keys).to include('error')
    expect(response_json['error'].keys).to include('firstname', 'lastname', 'phone')
  end

  it "should create a new contact in a list" do
    post "lists/#{@list2.id}/contacts.json", { contact: valid_contact }

    expect(response.status).to be == 201
    expect(response_json).to eq({
      "id"        => @list2.contacts.last.id,
      "list_id"   => @list2.id,
      "lastname"  => "Guez",
      "firstname" => "Benjamin",
      "phone"     => "5555566666"
    })

    @list2.reload
    expect(@list2.contacts_count).to be == 2
  end

  it "should fail to create a new contact in a list" do
    post "lists/#{@list2.id}/contacts.json", { contact: invalid_contact }

    expect(response.status).to be == 400
    expect(response_json.keys).to include('error')
    expect(response_json['error'].keys).to include('firstname', 'lastname', 'phone')
  end

end
require 'spec_helper'

describe 'Contact resource' do

  valid_contact   = { lastname: "Guez", firstname: "Benjamin", phone: 5555566666 }
  invalid_contact = { lastname: "g", firstname: "b", phone: 'not_a_number' }

  before(:each) do
    @list     = FactoryGirl.create(:list, name: 'friends', position: 0)
    @contact1 = create(:contact, list_id: @list.id)
    @contact2 = create(:contact, list_id: @list.id)
    @list2    = FactoryGirl.create(:list, name: 'family', position: 1)
    @contact3 = create(:contact, list_id: @list2.id)
  end

  it "GET /lists/:list_id/contacts" do
    get "/lists/#{@list.id}/contacts"
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

  it "GET /lists/:list_id/contacts/:contact_id" do
    get "/lists/#{@list.id}/contacts/#{@contact1.id}"

    expect(response.status).to be == 200
    expect(response_json).to eq({
      "id"        => @contact1.id,
      "list_id"   => @list.id,
      "lastname"  => @contact1.lastname,
      "firstname" => @contact1.firstname,
      "phone"     => @contact1.phone,
    })
  end

  it "GET /lists/:list_id/contacts/:contact_id (404 - contact doesnt belong to the list)" do
    get "/lists/#{@list.id}/contacts/#{@contact3.id}"

    expect(response.status).to be == 404
  end

  it "DELETE /lists/:list_id/contacts/:contact_id" do
    delete "/lists/#{@list2.id}/contacts/#{@contact3.id}"

    expect(response.status).to be == 204
    expect(@list2.contacts).to have_exactly(0).items
  end

  it "PATCH /lists/:list_id/contacts/:contact_id" do
    patch "lists/#{@list2.id}/contacts/#{@contact3.id}", { contact: { firstname: "firstname Edit",
                                                                lastname: "lastname Edit",
                                                                phone: "42424242" } }

    expect(response.status).to be == 200
    expect(response_json).to eq({
      "id"        => @contact3.id,
      "list_id"   => @list2.id,
      "lastname"  => "lastname Edit",
      "firstname" => "firstname Edit",
      "phone"     => "42424242"
    })
  end

  it "PATCH /lists/:list_id/contacts/:contact_id (400 - bad input)" do
    patch "lists/#{@list2.id}/contacts/#{@contact3.id}", { contact: invalid_contact }

    expect(response.status).to be == 400
    expect(response_json.keys).to include('error')
    expect(response_json['error'].keys).to include('firstname', 'lastname', 'phone')
  end

  it "POST /lists/:list_id/contacts" do
    post "lists/#{@list2.id}/contacts", { contact: valid_contact }

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

  it "POST /lists/:list_id/contacts (400 - bad input)" do
    post "lists/#{@list2.id}/contacts", { contact: invalid_contact }

    expect(response.status).to be == 400
    expect(response_json.keys).to include('error')
    expect(response_json['error'].keys).to include('firstname', 'lastname', 'phone')
  end

end
require 'spec_helper'

describe 'List resource' do

  before(:each) do
    @list1    = create(:list, name: 'friends', position: 0)
    @contact1 = create(:contact, list_id: @list1.id)
    @contact2 = create(:contact, list_id: @list1.id)
    create(:list, name: 'family', position: 1)
  end

  it "POST /lists" do
    post '/lists', { list: { name: 'Work.', position: 42 } }

    last_list = List.last

    expect(response.status).to be == 201
    expect(List.all.length).to be == 3
    expect(last_list.id).to eq 3
    expect(last_list.name).to eq 'Work.'
    expect(last_list.position).to eq 42
  end

  it "POST /lists (invalid)" do
    post '/lists', { list: { name: 'Work.', position: 'end' } }

    expect(List.all.length).to be == 2
    expect(response.status).to be == 400
    expect(response_json.keys).to include('error')
    expect(response_json['error'].keys).to include('position')
  end

  it "GET /lists" do
    get '/lists'

    expect(response.status).to be == 200
    expect(response_json).to eq(
      {
        'total'   => 2,
        'lists'   => [{
          'id'       => 1,
          'name'     => 'friends',
          'position' => 0,
          'contacts' => [
            { 'id' => @contact1.id, 'lastname' => @contact1.lastname,  'firstname' => @contact1.firstname, 'phone' => @contact1.phone },
            { 'id' => @contact2.id, 'lastname' => @contact2.lastname,  'firstname' => @contact2.firstname, 'phone' => @contact2.phone }
          ]
          }, {
          'id'       => 2,
          'name'     => 'family',
          'position' => 1,
          'contacts' => []
        }]
      }
    )
  end

  it "GET /lists/:id" do
    get '/lists/2'

    expect(response.status).to be == 200
    expect(response_json).to eq({
      'id'       => 2,
      'name'     => 'family',
      'position' => 1,
      'contacts' => []
    })
  end

  it "GET /lists/:id (doesnt exist)" do
    get '/lists/42'

    expect(response.status).to be == 404
    expect(response_json).to eq({
      'error'       => 'resource not found.'
    })
  end

  it "DELETE /lists/:id" do
    delete '/lists/2'

    expect(response.status).to be == 204
    expect(response.body).to eq ""
  end

  it "DELETE /lists/:id (doesnt exist)" do
    delete '/lists/42'

    expect(response.status).to be == 404
    expect(response_json).to eq({
      'error'       => 'resource not found.'
    })
  end

  it "PATCH /lists/:id" do
    patch '/lists/2', { list: { name: 'family edit.', position: 42 } }

    expect(response.status).to be == 200
    expect(response_json).to eq({
      'id'       => 2,
      'name'     => 'family edit.',
      'position' => 42
    })
  end

  it "PATCH /lists/:id (invalid input)" do
    patch '/lists/2', { list: { name: 'family edit.', position: 'end' } }

    expect(response.status).to be == 400
    expect(response_json.keys).to include('error')
    expect(response_json['error'].keys).to include('position')
  end

  it "PATCH /lists/:id (doesnt exist)" do
    patch '/lists/42', { list: { name: 'family edit.', position: 42 } }

    expect(response.status).to be == 404
    expect(response_json).to eq({
      'error'       => 'resource not found.'
    })
  end

end
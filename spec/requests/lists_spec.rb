require 'spec_helper'

describe 'GET /lists' do

  before(:each) do
    create(:list, name: 'friends', position: 0)
    create(:list, name: 'family', position: 1)
  end

  it "should create a list" do
    post '/lists.json', { list: { name: 'Work.', position: 42 } }

    last_list = List.last

    expect(response.status).to be == 201
    expect(List.all.length).to be == 3
    expect(last_list.id).to eq 3
    expect(last_list.name).to eq 'Work.'
    expect(last_list.position).to eq 42
  end

  it "should not create a list (bad position)" do
    post '/lists.json', { list: { name: 'Work.', position: 'end' } }

    expect(List.all.length).to be == 2
    expect(response.status).to be == 400
  end

  it "should return the Lists" do
    get '/lists.json'

    expect(response.status).to be == 200
    expect(response_json).to eq(
      [{
        'id'       => 1,
        'name'     => 'friends',
        'position' => 0
      }, {
        'id'       => 2,
        'name'     => 'family',
        'position' => 1
      }]
    )
  end

  it "should retrieve the family List" do
    get '/lists/2.json'

    expect(response.status).to be == 200
    expect(response_json).to eq({
      'id'       => 2,
      'name'     => 'family',
      'position' => 1
    })
  end

  it "should retrieve fail to retrieve List that doesn't exist" do
    get '/lists/42.json'

    expect(response.status).to be == 404
    expect(response_json).to eq({
      'error'       => 'resource not found.'
    })
  end

  it "should destroy an existing List" do
    delete '/lists/2.json'

    expect(response.status).to be == 204
    expect(response.body).to eq ""
  end

  it "should fail to destroy an non existing List" do
    delete '/lists/42.json'

    expect(response.status).to be == 404
    expect(response_json).to eq({
      'error'       => 'resource not found.'
    })
  end

  it "should update existing List" do
    patch '/lists/2.json', { list: { name: 'family edit.', position: 42 } }

    expect(response.status).to be == 200
    expect(response_json).to eq({
      'id'       => 2,
      'name'     => 'family edit.',
      'position' => 42
    })
  end

  it "should fail to update non existing List" do
    patch '/lists/42.json', { list: { name: 'family edit.', position: 42 } }

    expect(response.status).to be == 404
    expect(response_json).to eq({
      'error'       => 'resource not found.'
    })
  end

end
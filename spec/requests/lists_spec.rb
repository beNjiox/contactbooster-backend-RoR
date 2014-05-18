require 'spec_helper'

describe 'GET /lists' do
  it "should return empty list" do
    get '/lists.json'

    expect(response.status).to be == 200
    expect(response_json).to eq []
  end

  it "should return not empty list" do
    create(:list)
    get '/lists.json'

    expect(response.status).to be == 200
    expect(response_json.length).to be == 1
    expect(response_json).to eq(
      [{
        "id"       => 1,
        "name"     => "Jake",
        "position" => 0
      }]
    )
  end
end
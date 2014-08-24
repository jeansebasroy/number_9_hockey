require 'rails_helper'

RSpec.describe "DateTimeLocationPages", :type => :request do
  describe "GET /date_time_location_pages" do
    it "works! (now write some real specs)" do
      get date_time_location_pages_index_path
      expect(response.status).to be(200)
    end
  end
end

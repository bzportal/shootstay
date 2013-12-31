require 'spec_helper'

describe HomeownersController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET '_create'" do
    it "returns http success" do
      get '_create'
      response.should be_success
    end
  end

  describe "GET '_modify'" do
    it "returns http success" do
      get '_modify'
      response.should be_success
    end
  end

end

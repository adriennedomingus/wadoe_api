require 'rails_helper'

RSpec.describe Api::V1::StudentIdentifiersController, type: :controller do
  describe "GET index" do
    it "returns the names of all student identifiers" do
      student_identifiers = ['female',
        'male',
        'american indian or alaskan native',
        'asian',
        'asian pacific islander',
        'black or african american',
        'hispanic or latino',
        'pacific islander',
        'two or more races',
        'white','foster care',
        'free or reduced price lunch',
        'homeless',
        'transitional bilingual',
        'title i migrant',
        'section 504',
        'special education']

      student_identifiers.each do |student_identifier|
        StudentIdentifier.create(name: student_identifier)
      end

      get :index, format: :json

      student_identifiers_response = JSON.parse(response.body)
      expect(student_identifiers_response).to eq(student_identifiers)
    end
  end
end

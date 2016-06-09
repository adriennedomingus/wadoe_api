require 'rails_helper'

RSpec.describe Api::V1::Graduation::DistrictsController, type: :controller do
  describe "GET show" do
    it "returns a specific districts demographic information" do
      user = User.create(email: "example@example.com", password: "password", api_key: "abc123")
      school_year, _, _, district = create_district_and_demographic_data

      get :show, slug: district.slug, year: school_year.years, api_key: user.api_key, format: :json
      district_demographics = JSON.parse(response.body)
      result = {
        "graduation" => [ {"gender"=>
                              {"female"=>{ "began_9_in_wa"=>234,
                                           "transferred_into_wa"=>234,
                                           "transferred_out"=>234,
                                           "graduates"=>234,
                                           "continuing"=>234,
                                           "adjusted_five_year_cohort_graduation_rate"=>234,
                                           "cohort_dropout_percent"=>234,
                                           "continuing_percent"=>234,
                                           "dropouts"=>{ "yeear1" => 208,
                                                         "year2" => 103,
                                                         "year3" => 103,
                                                         "year4" => 103,
                                                         "year5" => 103,
                                                         }},
                               "male"=>{ "number"=>276,
                                         "percent"=>50.8}}},
                            {"race ethnicity"=>
                              {"american indian or alaskan native"=>{ "number"=>134,
                                                                      "percent"=>14.2},
                                "asian"=>{ "number"=>362,
                                           "percent"=>12.3},
                                "asian pacific islander"=>{ "number"=>12,
                                                            "percent"=>41.1},
                                "black or african american"=>{ "number"=>144,
                                                               "percent"=>13.4},
                                "hispanic or latino"=>{ "number"=>123,
                                                        "percent"=>45.3},
                                "pacific islander"=>{ "number"=>34,
                                                      "percent"=>13.3},
                                "two or more races"=>{ "number"=>132,
                                                       "percent"=>12.8},
                                "white"=>{ "number"=>145,
                                           "percent"=>54.5}}},
                            {"other"=>
                              {"foster care"=>{ "number"=>16,
                                                "percent"=>1.2},
                                "free or reduced price lunch"=>{ "number"=>543,
                                                                 "percent"=>84.5},
                                "transitional bilingual"=>{ "number"=>45,
                                                            "percent"=>10.1},
                                "title i migrant"=>{ "number"=>172,
                                                     "percent"=>1.7}}},
                            {"exceptional student services"=>{
                                "section 504"=>{ "number"=>124,
                                                 "percent"=>3.3},
                                "special education"=>{ "number"=>235,
                                                       "percent"=>10.2}}}],
       "district" => { "name"=>"Auburn School District",
                        "number"=>"17408",
                        "slug"=>"auburn-school-district" },
       "school_year" => { "years"=>"2015-16" },
       "student_enrollment" => {
                                  "total"=>1378,
                                  "students_per_classroom_teacher"=>18},
                                }

      expect(district_demographics).to eq(result)
      expect(response.code).to eq("200")

    end

    it "responds with error if school year doesn't exist" do
      user = User.create(email: "example@example.com", password: "password", api_key: "abc123")
      _, _, _, district = create_district_and_demographic_data

      get :show, slug: district.slug, year: "2014-15", api_key: user.api_key, format: :json

      expected_response = {
        message: "We do not have data for that school year. Please try another query.",
        status: 404
      }.to_json

      expect(response.body).to eq(expected_response)
      expect(response.code).to eq("404")
    end

    it "responds with error if school district doesn't exist" do
      user = User.create(email: "example@example.com", password: "password", api_key: "abc123")
      create_district_and_demographic_data

      get :show, slug: 'fake-school-district', year: "2015-16", api_key: user.api_key, format: :json

      expected_response = {
        message: "We do not have that school district in our system. Please try another query",
        status: 404
      }.to_json

      expect(response.body).to eq(expected_response)
      expect(response.code).to eq("404")
    end

    it "requires a valid API key" do
      school_year, _, _, district = create_district_and_demographic_data


      get :show, slug: district.slug, year: school_year.years, format: :json

      expected_response = { message: "Please include a valid API key with your request", status: 401 }.to_json

      expect(response.code).to eq("401")
      expect(expected_response).to eq(response.body)
    end
  end
end

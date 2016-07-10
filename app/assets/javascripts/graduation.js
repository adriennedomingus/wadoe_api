function getGradData(districtSlug, schoolYear, stateGradData) {
  if (districtSlug) {
    $.ajax({
      type: "GET",
      url: "/api/v1/graduation/district-in-year?slug=" + districtSlug + "&year=" + schoolYear + "&api_key=0220bd8b0679cb75ed9fe67d57089740",
      dataType: "json",
      success: function(data) {
        var districtGradData = [ parseFloat(data.graduation[0]["race ethnicity"]["american indian or alaskan native"]["adjusted_five_year_cohort_graduation_rate"]),
                              parseFloat(data.graduation[0]["race ethnicity"]["asian"]["adjusted_five_year_cohort_graduation_rate"]),
                              parseFloat(data.graduation[0]["race ethnicity"]["asian pacific islander"]["adjusted_five_year_cohort_graduation_rate"]),
                              parseFloat(data.graduation[0]["race ethnicity"]["black or african american"]["adjusted_five_year_cohort_graduation_rate"]),
                              parseFloat(data.graduation[0]["race ethnicity"]["hispanic or latino"]["adjusted_five_year_cohort_graduation_rate"]),
                              parseFloat(data.graduation[0]["race ethnicity"]["two or more races"]["adjusted_five_year_cohort_graduation_rate"]),
                              parseFloat(data.graduation[0]["race ethnicity"]["white"]["adjusted_five_year_cohort_graduation_rate"]),
                              parseFloat(data.graduation[3]["gender"]["female"]["adjusted_five_year_cohort_graduation_rate"]),
                              parseFloat(data.graduation[3]["gender"]["male"]["adjusted_five_year_cohort_graduation_rate"]),
                              parseFloat(data.graduation[2]["other"]["free or reduced price lunch"]["adjusted_five_year_cohort_graduation_rate"]),
                              parseFloat(data.graduation[2]["other"]["transitional bilingual"]["adjusted_five_year_cohort_graduation_rate"]),
                              parseFloat(data.graduation[2]["other"]["title i migrant"]["adjusted_five_year_cohort_graduation_rate"]),
                              parseFloat(data.graduation[1]["exceptional student services"]["section 504"]["adjusted_five_year_cohort_graduation_rate"]),
                              parseFloat(data.graduation[1]["exceptional student services"]["special education"]["adjusted_five_year_cohort_graduation_rate"]),
                            ];
        createGraduationHighChart(stateGradData, districtGradData, schoolYear);
      }
    });
  } else {
    createGraduationHighChart(stateGradData, [], schoolYear);
  }
}

function getStateGradData(schoolYear, districtSlug){
  $.ajax({
    type: "GET",
    url: "/api/v1/graduation/statewide-in-year?year=" + schoolYear + "&api_key=0220bd8b0679cb75ed9fe67d57089740",
    dataType: "json",
    success: function(data) {
      var stateGradData = [ parseFloat(data.graduation[0]["race ethnicity"]["american indian or alaskan native"]["percent"]),
                            parseFloat(data.graduation[0]["race ethnicity"]["asian"]["percent"]),
                            parseFloat(data.graduation[0]["race ethnicity"]["asian pacific islander"]["percent"]),
                            parseFloat(data.graduation[0]["race ethnicity"]["black or african american"]["percent"]),
                            parseFloat(data.graduation[0]["race ethnicity"]["hispanic or latino"]["percent"]),
                            parseFloat(data.graduation[0]["race ethnicity"]["two or more races"]["percent"]),
                            parseFloat(data.graduation[0]["race ethnicity"]["white"]["percent"]),
                            parseFloat(data.graduation[3]["gender"]["female"]["percent"]),
                            parseFloat(data.graduation[3]["gender"]["male"]["percent"]),
                            parseFloat(data.graduation[2]["other"]["free or reduced price lunch"]["percent"]),
                            parseFloat(data.graduation[2]["other"]["transitional bilingual"]["percent"]),
                            parseFloat(data.graduation[2]["other"]["title i migrant"]["percent"]),
                            parseFloat(data.graduation[1]["exceptional student services"]["section 504"]["percent"]),
                            parseFloat(data.graduation[1]["exceptional student services"]["special education"]["percent"]),
                          ];

      getGradData(districtSlug, schoolYear, stateGradData);
    }
  });
}

function getDistrictAndSchoolYearGrad(){
  var districtSlug;
  var schoolYear = '2013-14';
  getStateGradData(schoolYear);
  $('#grad-district_slug').change(function(){
    districtSlug = this.value;
    getStateGradData(schoolYear, districtSlug);
  });
  $('.school-year-button').click(function(){
    schoolYear = this.id;
    getStateGradData(schoolYear, districtSlug);
  });
}

function createGraduationHighChart(stateGradData, districtGradData, schoolYear){
  $('#state-district-graduation').highcharts(
    graduationChartDetails(stateGradData, districtGradData, schoolYear)
  );
}

function graduationChartDetails(stateGradData, districtGradData, schoolYear){
  return {chart: {
            type: 'column'
        },
        title: {
            text: '5-Year Graduation Rate: ' + schoolYear
        },
        xAxis: {
            categories: categories,
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: '5-Year Graduation Rate'
            }
        },

        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: [{
            name: 'District',
            data: districtGradData

        }, {
            name: 'State',
            data: stateGradData

        }]
      };
}

var categories = [
  'american indian or alaskan native',
  'asian',
  'asian pacific islander',
  'black or african american',
  'hispanic or latino',
  'two or more races',
  'white',
  'female',
  'male',
  'free or reduced price lunch',
  'transitional bilingual',
  'title i migrant',
  'section 504',
  'special education'];

function getGradData(districtSlug, schoolYear, stateGradData) {
  if (districtSlug) {
    $.getJSON("/api/v1/graduation/district-in-year?slug=" + districtSlug + "&year=" + schoolYear + "&api_key=0220bd8b0679cb75ed9fe67d57089740", function(data) {
      var districtGradData = getPercentagePoints(data, "adjusted_five_year_cohort_graduation_rate");
      createGraduationHighChart(stateGradData, districtGradData, schoolYear);
    });
  } else {
    createGraduationHighChart(stateGradData, [], schoolYear);
  }
}

function getStateGradData(schoolYear, districtSlug){
  $.getJSON("/api/v1/graduation/statewide-in-year?year=" + schoolYear + "&api_key=0220bd8b0679cb75ed9fe67d57089740", function(data) {
    var stateGradData = getPercentagePoints(data, "percent");
    getGradData(districtSlug, schoolYear, stateGradData);
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

function getPercentagePoints(data, subCategory){
  return [ parseFloat(data.graduation[0]["race ethnicity"]["american indian or alaskan native"][subCategory]),
                        parseFloat(data.graduation[0]["race ethnicity"]["asian"][subCategory]),
                        parseFloat(data.graduation[0]["race ethnicity"]["asian pacific islander"][subCategory]),
                        parseFloat(data.graduation[0]["race ethnicity"]["black or african american"][subCategory]),
                        parseFloat(data.graduation[0]["race ethnicity"]["hispanic or latino"][subCategory]),
                        parseFloat(data.graduation[0]["race ethnicity"]["two or more races"][subCategory]),
                        parseFloat(data.graduation[0]["race ethnicity"]["white"][subCategory]),
                        parseFloat(data.graduation[3]["gender"]["female"][subCategory]),
                        parseFloat(data.graduation[3]["gender"]["male"][subCategory]),
                        parseFloat(data.graduation[2]["other"]["free or reduced price lunch"][subCategory]),
                        parseFloat(data.graduation[2]["other"]["transitional bilingual"][subCategory]),
                        parseFloat(data.graduation[2]["other"]["title i migrant"][subCategory]),
                        parseFloat(data.graduation[1]["exceptional student services"]["section 504"][subCategory]),
                        parseFloat(data.graduation[1]["exceptional student services"]["special education"][subCategory]),
                      ]
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

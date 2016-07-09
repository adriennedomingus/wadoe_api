function getGradData(districtSlug, schoolYear) {
  $.ajax({
    type: "GET",
    url: "/api/v1/demographics/district-in-year?slug=" + districtSlug + "&year=" + schoolYear + "&api_key=0220bd8b0679cb75ed9fe67d57089740",
    dataType: "json",
    success: function(data) {
      debugger
      var demData = data.graduation[0]["race ethnicity"];
      var chartTitle = data.district.name + ": " + schoolYear;
      createGraduationHighChart('#district-graduation', demData, chartTitle);
    }
  });
}

function getStateGradData(schoolYear){
  $.ajax({
    type: "GET",
    url: "/api/v1/graduation/statewide-in-year?year=" + schoolYear + "&api_key=0220bd8b0679cb75ed9fe67d57089740",
    dataType: "json",
    success: function(data) {
      // debugger
      var stateGradData = [ parseFloat(data.graduation[0]["race ethnicity"]["american indian or alaskan native"]["percent"]),
                            parseFloat(data.graduation[0]["race ethnicity"]["asian"]["percent"]),
                            parseFloat(data.graduation[0]["race ethnicity"]["asian pacific islander"]["percent"]),
                            parseFloat(data.graduation[0]["race ethnicity"]["black or african american"]["percent"]),
                            parseFloat(data.graduation[0]["race ethnicity"]["hispanic or latino"]["percent"]),
                            parseFloat(data.graduation[0]["race ethnicity"]["pacific islander"]["percent"]),
                            parseFloat(data.graduation[0]["race ethnicity"]["two or more races"]["percent"]),
                            parseFloat(data.graduation[0]["race ethnicity"]["white"]["percent"]),
                            parseFloat(data.graduation[3]["gender"]["female"]["percent"]),
                            parseFloat(data.graduation[3]["gender"]["male"]["percent"]),
                            parseFloat(data.graduation[2]["other"]["foster care"]["percent"]),
                            parseFloat(data.graduation[2]["other"]["free or reduced price lunch"]["percent"]),
                            parseFloat(data.graduation[2]["other"]["homeless"]["percent"]),
                            parseFloat(data.graduation[2]["other"]["transitional bilingual"]["percent"]),
                            parseFloat(data.graduation[2]["other"]["title i migrant"]["percent"]),
                            parseFloat(data.graduation[1]["exceptional student services"]["section 504"]["percent"]),
                            parseFloat(data.graduation[1]["exceptional student services"]["special education"]["percent"]),
                          ];
      // var chartTitle = "State Averages: " + schoolYear;
      // createGraduationHighChart('#state-graduation', demData, chartTitle);
    }
  });
}

function getDistrictAndSchoolYearGrad(){
  var districtSlug = 'seattle-public-schools';
  var schoolYear = '2013-14';
  $('#district_slug').change(function(){
    districtSlug = this.value;
    getGradData(districtSlug, schoolYear);
    getStateGradData(schoolYear);
  });
  $('.school-year-button').click(function(){
    schoolYear = this.id;
    getGradData(districtSlug, schoolYear);
    getStateGradData(schoolYear);
  });
}

var categories = [
  'american indian or alaskan native',
  'asian',
  'asian pacific islander',
  'black or african american',
  'hispanic or latino',
  'pacific islander',
  'two or more races',
  'white',
  'female',
  'male',
  'foster care',
  'free or reduced price lunch',
  'homeless',
  'transitional bilingual',
  'title i migrant',
  'section 504',
  'special education'];

function graduationChartDetails(demData, chartTitle){
  var chartData = formatChartData(demData);
  return {chart: {
            type: 'column'
        },
        title: {
            text: '5-Year Graduation Rate for State and'
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
            data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4, 34, 35, 65, 7, 65]

        }, {
            name: 'State',
            data: [83.6, 78.8, 98.5, 93.4, 106.0, 84.5, 105.0, 104.3, 91.2, 83.5, 106.6, 92.3, 34, 35, 65, 7, 65]

        }]
      };
}

function createGraduationHighChart(divName, demData, chartTitle){
  $(divName).highcharts(
    graduationChartDetails(demData, chartTitle)
  );
}

function formatGraduationChartData(demData){
  var keys = [];
  for (var key in demData) {
    keys.push(key);
  }
  var chartData = [];
  for (var i = 0; i < keys.length; i ++) {
    var studentIdentifier = keys[i];
    var dataNumber = demData[keys[i]].number;
    chartData.push({ name :studentIdentifier, y: dataNumber });
  }
  return chartData;
}

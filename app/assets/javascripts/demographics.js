$( document ).ready(function() {
  getDistrictAndSchoolYear();
  getStateData("2013-14");
});

function getData(districtSlug, schoolYear) {
  $.ajax({
    type: "GET",
    url: "/api/v1/demographics/district-in-year?slug=" + districtSlug + "&year=" + schoolYear + "&api_key=0220bd8b0679cb75ed9fe67d57089740",
    dataType: "json",
    success: function(data) {
      var demData = data.demographics[0]["race ethnicity"];
      var chartTitle = data.district.name + ": " + schoolYear;
      createHighChart('#district-demographics', demData, chartTitle);
    }
  });
}

function getStateData(schoolYear){
  $.ajax({
    type: "GET",
    url: "/api/v1/demographics/statewide-in-year?year=" + schoolYear + "&api_key=0220bd8b0679cb75ed9fe67d57089740",
    dataType: "json",
    success: function(data) {
      var demData = data.demographics[0]["race ethnicity"];
      var chartTitle = "State Averages: " + schoolYear;
      createHighChart('#state-demographics', demData, chartTitle);
    }
  });
}

function getDistrictAndSchoolYear(){
  var districtSlug = 'seattle-public-schools';
  var schoolYear = '2013-14';
  $('#district_slug').change(function(){
    districtSlug = this.value;
    getData(districtSlug, schoolYear);
    getStateData(schoolYear);
  });
  $('.school-year-button').click(function(){
    schoolYear = this.id;
    getData(districtSlug, schoolYear);
    getStateData(schoolYear);
  });
}

function demographicsChartDetails(demData, chartTitle){
  var chartData = formatChartData(demData);
  return {chart: {
    type: 'pie'
  },
  title: {
    text: chartTitle
  },
  series: [{
    name: 'Number of students:',
    colorByPoint: true,
    data: chartData
  }]};
}

function createHighChart(divName, demData, chartTitle){
  $(divName).highcharts(
    demographicsChartDetails(demData, chartTitle)
  );
}

function formatChartData(demData){
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

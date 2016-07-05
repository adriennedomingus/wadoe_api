$( document ).ready(function() {
  getDistrict();
});

function getData(districtSlug, schoolYear) {
  $.ajax({
    type: "GET",
    url: "/api/v1/demographics/district-in-year?slug=" + districtSlug + "&year=" + schoolYear + "&api_key=60e02836a9eadb9fd175c0709dd4715b",
    dataType: "json",
    success: function(data) {
      var demData = data.demographics[0]["race ethnicity"];
      var districtName = data.district.name;
      setChart(demData, districtName, schoolYear);
    }
  });
}

function getDistrict(){
  var districtName = 'seattle-public-schools';
  var schoolYear = '2013-14';
  $('#district_slug').change(function(){
    districtName = this.value;
    getData(districtName, schoolYear);
  });
  $('.school-year-button').click(function(){
    schoolYear = this.id;
    getData(districtName, schoolYear);
  });
}

function setChart(demData, districtName, schoolYear ) {
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
  $('#district-demographics').highcharts({
    chart: {
      type: 'pie'
    },
    title: {
      text: districtName + ": " + schoolYear
    },
    series: [{
      name: 'Number of students:',
      colorByPoint: true,
      data: chartData
    }]
  });
}

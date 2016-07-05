$( document ).ready(function() {
  getDistrict();
});

function getData(districtSlug) {
  $.ajax({
    type: "GET",
    url: "/api/v1/demographics/district-in-year?slug=" + districtSlug + "&year=2012-13&api_key=60e02836a9eadb9fd175c0709dd4715b",
    dataType: "json",
    success: function(data) {
      var demData = data.demographics[0]["race ethnicity"];
      setChart(demData);
    }
  });
}

function getDistrict(){
  $('#district_slug').change(function(){
    getData(this.value);
  });
}

function setChart(demData) {
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
      text: 'test'
    },
    series: [{
      name: 'Number of students:',
      colorByPoint: true,
      data: chartData
    }]
  });
}

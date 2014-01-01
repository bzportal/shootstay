$(function () {
  $('.select2').select2({
    id: function(e) { return e.name + '|' + e.adminName1 + '|' + e.countryName },
    placeholder: 'Location',
    allowClear: false,
    width: '100%',
    minimumInputLength: 2,
    ajax: {
      url: 'http://ws.geonames.org/searchJSON',
      dataType: 'jsonp',
      data: function (term) {
        return {
          featureClass: 'P',
          q: term
        };
      },
      results: function (data) {
        return {
          results: data.geonames
        };
      }
    },
    formatResult: locationFormatResult,
    formatSelection: locationFormatSelection,
  });

  $('#new_request').validate();
});

$(function() {
  $('#new_property_image').fileupload({
    dataType: 'script',
    add: function(e, data) {
      var source = document.getElementById('template-upload').innerHTML;
      var template = Handlebars.compile(source);
      data.element = $(template({progress: 0}))
      $('#new_property_image').append(data.element);
      data.submit();
    },
    progress: function(e, data) {
      if (data.element) {
        var progress = parseInt((data.loaded / data.total * 100), 10);
        data.element.find('.progress-bar').attr('aria-valuenow', progress).css('width', progress).text(progress);
      }
    },
    done: function(e, data) {
      if (data.element) {
        data.element.fadeOut();
      }
    }
  });
})

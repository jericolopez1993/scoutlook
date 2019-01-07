(function( $ ){

  $.fn.dependsOn = function(element, value) {
    var elements = this;
    var hideOrShow = function() {
      var $this = $(this);
      var showEm;
      if ( $this.is('input[type="checkbox"]') ) {
        showEm = $this.is(':checked');
      } else if ($this.is('select')) {
        var fieldValue = $this.find('option:selected').val();
        if (typeof(value) == 'undefined') {
          showEm = fieldValue && $.trim(fieldValue) != '';
        } else if ($.isArray(value)) {
          showEm = $.inArray(fieldValue, value.map(function(v) {return v.toString()})) >= 0;
        } else {
          showEm = value.toString() == fieldValue;
        }
      }
      elements.toggle(showEm);
    }
    //add change handler to element
    $(element).change(hideOrShow);

    //hide the dependent fields
    $(element).each(hideOrShow);

    return elements;
  };

  $(function() {
    $('[data-depends-on]').each(function() {
      var $this = $(this);
      var master = $this.data('depends-on').toString();
      var value = $this.data('depends-on-value');
      console.log($this, master, value);
      if (typeof(value) != 'undefined') {
        $this.dependsOn(master, value);
      } else {
        $this.dependsOn(master);
      }
    });
  });

})( jQuery );

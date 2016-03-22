// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
// require turbolinks
// require jquery.turbolinks
//= require jquery_ujs
//= require ansi_up
//= require emmet
//= require_tree .

$(function(){

  // $("#create-script").on("submit", function(e){
  //   var $e = $(e.currentTarget)
  //   $e.find("textarea").text(
  //     $e.find("#script-content").text()
  //   )
  // })

  $("textarea").keydown(function(e) {
      if(e.keyCode === 9) { // tab was pressed
          // get caret position/selection
          var start = this.selectionStart;
          var end = this.selectionEnd;

          var $this = $(this);
          var value = $this.val();

          // set textarea value to: text before caret + tab + text after caret
          $this.val(value.substring(0, start)
                      + "\t"
                      + value.substring(end));

          // put caret at right position again (add one for the tab)
          this.selectionStart = this.selectionEnd = start + 1;

          // prevent the focus lose
          e.preventDefault();
      }
  });

  emmet.require('textarea').setup({
      pretty_break: true, // enable formatted line breaks (when inserting 
                          // between opening and closing tag) 
      use_tab: true,       // expand abbreviations by Tab key
  });

  $("body").html(
    ansi_up.ansi_to_html($("body").html())
  )

  // toggling wont work on some elements (inline?)
  // like <p>
  initToggleInitialState = function(){
    var $togglers = $('[toggles]')
    $.each($togglers, function(index, e){
      var $toggler = $(e)
      if (
        !($toggler.hasClass("start-open"))
      ) {
        var target = $toggler.attr("toggles")
        var $target = $toggler.siblings(target)
        $target.hide()
        $toggler.attr("hiding", "")
      }
    })
    $(".javascript-loader").remove()
  }

  // toggling wont work on some elements (inline?)
  // like <p>
  initTogglerListeners = function(){
    $(document).on("click", ("[toggles]"), function(e){
      var $toggler = $(e.currentTarget)
      var target = $toggler.attr("toggles")
      var $target = $toggler.siblings(target)
      if ($toggler[0].hasAttribute('hiding')){
        $toggler.removeAttr('hiding')
        $target.show()
      } else {
        $toggler.attr("hiding", "")
        $target.hide()
      }
    })
  }

  initToggleInitialState()
  initTogglerListeners()

})
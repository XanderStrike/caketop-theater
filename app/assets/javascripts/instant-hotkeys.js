// instant-hotkeys.js
//    Alex Standke
//    November 2015
//
// https://github.com/XanderStrike/instant-hotkeys

function InstantHotkeys() {
  var bindings = [];

  function sc(element, index, array) {
    return element.startsWith('hk-');
  }

  function getShortcode(classes) {
    return classes.split(" ").find(sc).replace('hk-', '')
  }

  // Bind all clickable elements: buttons and links
  this.bindClicks = function() {
    $("a[class*='hk-'], button[class*='hk-']").each(function(i) {
      var shortcode = getShortcode($(this).attr('class'))
      var link = $(".hk-"+shortcode)[0]
      label = $(link).attr('data-hk-label') || $(".hk-"+shortcode).text();

      bindings.push([shortcode,label]);
      $(document).bind('keydown', shortcode.replace('-', '+'), function() {
        link.click();
      });
    });
  }

  // Bind all focusable elements: inputs, textareas, selects
  this.bindFocus = function() {
    $("input[class*='hk-'], textarea[class*='hk-'], select[class*='hk-']").each(function(i) {
      var shortcode = getShortcode($(this).attr('class'))
      var input = $(".hk-"+shortcode)[0]
      label = $(input).attr('data-hk-label') || $(".hk-"+shortcode).attr('placeholder');

      bindings.push([shortcode,label]);
      $(document).bind('keyup', shortcode.replace('-', '+'), function() {
        input.focus();
      });
    });
  }

  // Bind all available elements
  this.bindAll = function() {
    this.bindClicks();
    this.bindFocus();
  }

  // List of bindings for building modals, etc
  this.bindings = bindings;

  // Output bindings to console.
  this.showBindings = function() {
    $.each(bindings, function() {
      console.log(this[0]+' bound to '+this[1])
    });
  }
}

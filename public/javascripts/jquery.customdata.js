/*
 * CustomData - jQuery plugin for parsing custom "data-" attribues from elements.
 *
 * Copyright (c) 2009 Martin Kleppe <kleppe@ubilabs.net>
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */

(function($, undefined) {
  
  var RE_DATA = /^data\-(.+)$/;
  
  var camelize = function(string) {
    var parts = string.split('-'), len = parts.length;
    if (len == 1) { return parts[0]; }

    var camelized = string.charAt(0) == '-'
      ? parts[0].charAt(0).toUpperCase() + parts[0].substring(1)
      : parts[0];

    for (var i = 1; i < len; i++) {
      camelized += parts[i].charAt(0).toUpperCase() + parts[i].substring(1);
    }

    return camelized;
  };
    
  var attributes = function(elem){
    var data = {};
    if (elem && elem.nodeType === 1) { 
      $.each(elem.attributes, function(index, attr){
        if (RE_DATA.test(attr.nodeName)){
          var key = attr.nodeName.match(RE_DATA)[1];
          data[camelize(key)] = attr.nodeValue;
        }
      });
    }
    return data;
  };
  
  $.extend({
    customdata: function(elem, key){
      var data = $(elem).data("customdata");
      if (!data) {
        data = attributes(elem);
        $(elem).data("customdata", data);
      }
      return key ? data[key] : data;
    }
  });

  /**
   * Returns the custom data object for the first member of the jQuery object.
   *
   * @name customdata
   * @descr Returns element's customdata object
   * @cat Plugins/CustomData
   */
  $.fn.customdata = function(key){
    return $.customdata(this[0], key);
  };
  
  $.expr[':'].customdata = function(elem, index, properties){
    var argument = properties[3];
    if (argument){ return $(elem).is("[data-" + argument + "]"); }
    
    if (elem && elem.nodeType === 1 && elem.attributes) {
      for ( var i = 0, l = elem.attributes.length; i < l; i++ ) {
        if (RE_DATA.test(elem.attributes[i].nodeName)){
          return true;
        }
      }
    }

    return false;
  };

})(jQuery);
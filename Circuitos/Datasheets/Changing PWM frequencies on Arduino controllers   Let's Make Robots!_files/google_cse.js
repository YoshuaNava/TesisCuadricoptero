// $Id: google_cse.js,v 1.1.2.4 2008/07/01 22:13:48 mfb Exp $
var googleCSEWatermark = function($id) {
  var f = document.getElementById($id);
  if (f && (f.query || f.q)) {
    var q = f.query ? f.query : f.q;
    var n = navigator;
    var l = location;
    if (n.platform == 'Win32') {
      q.style.cssText = 'border: 1px solid #7e9db9; padding: 2px;';
    }
    var b = function() {
      if (q.value == '') {
        q.style.background = '#FFFFFF url(http://www.google.com/coop/intl/' + Drupal.settings.googleCSE.locale[0] + '/images/google_custom_search_watermark.gif) left no-repeat';
      }
    };
    var f = function() {
      q.style.background = '#ffffff';
    };
    q.onfocus = f;
    q.onblur = b;
    if (!/[&?]query=[^&]/.test(l.search)) {
      b();
    }
  }
};
googleCSEWatermark('google-cse-searchbox-form');
googleCSEWatermark('google-cse-results-searchbox-form');

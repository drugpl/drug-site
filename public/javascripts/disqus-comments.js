$(document).ready(function() {
  var disqus = $("#disqus_thread");
  var disqus_shortname = "drugpl";
  var disqus_identifier = disqus.customdata("identifier");
  var disqus_url = disqus.customdata("url");
  var disqus_title = disqus.customdata("title");
  var disqus_developer = 1;
  
  var dsq = document.createElement('script'); 
  dsq.type = 'text/javascript'; 
  dsq.async = true;
  dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
  (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
});

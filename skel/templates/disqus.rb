<script>
(function() {
    var links = document.getElementsByTagName('a');
    var query = '?';
    for(var i = 0; i < links.length; i++) {
        if(links[i].href.indexOf('#disqus_thread') >= 0) {
            query += 'url' + i + '=' + encodeURIComponent(links[i].href) + '&';
        }
    }
    document.write('<script charset="utf-8" type="text/javascript" src="http://disqus.com/forums/<%= @disqus_subdomain %>/get_num_replies.js' + query + '"></' + 'script>');
})();
</script>
<section id="disqus_thread"></section>
<script type="text/javascript">
  (function() {
   var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
   dsq.src = 'http://<%= @disqus_subdomain %>.disqus.com/embed.js';
   (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
  })();
</script>
<noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript=<%= @disqus_subdomain %>">comments powered by Disqus.</a></noscript>
<a href="http://disqus.com" class="dsq-brlink">blog comments powered by <span class="logo-disqus">Disqus</span></a>

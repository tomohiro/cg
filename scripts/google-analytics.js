var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));

function startAnalytics() {
    try {
        var pageTracker = _gat._getTracker("UA-13275958-1");
        pageTracker._trackPageview();
    } catch(err) {}
}

if (window.addEventListener) {
    window.addEventListener('load', startAnalytics, false);  
} else if (window.attachEvent) {
    window.attachEvent('onload', startAnalytics);
}

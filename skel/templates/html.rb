<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=320">
        <link rel="stylesheet" media="screen, print" href="<%= @relative %>styles/reset-min.css">
        <link rel="stylesheet" media="screen, print" href="<%= @relative %>styles/fonts-min.css">
        <link rel="stylesheet" media="screen and (min-device-width: 481px), print" href="<%= @relative %>styles/cg.css">
        <link rel="stylesheet" media="only screen and (max-device-width: 480px)" href="<%= @relative %>styles/iphone.css">
        <!--[if IE]><link rel="stylesheet" media="screen, projection" href="<%= @relative %>styles/cg.css"><![endif]-->
        <!--[if lte IE 8]><script src="<%= @relative %>scripts/create-elements.js" type="text/javascript"></script><![endif]-->
        <title><%= @title %></title>
    </head>
    <body>
        <header>
          <h1><a href="http://<%= @domain %>"><%= @domain %></a></h1>
        </header>

        <nav>
            <ul>
                <li><a href="index.html">Index</a></li>
            </ul>
        </nav>

        <article>

<!-- Auto generated start -->

<%= @article %>

<!-- Auto generated end -->

        </article>

        <footer>
            <p>Copyright &#169; <%= Date.today.year %> <a href="mailto:tomohiro.t+github@gmail.com">Tomohiro</a> All rights reserved.</p>
            <p>Powerd by <a href="http://github.com/Tomohiro/cg" title="cg - A Ruby based ContentsGenerator">cg - A Ruby based contents generator</a></p>
        </footer>
    </body>
</html>

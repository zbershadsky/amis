<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>

<html>
  <head>
        <title>Buying products in the supermarket </title>
        <link href="<s:url value="/resources/styles/style.css" />" type="text/css" rel="stylesheet" />
        <script src="<s:url value="/resources/js/jquery-3.1.0.min.js" />" type="text/javascript"></script>
        <script src="<s:url value="/resources/js/main.js" />" type="text/javascript"></script>
  </head>
  <body>
    <div id="wrapper">
        <div id="header">
          <t:insertAttribute name="header" />
        </div>

        <t:insertAttribute name="body" />

    </div>
  </body>
</html>

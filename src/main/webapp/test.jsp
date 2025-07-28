<%@ page import="java.lang.System" %>
<html>
<body>
<pre>
Java Version: <%= System.getProperty("java.version") %>
Java Home: <%= System.getProperty("java.home") %>
Java Classpath: <%= System.getProperty("java.class.path") %>
</pre>
</body>
</html>

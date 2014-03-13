
<!--- Output --->
<cfheader name="Content-Type" value="text/xml">  
<cfoutput> 
<response showresponse="true"> 
<ide> 
<view id="cbox_livesearch" title="ColdBox Live Search" icon="includes/images/coldbox_logo.jpg" />
<body> 
<![CDATA[ 
<html>
<head>
	<base href="#controller.getBaseURL()#" />
	
	<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
</head>
<body>
	<script>
	  (function() {
	    var cx = '016428578290111247219:83ttrlkrtrw';
	    var gcse = document.createElement('script');
	    gcse.type = 'text/javascript';
	    gcse.async = true;
	    gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') +
	        '//www.google.com/cse/cse.js?cx=' + cx;
	    var s = document.getElementsByTagName('script')[0];
	    s.parentNode.insertBefore(gcse, s);
	  })();
	</script>
	<gcse:search></gcse:search>
</body>
</html>
]]> 
</body>
</ide> 
</response> 
</cfoutput>
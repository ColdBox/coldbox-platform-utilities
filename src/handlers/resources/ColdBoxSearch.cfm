
<!--- Output --->
<cfheader name="Content-Type" value="text/xml">  
<cfoutput> 
<response showresponse="true"> 
<ide> 
<dialog width="900" height="600" title="ColdBox Live Search" image="includes/images/ColdBox_Icon.png" />  
<body> 
<![CDATA[ 
<html>
<head>
	<base href="#request.baseURL#" />
	
	<link href="includes/css/styles.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="includes/js/jquery.latest.min.js"></script>
</head>
<body>
	<p><strong>Search for any kind of ColdBox related information, we dare you!</strong></p>
	
	<div id="cse" style="width: 100%;">Loading</div>
	<script src="http://www.google.com/jsapi" type="text/javascript"></script>
	<script type="text/javascript">
	  google.load('search', '1', {language : 'en'});
	  google.setOnLoadCallback(function(){
	    var customSearchControl = new google.search.CustomSearchControl('016428578290111247219:83ttrlkrtrw');
	    customSearchControl.setResultSetSize(google.search.Search.FILTERED_CSE_RESULTSET);
	    customSearchControl.draw('cse');
	  }, true);
	</script>
	<link rel="stylesheet" href="http://www.google.com/cse/style/look/default.css" type="text/css" />
</body>
</html>
]]> 
</body>
</ide> 
</response> 
</cfoutput>
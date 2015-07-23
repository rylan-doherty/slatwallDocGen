<cfcomponent displayname="toJSON" extends="definitions">

	<cffunction name="generate" access="public" returntype="void">
		
		<cfscript>
			createObject("java", "coldfusion.tagext.lang.SettingTag").setRequestTimeout(javaCast("double", 0));
			//Directory Listing
					
			writeDump(gatherMeta());
			fileWrite("/Users/rylandoherty/Desktop/jfile", SerializeJSON(gatherMeta()));
			//var test ="Slatwall.custom.model.service.AccessService";
			//var test2 ="Slatwall.model.service.AccessService";
			//var reader = getComponentMetaData(test);
			//writedump(var=reader, top="6");
			
			
		</cfscript>
		
	</cffunction>
	

</cfcomponent>
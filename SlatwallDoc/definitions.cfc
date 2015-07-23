component hint="" output="false" extends="Helper"   
{
			
			
	public any function gatherMeta(){
			var CustomDirectory = "/Users/rylandoherty/Sites/Slatwall/custom/model/";
			var ModelDirectory = "/Users/rylandoherty/Sites/Slatwall/model/";
		
			var list = "";
			var productList = {};
			var product = {};
			var customStr ={};
			var types = ["Entity", "Service", "Dao"];
			for(type in types)
			{
				list = getDotPathsFromFileListing(DirectoryList(CustomDirectory & type, true, "path", "*.cfc"));
				product = createPackedList(list, type);
				StructInsert(customStr, type, product);
			}
			StructInsert(productList, "Custom", customStr);
			
			for(type in types)
			{
				list = getDotPathsFromFileListing(DirectoryList(ModelDirectory & type, true, "path", "*.cfc"));
				product = createPackedList(list, type);
				StructInsert(productList, type, product);
			}
			return productList;
			}
	
	public any function createPackedList(list,type){
		
		var i = 1;
		var totalList=[];
		var packType = "";
		var except=[];
		
		
		packType="pack"&type&"(list[i])";
		
    	while (i<ArrayLen(list)){
    	arrayAppend(totalList,evaluate(packType));
    	i++;
    	}
    return totalList;
}
		
		private any function packDao(item){ 
		var relatedServices =[];
		var ext = [];
		var functions = [];
		var properties = [];
		var reader = "";
  		
  		var passit = {};
  		
		reader = findItemsMeta(item);
		//Add Name
  		StructInsert(passit, "Name",reader.name); 
		//Extends
		StructInsert(passit,"Extends",createExtendsList(reader));
		//Functions
		try{
		for(functs in reader.functions){
			arrayAppend(functions, functs);
		}
		StructInsert(passit,"Functions",functions);
		}catch(any e){}
		return passit;
	}
	
	private any function packService(item){
		var dao = "";
		var relatedServices =[];
		var ext = [];
		var functions = [];
		var properties = [];
		var reader = "";
  		
  		var passit = {};
  		
		reader = findItemsMeta(item);
		//Add Name
  		StructInsert(passit, "Name",reader.name); 
		//Extends
		StructInsert(passit,"Extends",createExtendsList(reader));
		//Dao and Related Service and Properties
		try{
		for(props in reader.properties){
			if(Find("DAO",props.name)){
				dao=props.name;
			}
			else if(Find("Service",props.name)){
				arrayAppend(relatedServices,props.name);
			}
			else{
				arrayAppend(properties,props);
			}
		}
		StructInsert(passit,"Dao",dao);
		StructInsert(passit,"Related Service",relatedServices);
		StructInsert(passit,"Properties",properties);
		}catch(any e){}
		//Functions
		try{
		for(functs in reader.functions){
			arrayAppend(functions, functs);
		}
		StructInsert(passit,"Functions",functions);
		}catch(any e){}
		return passit;
		
	}
	
	private any function packEntity(item){
		var nonPersistentProperties = [];
		var persistentProperties =[];
		var service = "";
		var processContexts = [];
		var functions = [];
		var reader = "";
  		
  		var passit = {};
  		
		reader = findItemsMeta(item);
		
		//Example for aid
		//if(reader.name=="Slatwall.model.entity.Account"){
		//writedump(reader);}
		
		
  		//Add Name
  		StructInsert(passit, "Name",reader.name); 
  		
  		
  		//Add Extends
  		StructInsert(passit, "Extends", createExtendsList(reader));
		
		
		//Add Properties
		for(properties in reader.properties){
			try{if (StructKeyExists(properties, "persistent")){
			if(properties.persistent=="false"){
				arrayAppend(nonPersistentProperties, properties);
			}
			}else{
				arrayAppend(persistentProperties,properties);
			}}catch(any e){}
		}
		StructInsert(passit, "Persistent Properties", persistentProperties);
		StructInsert(passit, "Non-Persistent Properties", nonpersistentProperties);
		
		
		//Process Contexts
		
		try{if(StructKeyExists(reader,"hb_processContexts")){
			var holderProcessContexts = reader.hb_processContexts;
			while(len(holderProcessContexts)>1){
			if (Find(",", reader.hb_processContexts, 1)>0){
				arrayAppend(processContexts,left(holderProcessContexts,Find(",", holderProcessContexts, 1)-1));
				holderProcessContexts = right(holderProcessContexts, len(holderProcessContexts)-Find(",", holderProcessContexts, 1));
				}
				else{
					arrayAppend(processContexts,left(holderProcessContexts,len(holderProcessContexts)));
					holderProcessContexts="";
				}}}}catch(any e){}
				finally{
					StructInsert(passit, "Process Contexts",processContexts);			
				}			
		
		//Functions 
		try{if(StructKeyExists(reader,"functions")){
			for(funct in reader.functions){
			arrayAppend(functions,funct);
			}
		}
		}catch(any e){}
		StructInsert(passit, "Functions",functions);
		return passit;
		
		
	}
	
	private any function createExtendsList(reader){
		
		var extList =[];
		var ext =[];
		extList=reader;
  		try { while(!StructIsEmpty(extList.extends)){
    	ArrayAppend(ext,extList.extends.fullname);
    	extList=extList.extends;
    	}} catch (any e) {}
    	return ext;
	}

}
/**
* Handles finding and serving Coldfusion Documentation Files
* @module slatwallDocs
* @class BaseDocumentationService 
*/
component hint="Handles finding and serving ColdFusion Documentation Files .cfc" output="false" extends="baseHelper"   
{
		
    
    	
	
	/**
	* This will return all a list of documentation for a file type such as .cfc
	*/
	public struct function getAllDocumentationItems()
	{
		var fList = {}; 
		var cfFileList = findAllColdFusionFiles();
		variables.Files = getDotPathsFromFileListing( cfFileList );
		var allDocumentationList = getDotPathsFromFileListing(variables.Files);
		
		return {list="#allDocumentationList#"};
	}
	
	/**
	* Returns the meta data for an item indexed by name.
	* @return The meta data for the file specified by fileName argument
	* @param name is the dot.path.name of the item to get meta for.
	*/
	
	public any function getDocumentationItemMeta( name="" )
	{
			return findItemsMeta( arguments.name );
	}
	
	/**
	*Helper method to get meta from a cold fusion source file.
	*/
	public any function findItemsMeta( name="" )
	{
			try 
			{
				var meta = getComponentMetaData("#arguments.name#");
				if (!StructIsEmpty(meta)){
					return meta;
				}else{
					return {error="There was an error retrieving the meta content for #arguments.name#."};
				}
			}catch(any e)
			{
				return {error="Unable to find documentation for #arguments.name#."};
			}
	}
	
	/**
	 * Simply returns all files stored in the File[] as dot path
	 */
	
	public any function getDotPathsFromFileListing( fileList )
	{
		var fFile = [];
		var allDocumentationItemsList = [];
		fileExtention=".cfc";
		fFile = arguments.fileList;
		//Iterate through the fileList and trim and remove and add to master array.
		for(var i = 1; i <= ArrayLen( fFile ); i++)
		{
			fFile[i] = replaceSlashesWithDots(fFile[i]);
			
		    var rightPadding = Len(variables.fileExtention);
			if(right( fFile[i], rightPadding ) == variables.fileExtention)
			{
				var finalName = trimAndRemoveExt(variables.fileExtention, fFile[i]);
				finalName = "Slatwall" & "." & finalName;
				ArrayAppend(AllDocumentationItemsList, finalName );
			}
			
			}
			
				return allDocumentationItemsList;		
	}
	
	/**
	 *@hint Removes the leading '/' and replaces the rest with '.'
	 *@return=Returns the filename as a dot path                         
	 */
	private any function replaceSlashesWithDots( fileName )
	{
		arguments.fileName = replace( arguments.fileName, "/", "" );
		arguments.fileName = replace( arguments.fileName, "/", ".", "all" );
		return arguments.fileName;
	}
	
	/**
	  * @Hint This scan the filesystem for all .cfc files.
	  * @Description Finds all the files starting with root.       
	  * @Return Array listing of all those files as array.         
	  */
	private Array function findAllColdFusionFiles()
	{
		var slatRoot = ExpandPath( "/" );
		var asc = "directory=ASC";
		var name = "*#variables.applicationName#*";
		var rootDirectory = slatRoot;
		var recurse = true;
		var listInfo = "name";
		var filter = asc; 
		return DirectoryList( rootDirectory, recurse, "array", "*.cfc", filter );
	}
	
	/**
	 * Takes a fileName with full path (Dot notation) and grabs the meta data
	 * and pushes it into the AllDocumentationItems.
	 */
	private any function addFileNameToArray( filePath )
	{
		var rightPadding = Len(variables.fileExtention);
			if(right( arguments.filePath, rightPadding ) == variables.fileExtention && find(variables.applicationName, arguments.filePath))
			{
				var finalName = trimAndRemoveExt(variables.fileExtention, arguments.filePath);
				finalName = variables.applicationName & "." & finalName;
				ArrayAppend( variables.AllDocumentationItemsList, finalName );
			}
	}
	
	/**
	 * Helper method trimAndRemoveExt
	 */
	private any function trimAndRemoveExt( ext , filePath) 
	{
		var splitToken = "Slatwall.";//For dev, will remove.
		var finalName = filePath.split( splitToken, 2 );
		var nameExtRemoved = replace( finalName[2], ".cfc", "" );
		//nameExtRemoved = replace( nameExtRemoved, "Slatwall.", "", "all");		
		return nameExtRemoved;
	}
	

	
	
	
	
	
}
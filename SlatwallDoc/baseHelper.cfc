/*
Slatwall - An Open Source eCommerce Platform
    Copyright (C) ten24, LLC
	
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
	
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
	
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this program statically or dynamically with other modules is
    making a combined work based on this program.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
	
    As a special exception, the copyright holders of this program give you
    permission to combine this program with independent modules and your 
    custom code, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting program under terms 
    of your choice, provided that you follow these specific guidelines: 

	- You also meet the terms and conditions of the license of each 
	  independent module 
	- You must not alter the default display of the Slatwall name or logo from  
	  any part of the application 
	- Your custom code must not alter or create any files inside Slatwall, 
	  except in the following directories:
		/integrationServices/

	You may copy and distribute the modified version of this program that meets 
	the above guidelines as a combined work under the terms of GPL for this program, 
	provided that you include the source code of that other code when and as the 
	GNU GPL requires distribution of source code.
    
    If you modify this program, you may extend this exception to your version 
    of the program, but you are not obligated to do so.

Notes:
*/
component hint="Super functionality and contract for Documentation Services" output="false"
	{
	variables.files = []; //Holds the list of all files
	variables.directories = []; //Holds the list of all directories
	variables.tags = []; //Holds a list of all found tags in a comment
	variables.applicationName = ""; //Application name (used in project root directory such as Slatwall)
	variables.fileExtension = ""; //The file extention to use when searching for comments
	variables.projectDirectory = ""; //The project directory to search for comments
	variables.currentDirectory = ""; //index of the current directory being searched
	variables.currentFile = ""; //index of the current file being searched.
	variables.currentDirectory = []; //Holds a list of the current directory being read from.
	variables.allDocumentationItemsList = []; //Holds a list of all documentation items found in the project as dot.path.name
	
	variables.annotations =
	{
		author="@author",
		contructor="@constructor",
		deprecated="@deprecated",
		exception="@exception",
		exports="@exports",
		param="@param",
		private="@private",
		returns="@returns",
		see="@see",
		this="@this",
		throws="@throws",
		version="@version",
		custom="@custom",
		ignore="@ignore",
		link="@link"
	};
	
	variables.customAnnotations = 
	{
		
	}; //Any custom annotations.
	
	/**
	* base init method saves data all extending components will need. Private so only provides super 
	functionality.
	*/
	private void function init(required applicationName="Slatwall", 
							   required fileExtention=".cfc", 
							   required projectDirectory="/"){
		variables.applicationName = arguments.applicationName;
		variables.fileExtention = arguments.fileExtention;
		variables.projectDirectory = arguments.projectDirectory;
	}
	
	/**
	* This will return all documentation items list for a file type such as .cfc or .js
	*/
	public struct function getAllDocumentationItems()
	{
		return {error="This should have been implemented"};
	}
	
	/**
	* Returns the meta data for an item indexed by name.
	* @return The meta data for the file specified by fileName argument
	* @param name is the dot.path.name of the item to get meta for.
	*/
	public any function getDocumentationItemMeta( name = "" )
	{
	if (ArrayContains(variables.allDocumentationItemsList, arguments.name)){
	return findItemsMeta(arguments.name);
	}
	}
	
	/**
	* This will return use private helper methods to find meta for some filetype as defined by someone 
	else.
	*/
	public any function findItemsMeta( name = "" )
	{
	return {error="This should have been implemented!"};
	}
	
	
}
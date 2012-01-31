﻿<cfoutput>
<!--- Load Assets --->
#html.addAsset(prc.cbroot&"/includes/ckeditor/ckeditor.js")#
#html.addAsset(prc.cbroot&"/includes/ckeditor/adapters/jquery.js")#
#html.addAsset(prc.cbroot&"/includes/css/date.css")#
<!--- Render Commong editor functions --->
#renderView(view="_tags/editors",prePostExempt=true)#
<!--- Custom Javascript --->
<script type="text/javascript">
$(document).ready(function() {
 	// pointers
	$entryForm 		= $("##entryForm");
	$excerpt		= $entryForm.find("##excerpt");
	$content 		= $entryForm.find("##content");
	$isPublished 	= $entryForm.find("##isPublished");
	// setup editors
	setupEditors( $entryForm );
});
function quickSave(){
	// Draft it
	$isPublished.val('false');
	
	// Validation first
	if( !$entryForm.data("validator").checkValidity() ){
		return false;
	}
	if( !$entryForm.find("##content").val().length ){
		alert("Please enter some content");
		return false;
	}
	
	// Activate Loader
	var $uploader = $("##uploadBarLoader");
	var $status = $("##uploadBarLoaderStatus");
	$status.html("Saving...");
	$uploader.slideToggle();
	
	// Post it
	$.post('#event.buildLink(prc.xehEntrySave)#', $entryForm.serialize(),function(data){
		// Save new id
		$entryForm.find("##contentID").val( data.contentID );
		// finalize
		$uploader.fadeOut(1500);
		$status.html('Entry Draft Saved!');
		$isPublished.val('true');
	},"json");
	
	return false;
}
</script>
</cfoutput>
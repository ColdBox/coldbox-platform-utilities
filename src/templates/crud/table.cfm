<cfoutput>
<table cellpadding="5" cellspacing="0" width="98%" border="1">
	<thead>
		<tr>
		<cfloop array="#metadata.properties#" index="thisProp">
			<cfif compareNoCase(thisProp.fieldType,"column") EQ 0>
			<th>#thisProp.name#</th>
			</cfif>
		</cfloop>
			<th width="110">Actions</th>
		</tr>
	</thead>
	<tbody>
		%cfloop array="##rc.#inputStruct.pluralName###" index="thisRecord">
		<tr>
			<cfloop array="#metadata.properties#" index="thisProp">
				<cfif compareNoCase(thisProp.fieldType,"column") EQ 0>
					<td>##thisRecord.get#thisProp.name#()##</td>
				</cfif>
			</cfloop>
			<!--- Actions --->
			<td>
				##html.startForm(action="#inputStruct.pluralname#.delete")##
					##html.hiddenField(name="#metadata.pk#",bind=thisRecord)##
					##html.submitButton(value="Delete",onclick="return confirm('Really Delete Record?')")##
					##html.href(href="#inputStruct.pluralName#.edit",queryString="#metadata.pk#=##thisRecord.get#metadata.pk#()##",text=html.button(value="Edit"))##
				##html.endForm()##
			</td>
		</tr>
		%/cfloop>
	</tbody>
</table>
</cfoutput>
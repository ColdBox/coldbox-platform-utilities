<cfoutput>
<h1>Contacts</h1>

<!--- MessageBox --->
<cfif flash.exists( "notice" )>
	<div class="alert alert-#flash.get( 'notice' ).type#">
		#flash.get( "notice" ).message#
	</div>
</cfif>

<!--- Create Button --->
#html.href( href="Contacts.new", text="Create Contact", class="btn btn-primary")#
#html.br(2)#

<!--- Listing --->

<table class="table table-hover table-striped">
	<thead>
		<tr>

			<th>firstname</th>

			<th>lastname</th>

			<th>email</th>

			<th width="150">Actions</th>
		</tr>
	</thead>
	<tbody>
		<cfloop array="#prc.Contacts#" index="thisRecord">
		<tr>

					<td>#thisRecord.getfirstname()#</td>

					<td>#thisRecord.getlastname()#</td>

					<td>#thisRecord.getemail()#</td>


			<td>
				#html.startForm(action="Contacts.delete")#
					#html.hiddenField(name="contactID", bind=thisRecord)#
					#html.submitButton(value="Delete", onclick="return confirm('Really Delete Record?')", class="btn btn-danger")#
					#html.href(href="Contacts.edit", queryString="contactID=#thisRecord.getcontactID()#", text="Edit", class="btn btn-info")#
				#html.endForm()#
			</td>
		</tr>
		</cfloop>
	</tbody>
</table>

</cfoutput>
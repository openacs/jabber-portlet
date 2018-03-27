 
<if @connstate@ eq -1>

<p><font color="red" size="2">The IM System is not available, please try it again later! </font> </p>
</if>
<if @connstate@ eq 0>

<if @not_registred@ eq true>
<table>
<tr><td bgcolor="#999999" align="center">
	       <font color='black'>Please fill in the form to register with Jabber!<br> You can change the system created Screen to what ever Screen you prefer, using the Carackters A to z , 0 to 9 or the "." (dot)  </font>
</tr></td>

<tr><td bgcolor="#999999" align="center">
<formtemplate id="user-register"></formtemplate>
</tr></td>
</div>
</if>

<if @user_is_online@ eq false>
<if @not_registred@ not eq true> 
<div align="center"><formtemplate id="user-login"></formtemplate></div>
</if>
</if>

<if @not_registred@ not eq true> 
<table align=center>
<tr>
     <multiple name=user_status>
      <td width='7%'> 
       <div align='center'><img src='jabber/image/@user_status.service@_@user_status.status@.gif' width='17' height='24'></div>
      </td>
     </multiple>
</tr>
</table>
</if>

<br>
<table align=center><tr align=center><td ><b>Community members online at:</b></td></tr></table>
<table align=center>

<tr><td>Jabber</td><td>Msn</td><td>Icq</td><td>Aim</td><td>Yahoo</td></tr>
<tr><td align=center>@jabber_number@</td><td align=center>@msn_number@</td><td align=center>@icq_number@</td><td align=center>@aim_number@</td><td align=center>@yahoo_number@</td>
<if @not_registred@ not eq true> 
<td><a href="jabber">List Members</a></td></tr>
</if>
</table>
<br>
<if @not_registred@ not eq true> 
<table align=center>
<tr><td align=left>
<a href='jabber/conference/make-group-conference-group.tcl?group_id=@community_id@&type=start_room&return_url=../../'>Enter Class Chat</a>
</td>
<td align=center><a href="jabber/doc">Documentation</a></td>
<td align=right>
<a href='jabber/conference/main.tcl?group_id=@community_id@'>View Logs</a>
</td>
</tr>
</table>
</if>
<else>
<div align='center'><a href="jabber/doc">Documentation</a></div>
</else>
</if>

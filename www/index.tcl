<p><b>Who's online?</b></p>
<if @connstate@ eq -1>
<p><font color="red" size="10">The IM System is not available, please try it again later!</font></p>
</if>
<a href='conference'>Go to the Conference facility</a>
<p>This page displays users, who are currently online. It differentiate between three user groups. Internal, registered Jabber users, who are on your buddy list including their
other Instant Messaging contacts. Then external friends, who are not registered in @system_name@, but you want to have on your buddy list. At last other internal, registered Jabber users, who are online. This provides you information, who is online, if you want to begin a chat. Furthermore you do not have to search internal users to add them to your buddy list, you have to click only on the link to add them to your friend list. 
</p>
<table width='400' border='0' bgcolor='#666666' cellpadding='1' cellspacing='0'>
 <tr>
  <td bgcolor='#333333'>
   <table width='400' border='0' bgcolor='#FFFFFF' cellpadding='0'>
    <tr bgcolor='#999999'> 
     <td colspan='5'><b><font color='#FFFFFF'>Your Messenger Status</font></b></td>
    </tr>
    <tr bgcolor='#FFFFFF'>
     <multiple name=user_status>
      <td width='7%'> 
       <div align='center'><img src='image/@user_status.service@_@user_status.status@.gif' width='17' height='24'></div>
      </td>
     </multiple>
    <tr bgcolor='#CCCCCC'> 
     <td colspan='5'> Log in to and out off the @system_name@ Jabber by clicking on the icon 
      <p>Note: The moment you log into the @system_name@ Jabber, you will automatically 
	 be logged into other services that you have authorised the Jabber 
         to connect with. At this point, the Jabber be your default messenger 
         for all services. Other instant messaging clients on your desktop 
	 will not work when you are logged in through the Jabber.
      </p>
       <if @jabber_start@ eq offline>
        <ul> 
	<li><a href='jabber-login?return_url=index'><font color='yellow'>Start Jabber Applet</font></a></li>
        <li><a href='jabber-webstart-login?return_url=index'><font color='yellow'>Webstart Jabber Applet</font></a></li>
        <li><a href='enigma.jnlp'><font color='yellow'>Webstart Enigma 3 (advanced)</font></a> </li>
<!--        <li><a href='jabber-login-greenthumb?return_url=index'><font color='yellow'>Start Greenthumb Applet</font></a></li> -->
       <li><a href='WebStart.html'><font color='blue'>Test if Webstart is installed on your Computer</font></a></li>
        </ul>
       </if>
       <else>
	<font color='green'>Jabber Applet Active</font>
       </else>	
       <if @user_invisible@ eq true>
	<ul>
       <li><a href="invisible.tcl?type=unset&return_url=@return_url@"><font color="yellow">Make myself visible to others</font></a></li>
        </ul> 
       </if>
	<else>
	<ul>
       <li><a href="invisible.tcl?type=set&return_url=@return_url@"><font color="yellow">Make myself invisible to others</font></a> </li>
	</ul>
	</else>
     </td>
    </tr>
   </table>
  <td>
   <table>
   <if @connstate@ eq 0>
    <if @reg_need@ eq 1>
     <tr>
      <td>
      <if @reg_error@ eq exists>
       <font color='red'>The screen name you typed in is already in use!</font>
      </if>
      <if @reg_error@ eq nothing>
       <font color='red'>Please fill in the form to register with Jabber!</font>
      </if> 
      </td>
     </tr>
     <tr>
      <td>
       <formtemplate id="user-register"></formtemplate>
      </td>
     </tr>
    </if>
    </if>
    </table>
   </td>
  </td>
 </tr>
 </table>
 <table width='500' border='0'>
 <if @reg_need@ not eq 1>
 <tr>
  <td>
   <a href="edit-user">Edit your contact information</a>
  </td>
  <td>
   <a href="view-external-contacts">View your external contacts</a>
  </td>
  <td>
   <a href="add-external-contact">Add a new external contact</a>
  </td>
  <td>
   <a href="user-search">Search for users</a>
  </td>
 </tr>
 </if>
 </table>
 <table width='700' border='0'>
  <tr> 
   <td>&nbsp;</td>
  </tr>
 </table>
 <if @friend_is_online_p@ eq 1>
 <table width='700' border='0' bgcolor='#666666' cellpadding='1' cellspacing='0'>
  <tr>
   <td>
    <table width='700' border='0' bgcolor='#FFFFFF'>
     <tr bgcolor='#999999'> 
      <td colspan='8'><b><font color='#FFFFFF'>Your Friends online</font></b></td>
     </tr>
     <multiple name="friend_status">
      <td width='20%'>@friend_status.first_names@ @friend_status.last_name@</td>
      <td width='20%'><a href='buddy-remove?friend_id=@friend_status.friend_user_id@&return_url=@return_url@'>Remove from list</a></td>
	<group column="friend_user_id">
	<if @friend_status.status@ not eq offline>
	 <if @friend_status.service@ eq aim>
	  <td width='10%'><div align='center'><a href='aim?screen=@friend_status.service@'>
         </if>
         <else>
          <td width='10%'><div align='center'><a href='message?screen=@friend_status.create_jid@&screen_id=@friend_status.friend_screen_id@'>
         </else>
         <img src='image/@friend_status.service@_@friend_status.status@.gif' width='18' height='25'></a>
         </div>
      	 </td>
	 </if>     
	 </group>
      	<td width='10%'><div align='center'><a href='@friend_status.chat@'>Chat</a> 
       </div>
      </td>
     </tr>
     </multiple>
    </if>
   </table>
   </td>
  </tr>
</table>
</if> 
<table width='700' border='0'>
 <tr>
  <td>&nbsp;</td>
 </tr>
</table>
<if @external_is_online_p@ eq 1>
<table width='700' border='0' bgcolor='#666666' cellpadding='1' cellspacing='0'>
  <tr>
    <td>
      <table width='700' border='0' bgcolor='#FFFFFF'>
        <tr bgcolor='#999999'> 
          <td colspan='8'><b><font color='#FFFFFF'>External Friends Online </font></b></td>
        </tr>
	<if @external_is_online_p@ eq "1" >
         
        <multiple name=external_status>
        <tr>
         <td width='20%'>@external_status.first_names@ @external_status.last_name@</td>
         <td width='20%'>Contact from IM-Addressbook</td>
	  <group column="combi_name">
	  <if @external_status.status@ not eq offline>
	   <if @external_status.service@ eq aim>
	    <td width='10%'><div align='center'><a href='aim?screen=@external_status.create_jid@'>
           </if>
	   <else>
            <td width='10%'><div align='center'><a href='message?screen=@external_status.create_jid@&screen_id=@external_status.friend_screen_id@'>
           </else>
	  </if>
           <img src='image/@external_status.service@_@external_status.status@.gif' width='18' height='25'></a>
           </div>
          </td>
	 </group>
        <td width='10%'><div align='center'>Click on Icon</div></td></tr>
        </multiple>
	</if>
      </table>
     </td>
    </tr>
   </table> 
   </if>
   <table width='700' border='0'>
    <tr>
     <td>&nbsp;</td>
    </tr>
  </table>
<p>If you want to see all community users online, who are not on your buddy list, follow this link: <a href="current-users-online"> Current Community users online</a></p>
<p><br>
  On a public Internet service, the number of casual surfers (unregistered) will
  outnumber the registered users by at least 10 to 1. Thus there could be many 
  more people using this service than it would appear. 
</p>
<p>
</p>

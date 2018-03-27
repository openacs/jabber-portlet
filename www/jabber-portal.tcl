

#reading the information from dotlrn
array set config $cf	

set shaded_p $config(shaded_p)
set list_of_package_ids $config(package_id)
#set one_instance_p [ad_decode [llength $list_of_package_ids] 1 1 0]
#set can_read_private_data_p [acs_privacy::user_can_read_private_data_p -object_id [ad_conn package_id]]


set reg_error "nothing"
set url_to_conference_group [jb_start_conference_room_for_group_url 15331]
set system_name [ad_system_name]
set trans_symbol [list]
set return_url [ad_conn url]
set context ""
set user_id [ad_conn user_id]
auth::require_login
set reg_need "0"
set connstate [jb_getconnstate]
set user_invisible [util::whos_online::check_invisible $user_id ]
set all_invisible [util::whos_online::all_invisible_user_ids]
if {[llength $all_invisible] == 0 } {lappend all_invisible  0}
set all_users [util::whos_online::all_user_ids]

#----------------------------------------------------check, whether user is registered-------------------------------------

if { ![db_0or1row is_user_reg_with_jabber { select (user_id) as reg_check, (uc.jabber_regstate) as reg_stat 
    from jb_user_jabber_information uc where user_id = :user_id }]} {
    set reg_need "1"
} 

ad_form -name user-register -action user-register -form {
    {jscreen:text(text) {label "Jabber Screen:<br>"}}
    {passwd:text(password) {label "Password:<br>"}}
    {return_url:text(hidden) {value "index"}}
}

#-----------------------------------------------------get available services--------------------------------------------------

db_foreach get_services { Select service from jb_services where active_check_p = 't'} {
    set user_states($service) "offline"
    set online_state($service) "offline"
    set online_state_name($service) $service
    set online_ext($service) "offline"
    set online_ext_name($service) $service
    set online_any($service) "offline"
    set online_any_name($service) $service
    append trans_symbol " $service"
}

#-------------------------------------get the different user states for the IM services-----------------------------------------

multirow create user_status service status 

db_foreach get_users_state {
    select lower(sn.status) as status,
    lower(sn.service) as service
    FROM jb_screens sn , jb_services
    WHERE sn.user_id = :user_id
    AND sn.service = jb_services.service
    AND jb_services.active_check_p = 't'
} {
    multirow append user_status $service $status 
    set user_states($service) $status
} if_no_rows {

    db_foreach get_services {
	select service 
	from jb_services 
	where active_check_p = 't'
    } {
	multirow append user_status $service "no"
	set user_states($service) "offline"
    }
    
}

set jabber_start "offline"

for {set j 0} { $j < [llength $trans_symbol]} {incr j} {
    if { [lindex $trans_symbol $j] == "jabber" } {
	if { [set user_states([lindex $trans_symbol $j])] == "offline"   } {
	    set jabber_start "offline"
	} else {
	    set jabber_start "online"
	}
    } 
    if { [lindex $trans_symbol $j] == "aim" } {
	if { [set user_states([lindex $trans_symbol $j])] != "offline"   } {
	    set aim_on 1
	} else {
	    set aim_on 0
	}
    } 
}     

#-------------------------------internal friend online ------------------------------------------------------------------------------

set friend_is_online_p 0
set onliners [util::whos_online::user_ids]

multirow create friend_status first_names last_name friend_user_id friend_screen_id service status create_jid chat


db_foreach get_a_friend "
    select (persons.person_id) as friends_user_id ,
    persons.first_names as first_names, persons.last_name as last_name 
    from persons 
    where persons.person_id IN (Select jb_screens.user_id from jb_screens, jb_friends
				where jb_friends.user_id = :user_id
				and jb_screens.screen_id = jb_friends.friend_screen_id
				and   jb_screens.user_id IS NOT NULL)
   AND  persons.person_id NOT IN [tcl_to_oracle_list $all_invisible] "  {

    lappend friends_online_list $friends_user_id


    db_foreach get_his_online_states "
	SELECT (sn.screen_id) as friend_screen_id,
	(sn.status) as status , 
	sn.im_screen_name,
	lower(sn.service) as service 
	FROM jb_screens sn  
	WHERE sn.user_id = :friends_user_id 
	AND   ( ( lower(sn.status) != 'offline' ) or   (sn.user_id IN [tcl_to_oracle_list $onliners])  ) 
	
    " {
	set online_state($service) $status
	multirow append friend_status $first_names $last_name $friends_user_id $friend_screen_id $service $status [jb_create_jid $im_screen_name $service] [jb_best_chat $friends_user_id]
	set friend_is_online_p 1    
    }

} 

#--------------------------External friends----------------------------------------------------------------------

set external_is_online_p 0

multirow create external_status friend_screen_id first_names last_name combi_name service status create_jid


db_foreach get_friends_users_online {
    select (ef.friend_screen_id) as ef_id , 
    (ef.friend_first_name) as first_names , 
    (ef.friend_last_name) as last_name 
    FROM jb_friends ef  
    WHERE ef.user_id = :user_id
    AND ef.friend_screen_id IN ( Select screen_id from jb_screens 
				where user_id is null )
} {

    db_foreach get_this_online_anys { select (sn.status) as status , 
	(sn.service) as service, sn.im_screen_name  
	FROM jb_screens sn 
	WHERE  sn.screen_id = :ef_id      
	AND  sn.status != 'offline'
    } {
	set online_ext($service) $status
	multirow append external_status $ef_id $first_names $last_name "$first_names $last_name" $service $status [jb_create_jid $im_screen_name $service]
	set external_is_online_p 1
    }

}



##cluster##
if {[ad_canonical_server_p] != 1 } {
    set canonical_p 0
    set canonical_address "http://[ad_parameter -package_id [ad_acs_kernel_id] CanonicalServer server-cluster]"
} else {
    set canonical_p 1
}
##cluster##


#reading the information from dotlrn
array set config $cf	

set shaded_p $config(shaded_p)
#set list_of_package_ids $config(package_id)
#set one_instance_p [ad_decode [llength $list_of_package_ids] 1 1 0]
#set can_read_private_data_p [acs_privacy::user_can_read_private_data_p -object_id [ad_conn package_id]]
#set comm_id $config(community_id)
set community_id [dotlrn_community::get_community_id_from_url]
 
set reg_error "nothing"
#set url_to_conference_group [jb_start_conference_room_for_group_url 15331]
set system_name [ad_system_name]
set trans_symbol [list]
set return_url [ad_conn url]
set context ""
set user_id [ad_conn user_id]
set reg_need "0"
set not_registred false

ad_maybe_redirect_for_registration

if {$canonical_p == 1} {
    set connstate [jb_getconnstate]
} else {
    set canonical_url "$canonical_address"
    append canonical_url "/SYSTEM/jb-getconnstate.tcl"
    set connstate [ns_httpget  $canonical_url]
}

set user_invisible [whos_online::check_invisible $user_id ]
set all_invisible [whos_online::all_invisible_user_ids]
if {[llength $all_invisible] == 0 } {lappend all_invisible  0}
set all_users [whos_online::all_user_ids]
 
#----------------------------------------------------check, whether user is registered-------------------------------------

if { ![db_0or1row is_user_reg_with_jabber { select (user_id) as reg_check, (uc.jabber_regstate) as reg_stat 
    from jb_user_jabber_information uc where user_id = :user_id }]} {
    set reg_need "1"


 set not_registred true
    
    ad_form -name user-register -action jabber/user-register -form {
    {jscreen:text(text) {label "Jabber Screen:<br>"} {value "[jb_get_leagel_screen $user_id]"}}
    {passwd:text(password) {label "Password:<br>"}}
    {return_url:text(hidden) {value "index"}}
}


}

#-----------------------------------------------------get avaiable services--------------------------------------------------

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

#-------------------------------------get the different user states for the IM services----------------------------------------
 



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
	    set user_is_online false
	    set after_login_url [ad_conn url]


	    template::form::create user-login -action "/jabber/jabber-login"
	    template::element::create user-login return_url -widget hidden -value "[ad_conn url]"
	    template::element::create user-login Login -widget submit -lable Login -value reg

	    
	} else {
	    set jabber_start "online"
	    set user_is_online true
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


set jabber_number 0
if { [db_0or1row number_of_onliners_jabber {SELECT count (js.status) as jabber_number 
                                       FROM group_distinct_member_map gdmm , jb_screens js, persons pe  
                                       WHERE gdmm.member_id = js.user_id
                                       AND gdmm.member_id = pe.person_id 
                                       AND js.service = 'jabber'
                                       AND js.status != 'offline'
    AND gdmm.group_id = :community_id } ] } {


     
}

set icq_number 0
if { [db_0or1row number_of_onliners_icq {SELECT count (js.status) as icq_number 
                                       FROM group_distinct_member_map gdmm , jb_screens js, persons pe  
                                       WHERE gdmm.member_id = js.user_id
                                       AND gdmm.member_id = pe.person_id 
                                       AND js.service = 'icq'
                                       AND js.status != 'offline'
    AND gdmm.group_id = :community_id } ] }  {


     
}


set msn_number 0
if { [db_0or1row number_of_onliners_msn {SELECT count (js.status) as msn_number 
                                       FROM group_distinct_member_map gdmm , jb_screens js, persons pe  
                                       WHERE gdmm.member_id = js.user_id
                                       AND gdmm.member_id = pe.person_id 
                                       AND js.service = 'msn'
                                       AND js.status != 'offline'
    AND gdmm.group_id = :community_id } ] }  {


     
}


set yahoo_number 0
if { [db_0or1row number_of_onliners_yahoo {SELECT count (js.status) as yahoo_number 
                                       FROM group_distinct_member_map gdmm , jb_screens js, persons pe  
                                       WHERE gdmm.member_id = js.user_id
                                       AND gdmm.member_id = pe.person_id 
                                       AND js.service = 'yahoo'
                                       AND js.status != 'offline'
    AND gdmm.group_id = :community_id } ] }  {


     
}



set aim_number 0
if { [db_0or1row number_of_onliners_aim {SELECT count (js.status) as aim_number 
                                       FROM group_distinct_member_map gdmm , jb_screens js, persons pe  
                                       WHERE gdmm.member_id = js.user_id
                                       AND gdmm.member_id = pe.person_id 
                                       AND js.service = 'aim'
                                       AND js.status != 'offline'
    AND gdmm.group_id = :community_id } ] }  {


     
}


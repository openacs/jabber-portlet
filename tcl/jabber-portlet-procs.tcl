
ad_library {

   Jabber Portal Library
  
   @author Bjoern Kiesbye
   @email bkiesbye@sussdorff-roy.com


} 
 

    namespace eval jabber_portlet {



    ad_proc -private get_my_name {
    } {
	return "jabber_portlet"
    }

    ad_proc -public get_pretty_name {
    } {
	return "Jabber"
    }

    ad_proc -private my_package_key {
    } {
        return "jabber-portlet"
    }

    ad_proc -public link {
    } {
	return "jabber"
    }

    ad_proc -public add_self_to_page {
	{-portal_id:required}
	{-package_id:required}
    } {
	Adds a Jabber PE to the given portal 
	( We don't need to append we have only one package_id at all )or appends the given Jabber package_id
        to the forums PE that already on the portal
     } {
        return [portal::add_element_parameters \
		    -portal_id $portal_id \
		    -portlet_name [get_my_name] \
		    -pretty_name [get_pretty_name] \
		    -value $package_id \
	       ]
    }

    ad_proc -public show {
	cf
    } {
    } {
        portal::show_proc_helper \
            -package_key [my_package_key] \
            -config_list $cf \
	    -template_src "jabber-portlet"
	
    }


    ad_proc -public edit {
    } { 
    } {

        #nothing
        return
    } 


    ad_proc -public remove_self_from_page {
	{portal_id:required}
	{package_id:required}
    } {
	Removes a Jabber PE from the given page or just the given jabber's package_id
    } {
        portal::remove_element_parameters \
            -portal_id $portal_id \
            -portlet_name [get_my_name] \
            -value $package_id
    }


	ad_proc -public new {
	    
	    Create a new Jabber instance for dotlrn , just return the single instace package_id.
	} { 
	    {-forum_id ""}
	    {-name:required}
	    {-charter ""}
	    {-presentation_type flat}
	    {-posting_policy open}
	    {-package_id:required}
	} {

	    
	    return [apm_package_id_from_key jabber]
	}
    
    


}




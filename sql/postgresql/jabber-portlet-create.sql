--  Copyrigth Bjoern Kiesbye
--  Author Bjoern Kiesbye
--  email: Kiesbye@theservice.de Bjoern_kiesbye@web.de 
--  This is free software distributed under the terms of the GNU Public
--  License version 2 or higher.  Full text of the license is available
--  from the GNU Project: http://www.fsf.org/copyleft/gpl.html

--  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
--  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
--  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
--  details.
--

--
-- /jabber-portlet/sql/postgresql/calendar-full-portlet-create.sql
--

-- Creates Jabber portlet

-- Copyright (C) 2004 Bjoern Kiesbye
-- @author Bjoern Kiesbye (kiesbye@theservice.de bjoern_kiesbye@web.de)
-- @creation-date 2004-07-18
-- ported to postres 2004-07-18


create function jabber_inline_0()
returns integer as '
declare
  ds_id portal_datasources.datasource_id%TYPE;
begin
  ds_id := portal_datasource__new(
         ''jabber_portlet'',
         ''Displays the jabber''
  );

  
  --  the standard 4 params

  -- shadeable_p 
  perform portal_datasource__set_def_param (
	ds_id,
	''t'',
	''t'',
	''shadeable_p'',
	''t''
);	



  -- shaded_p 	
  perform portal_datasource__set_def_param (
	ds_id,
	''t'',
	''t'',
	''shaded_p'',
	''f''
);	

  -- hideable_p 
    perform portal_datasource__set_def_param(
        ds_id,
        ''t'',
        ''t'',
        ''hideable_p'',
        ''t''
    );



  -- user_editable_p 
  perform portal_datasource__set_def_param (
	ds_id,
	''t'',
	''t'',
	''user_editable_p'',
	''f''
);	


  -- link_hideable_p 
  perform portal_datasource__set_def_param (
	ds_id,
	''t'',
	''t'',
	''link_hideable_p'',
	''t''
);	



   return 0;

end;' language 'plpgsql';
select jabber_inline_0();
drop function jabber_inline_0();

-------------------------------------------------------------------------------


create function jabber_inline_0()
returns integer as '
declare
	foo integer;
begin
	-- create the implementation
	foo := acs_sc_impl__new (
		''portal_datasource'',
		''jabber_portlet'',
		''jabber_portlet''
	);

   return 0;

end;' language 'plpgsql';
select jabber_inline_0();
drop function jabber_inline_0();


------------------------------------------------------------------------------

create function jabber_inline_0()
returns integer as '
declare
	foo integer;
begin

	-- add all the hooks
	foo := acs_sc_impl_alias__new (
	       ''portal_datasource'',
	       ''jabber_portlet'',
	       ''GetMyName'',
	       ''jabber_portlet::get_my_name'',
	       ''TCL''
	);

	foo := acs_sc_impl_alias__new (
	       ''portal_datasource'',
	       ''jabber_portlet'',
	       ''GetPrettyName'',
	       ''jabber_portlet::get_pretty_name'',
	       ''TCL''
	);

	foo := acs_sc_impl_alias__new (
	       ''portal_datasource'',
	       ''jabber_portlet'',
	       ''Link'',
	       ''jabber_portlet::link'',
	       ''TCL''
	);

	foo := acs_sc_impl_alias__new (
	       ''portal_datasource'',
	       ''jabber_portlet'',
	       ''AddSelfToPage'',
	       ''jabber_portlet::add_self_to_page'',
	       ''TCL''
	);

	foo := acs_sc_impl_alias__new (
	       ''portal_datasource'',
	       ''jabber_portlet'',
	       ''Show'',
	       ''jabber_portlet::show'',
	       ''TCL''
	);

	foo := acs_sc_impl_alias__new (
	       ''portal_datasource'',
	       ''jabber_portlet'',
	       ''Edit'',
	       ''jabber_portlet::edit'',
	       ''TCL''
	);

	foo := acs_sc_impl_alias__new (
	       ''portal_datasource'',
	       ''jabber_portlet'',
	       ''RemoveSelfFromPage'',
	       ''jabber_portlet::remove_self_from_page'',
	       ''TCL''
	);

   return 0;

end;' language 'plpgsql';
select jabber_inline_0();
drop function jabber_inline_0();


-------------------------------------------------------------------------------


create function jabber_inline_0()
returns integer as '
declare
	foo integer;
begin

	-- Add the binding
	perform acs_sc_binding__new (
	    ''portal_datasource'',
	    ''jabber_portlet''
	);

   return 0;

end;' language 'plpgsql';
select jabber_inline_0();
drop function jabber_inline_0();



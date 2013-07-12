require "hydra"

# The following lines determine which user attributes your hydrangea app will use
# This configuration allows you to use the out of the box ActiveRecord associations between users and user_attributes
# It also allows you to specify your own user attributes
# The easiest way to override these methods would be to create your own module to include in User
# For example you could create a module for your local LDAP instance called MyLocalLDAPUserAttributes:
#   User.send(:include, MyLocalLDAPAttributes)
# As long as your module includes methods for full_name, affiliation, and photo the personalization_helper should function correctly
#

if Hydra.respond_to?(:configure)
  Hydra.configure(:shared) do |config|
 
    # Empty since we aren't actually using this piece. Maybe it can fit in later if the
    # user interface can be retooled
    #config[:submission_workflow] = {}
        
    # This specifies the solr field names of permissions-related fields.
    # You only need to change these values if you've indexed permissions by some means other than the Hydra's built-in tooling.
    # If you change these, you must also update the permissions request handler in your solrconfig.xml to return those values
    config[:permissions] = {
      :catchall => "access_tesim",
      :discover => {:group =>"discover_access_group_tesim", :individual=>"discover_access_person_tesim"},
      :read => {:group =>"read_access_group_tesim", :individual=>"read_access_person_tesim"},
      :edit => {:group =>"edit_access_group_tesim", :individual=>"edit_access_person_tesim"},
      :owner => "depositor_tesim",
      :embargo_release_date => "embargo_release_date_dtsi"
    }
    config[:permissions][:inheritable] = {
      :discover => {:group =>"inheritable_discover_access_group_tesim", :individual=>"inheritable_discover_access_person_tesim"},
      :read => {:group =>"inheritable_read_access_group_tesim", :individual=>"inheritable_read_access_person_tesim"},
      :edit => {:group =>"inheritable_edit_access_group_tesim", :individual=>"inheritable_edit_access_person_tesim"},
      :owner => "inheritable_depositor_tesim",
      :embargo_release_date => "inheritable_embargo_release_date_dtsi"
    }
  end
end

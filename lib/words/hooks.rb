module MyPlugin
    class HelpDeskHooksListener < Redmine::Hook::ViewListener
    
        
        def controller_issues_new_before_save(context={})


        end

        
        def controller_issues_new_after_save(context={})
            # get required projects from rules
            required_projects = []
            Word.where('name like ?', 'project').each do |record|
                required_projects << record.object_id
            end
            # get current project
            current_project = [] << Issue.find(context[:issue].id).project.id
          
            project_decision = !(required_projects & current_project).empty?
         

            # get current role
            required_roles = []
            Word.where('name like ?', 'role').each do |record|
                required_roles << record.object_id
            end
            # current_uer_role = User.current.id
            current_roles = []
            User.current.roles.each do |record|
                current_roles << record.id
            end
            role_decision = !(required_roles & current_roles).empty?
   

            # get current group
            required_groups = []
            Word.where('name like ?', 'group').each do |record|
                required_groups << record.object_id
            end
            current_groups = []
            User.current.groups.each do |record|
                current_groups << record.id
            end
            group_decision = !(required_groups & current_groups).empty?
       

            # get current tracker
            required_trackers = []
            Word.where('name like ?', 'tracker').each do |record|
                required_trackers << record.object_id
            end
            current_tracker = [] << Issue.find(context[:issue].id).tracker.id
            tracker_decision = !(required_trackers & current_tracker).empty?
       
            
            if project_decision || role_decision || group_decision || tracker_decision
                unless context[:issue].attachments.first.nil?
                    issue_id = context[:issue].id
                    issue = Issue.find(issue_id)

                    filename = issue.attachments.first.disk_filename
                    path = issue.attachments.first.disk_directory
                    
                    
                    WordsWorker.perform_async(issue_id, path, filename)
                end
            end

        end

    end
end
   
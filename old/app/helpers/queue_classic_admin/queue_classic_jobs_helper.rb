module QueueClassicAdmin
  module QueueClassicJobsHelper
    def q_name_pill_class(name)
      if params[:q_name] == name
        "active"
      else
        ""
      end
    end
  end
end

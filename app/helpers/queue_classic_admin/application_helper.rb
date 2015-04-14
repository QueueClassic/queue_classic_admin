module QueueClassicAdmin
  module ApplicationHelper
    def sortable_column(name, title)
      opts = {sort: name}
      opts[:dir] = (params[:dir] == "asc" ? "desc" : "asc")
      content_tag :th do
        s = link_to title, params.merge(opts)
        if params[:sort] == name.to_s
          icon = if params[:dir] == 'asc'
            "&uarr;"
          else
            "&darr;"
          end
          s += raw(icon)
        end
        s.html_safe
      end
    end
  end
end

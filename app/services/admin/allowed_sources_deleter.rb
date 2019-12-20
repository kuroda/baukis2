class Admin::AllowedSourcesDeleter
  def delete(params)
    if params && params[:allowed_sources].kind_of?(Hash)
      ids = []

      params[:allowed_sources].values.each do |hash|
        if hash[:_destroy] == "1"
          ids << hash[:id]
        end
      end

      if ids.present?
        AllowedSource.where(namespace: "staff", id: ids).delete_all
      end
    end
  end
end

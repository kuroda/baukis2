shared_examples "a protected staff controller" do |controller|
  let(:args) do
    {
      host: Rails.application.config.baukis2[:admin][:host],
      controller: controller
    }
  end

  describe "#index" do
    example "ログインフォームにリダイレクト" do
      get url_for(args.merge(action: :index))
      expect(response).to redirect_to(staff_login_url)
    end
  end

  describe "#show" do
    example "ログインフォームにリダイレクト" do
      get url_for(args.merge(action: :show, id: 1))
      expect(response).to redirect_to(staff_login_url)
    end
  end
end

shared_examples "a protected singular staff controller" do |controller|
  let(:args) do
    {
      host: Rails.application.config.baukis2[:staff][:host],
      controller: controller
    }
  end

  describe "#show" do
    example "ログインフォームにリダイレクト" do
      get url_for(args.merge(action: :show))
      expect(response).to redirect_to(staff_login_url)
    end
  end
end

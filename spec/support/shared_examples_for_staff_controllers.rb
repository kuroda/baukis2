shared_examples "a protected staff controller" do
  describe "#index" do
    example "ログインフォームにリダイレクト" do
      get :index
      expect(response).to redirect_to(staff_login_url)
    end
  end

  describe "#show" do
    example "ログインフォームにリダイレクト" do
      get :show, params: { id: 1 }
      expect(response).to redirect_to(staff_login_url)
    end
  end
end

shared_examples "a protected singular staff controller" do
  describe "#show" do
    example "ログインフォームにリダイレクト" do
      get :show
      expect(response).to redirect_to(staff_login_url)
    end
  end
end

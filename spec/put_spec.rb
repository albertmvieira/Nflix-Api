describe "post" do
  context "When a registered user" do
    # Será utilizado o before all para facilitar a utilização de um usuário para ser atualizado
    before(:all) do
      original_user = build(:registered_user)
      token = ApiUser.token(original_user.email, original_user.password)
      @new_user = build(:user)
      puts @new_user.to_hash
      @result_put = ApiUser.update(token, original_user.id, @new_user.to_hash)
      @result_get = ApiUser.find(token, original_user.id)
    end

    it { expect(@result_put.response.code).to eql "200" }
    it { expect(@result_get.parsed_response["full_name"]).to eql @new_user.full_name } #Comparando com o dado da massa de teste
    it { expect(@result_get.parsed_response["email"]).to eql @new_user.email } #Comparando com o dado da massa de teste
  end
end
